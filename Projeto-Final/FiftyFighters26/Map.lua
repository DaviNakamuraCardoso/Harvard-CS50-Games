--============================== Map Class ===================================--


Map = Class{}


require 'backgrounds'


function Map:init(name)
    self.maps = {}
    local index = 1
    for k, v in pairs(Backgrounds) do
        self.maps[index] = k
        index = index + 1
    end

    self.name = name


    self:updateReferences()

    --//____________________________ Players _______________________________\\--

    -- Creates the players
    self.player1 = Player(self, 'Athena-Asamiya', -1)
    self.player2 = Player(self, 'Bonne-Jenet', 1)

    -- Sets each one as other's enemy
    self.player1.enemy = self.player2
    self.player2.enemy = self.player1

    --\\____________________________________________________________________//--


    --//__________________________ Buttons _________________________________\\--

        --//                      Main Menu                            \\--

    self.buttonPlay = Button{
        map = self,
        label = 'Play',
        action = function()
            self.state = 'player1_select'
        end
    }

    --//                       Characters                            \\--

    self.charactersButtons = {}
    self.charactersImages = {
        ['image'] = {},
        ['quad'] = {}
    }
    local names = {}
    local index = 1
    for k, v in pairs(Characters) do
        names[index] = k
        index = index + 1
    end
    names[index] = '???'
    local counter = 1
    Characters['???'] = {}
    for k, v in pairs(Characters) do
        self.charactersButtons[k] = Button{
            label = k,
            imageSource = 'graphics/' .. k .. '/portrait.png',
            map = self,
            action = function()
                self.charactersButtons[k].active = false
                if self.state == 'player1_select' then
                    self.player1 = Player(self, k, -1)
                    self.state = 'player2_select'
                    self.active = false
                elseif self.state == 'player2_select' then
                    self.player2 = Player(self, k, 1)
                    self.state = 'next'
                    self.active = false
                end
            end,
            relativeX = counter % 9 * 40 + 55,
            relativeY = math.floor(counter/9-0.1) * 35 + 20,
            border = {2, 2},
            noLabel = true

        }
        self.charactersImages['image'][k] = love.graphics.newImage('graphics/'.. k .. '/body.png')
        self.charactersImages['quad'][k] = love.graphics.newQuad(0, 0, self.charactersImages['image'][k]:getWidth(), self.charactersImages['image'][k]:getHeight(), self.charactersImages['image'][k]:getDimensions()
        )
        counter = counter + 1
    end


    -- Swaping the ? with the 21th (center) button
    self.charactersButtons['Whip'].relativeX = 21 % 9 * 40 + 55
    self.charactersButtons['???'].relativeX = 22 % 9 * 40 + 55
    self.next = Button{
        label = 'Next',
        action = function()
            self.state = 'loading'
        end,
        map = self,
        relativeX = VIRTUAL_WIDTH - 110,
        relativeY = VIRTUAL_HEIGHT - 40,
        active = false
    }
    self.next.active = false
    self.next.color = self.next.inactiveColor
    --//                            Pause                              \\--
--    self.pause = Button{
--        map = self,
--        label = 'pause',
--        im
--    }
    --\\____________________________________________________________________//--

    --//_________________________ Music and Sounds _________________________\\--

    -- Music
    self.music = love.audio.newSource('music/' .. tostring(math.random(3)) .. '.wav', 'static')
    self.music:play()
    self.music:setLooping(true)

    -- Sounds
    self.sounds = {
        ['countdown'] = love.audio.newSource('sounds/map/321fight.wav', 'static')
    }
    for i=1, 5 do
        self.sounds['round' .. tostring(i)] = love.audio.newSource('sounds/map/round' .. tostring(i) .. '.wav', 'static')
    end

    self.sounds['finish_male'] = love.audio.newSource('sounds/map/finishmale.wav', 'static')
    self.sounds['finish_female'] = love.audio.newSource('sounds/map/finishfemale.wav', 'static')

    for _, sound in pairs(self.sounds) do
        sound.setVolume(sound, 10)
    end

    --\\____________________________________________________________________//--

    --//_____________________________ Messages _____________________________\\--
    self.title = Message{
        map = self,
        text = 'Fifty Fighters',
        size = 50,
        font = 'strikefighter.ttf',
        relativeY = 0
    }

    self.h2 = Message{
        map = self,
        text = 'Player 1 Select',
        size = 40,
        font = 'strikefighter.ttf',
        relativeY = 30
    }

    self.fight = Message{
        map = self,
        text = 'Fight!',
        size = 40,
        font = 'fighter.ttf',
        relativeY = 30,
        show = 'twinkle'
    }

    --\\____________________________________________________________________//--

    self.loadingBarWidth = 0
    self.loadingBarHeight = 20
    self.loading = 0
    self.loaded = false



    --//_____________________ States and Behaviors _________________________\\--
    self.enemiesUpdated = false
    self.behaviors = {
        ['menu'] = function(dt)
            local mouseX = love.mouse.getX() * VIRTUAL_WIDTH / WINDOW_WIDTH
            local mouseY = love.mouse.getY() * VIRTUAL_HEIGHT / WINDOW_HEIGHT
            self.title:update(dt)
            self:updateCam()
            self.buttonPlay:update(mouseX, mouseY)
        end,
        ['player1_select'] = function(dt)
            local mouseX = love.mouse.getX() * VIRTUAL_WIDTH / WINDOW_WIDTH
            local mouseY = love.mouse.getY() * VIRTUAL_HEIGHT / WINDOW_HEIGHT
            self:updateCharacterButtons(mouseX, mouseY)
            self.h2:update(dt)
            self.next:update(mouseX, mouseY)
        end,
        ['player2_select'] = function(dt)
            local mouseX = love.mouse.getX() * VIRTUAL_WIDTH / WINDOW_WIDTH
            local mouseY = love.mouse.getY() * VIRTUAL_HEIGHT / WINDOW_HEIGHT
            self:updateCharacterButtons(mouseX, mouseY)
            self.h2:update(dt)
            self.h2.text = 'Player 2 Select'
            self.next:update(mouseX, mouseY)
        end,
        ['next'] = function(dt)
            local mouseX = love.mouse.getX() * VIRTUAL_WIDTH / WINDOW_WIDTH
            local mouseY = love.mouse.getY() * VIRTUAL_HEIGHT / WINDOW_HEIGHT
            self.next.active = true
            self.next:update(mouseX, mouseY)
            self.player1.enemy = self.player2
            self.player2.enemy = self.player1
        end,
        ['loading'] = function(dt)
            if not self.loaded then
                self.name = self.maps[math.random(#self.maps)]
                self:updateReferences()
                self:updateCam()

                self.loaded = true
                self.h2.text = 'Loading...'
                self.h2:update(dt)
                love.audio.setVolume(0.01)
            end

            self:updateLoad(dt)
        end,
        ['prepare'] = function(dt)
            self.h2.text = '3'
            love.audio.setVolume(0.15)
            self.sounds['round' .. tostring(self.round)]:play()
            self:wait(2, function() self.state = 'countdown' end, dt)
            self:play(dt)
        end,
        ['countdown'] = function(dt)
            self.sounds['countdown']:play()
            self.h2:update(dt)
            self:wait(5, function() self.state = 'play' end, dt)
            self:play(dt)


        end,
        ['play'] = function(dt)
            self:play(dt)
            self.fight:update(dt)
        end,
        ['pause'] = function(dt)
            self.pauseButton:update()
        end



    }

    self.renders = {
        ['menu'] = function()
            self.buttonPlay:render()
            self.title:render()
        end,
        ['play'] = function()
            self:playRender()
            self.fight:render()
        end,
        ['player1_select'] = function()
            love.graphics.draw(self.backgroundImage, self.backgroundQuads[self.currentFrame], 0, 0)
            self:renderCharacterButtons()
            self.h2:render()
            self.next:render()
        end,
        ['player2_select'] = function()
            love.graphics.draw(self.backgroundImage, self.backgroundQuads[self.currentFrame], 0, 0)
            self:renderCharacterButtons()
            self.h2:render()
            self.next:render()
        end,
        ['next'] = function()
            love.graphics.draw(self.backgroundImage, self.backgroundQuads[self.currentFrame], 0, 0)
            self:renderCharacterButtons()
            self.next:render()

        end,
        ['loading'] = function()
            love.graphics.clear(198 / 255, 201 / 255, 227 / 255, 1)
            love.graphics.rectangle('fill', self.camX + VIRTUAL_WIDTH / 2 - 100, self.camY + VIRTUAL_HEIGHT / 3, self.loadingBarWidth, self.loadingBarHeight)
            love.graphics.rectangle('line', self.camX + VIRTUAL_WIDTH / 2 - 100 - 2, self.camY + VIRTUAL_HEIGHT / 3 - 2, 204, 24)
            self.h2:render()
        end,
        ['pause'] = function()
            self.player1:render()
            self.player2:render()
            self:cover()
        end,
        ['countdown'] = function()
            self:playRender()
            self.h2:render()
        end,
        ['prepare'] = function()
            self:playRender()
        end
    }

    self.state = 'menu'


end


function Map:render()
    self.renders[self.state]()
end


function Map:update(dt)
    self.behaviors[self.state](dt)
    self:updateAnimation(dt)
end


function Map:updateCam()

    -- Updating the cam position based on the players
    if  math.max(self.player1.x - self.player2.x, self.player2.x - self.player1.x) <= VIRTUAL_WIDTH - 100  then
        if self.player1.x <= self.camX or self.player2.x <= self.camX then

            self.camX = math.max(0, math.min(self.mapWidth - VIRTUAL_WIDTH,         math.max(math.min(self.player1.x, self.player2.x), math.max(self.player1.x,     self.player2.x) - VIRTUAL_WIDTH + 100)))

        elseif self.player1.x >= self.camX + VIRTUAL_WIDTH - 100 or self.player2.x >=   self.camX + VIRTUAL_WIDTH - 100 then
            self.camX = math.max(0, math.min(self.mapWidth - VIRTUAL_WIDTH,         math.min(math.min(self.player1.x, self.player2.x), math.max(self.player1.x,     self.player2.x) - VIRTUAL_WIDTH + 100)))
        end
    end
    self.camY = self.mapHeight - VIRTUAL_HEIGHT
end


function Map:updateAnimation(dt)
    if self.timer >= self.interval then
        self.timer = 0
        self.currentFrame = (self.currentFrame + 1) % (#self.backgroundQuads)
    else
        self.timer = self.timer + dt
    end

end


function Map:updateLoad(dt)
    if self.loading >= 20 then
        self.state = 'prepare'
        self.player1.state = 'start'
        self.player2.state = 'start'
        self.h2.show = 'count'


    else
        self.loading = self.loading + dt
    end
    self.loadingBarWidth = self.loading * 200 / 20
end


function Map:cover()
    -- Draws a black cover in the screen
    love.graphics.setColor(0, 0, 0, 0.8)
    love.graphics.rectangle('fill', 0, self.camY, WINDOW_WIDTH, WINDOW_HEIGHT)
    love.graphics.setColor(1, 1, 1, 1)
end


function Map:updateCharacterButtons(mouseX, mouseY)
    for k, v in pairs(self.charactersButtons) do
        v:update(mouseX, mouseY)
    end
end


function Map:renderCharacterButtons()
    for k, v in pairs(self.charactersButtons) do
        v:render()

    end
    if self.state == 'player2_select' then

        love.graphics.draw(self.charactersImages['image'][self.player1.name], self.charactersImages['quad'][self.player1.name], self.camX + 20 + self.charactersImages['image'][self.player1.name]:getWidth() / 2, self.camY + VIRTUAL_HEIGHT - self.charactersImages['image'][self.player1.name]:getHeight() / 2 - 10, 0, -1, 1, self.charactersImages['image'][self.player1.name]:getWidth() / 2, self.charactersImages['image'][self.player1.name]:getHeight() / 2)
    elseif self.state == 'next' then
        love.graphics.draw(self.charactersImages['image'][self.player1.name], self.charactersImages['quad'][self.player1.name], self.camX + 20 + self.charactersImages['image'][self.player1.name]:getWidth() / 2, self.camY + VIRTUAL_HEIGHT - self.charactersImages['image'][self.player1.name]:getHeight() / 2 - 10, 0, -1, 1, self.charactersImages['image'][self.player1.name]:getWidth() / 2, self.charactersImages['image'][self.player1.name]:getHeight() / 2)

        love.graphics.draw(self.charactersImages['image'][self.player2.name], self.charactersImages['quad'][self.player2.name], self.camX + 20 + VIRTUAL_WIDTH / 2 +   self.charactersImages['image'][self.player2.name]:getWidth() / 2, self.camY + VIRTUAL_HEIGHT - self.charactersImages['image'][self.player2.name]:getHeight() / 2 - 10, 0, 1, 1,  self.charactersImages['image'][self.player2.name]:getWidth() / 2, self.charactersImages['image'][self.player2.name]:getHeight() / 2)
    end
end


function Map:updateReferences()

    --//___________________________ Rounds _________________________________\\--
    self.rounds = {}
    self.round = 1

    --//______________________ Camera and Dimensions _______________________\\--

    -- Dimensions
    self.mapWidth = Backgrounds[self.name]['width']
    self.mapHeight = Backgrounds[self.name]['height']

    -- Camera
    self.camX = self.mapWidth / 2 - VIRTUAL_WIDTH / 2
    self.camY = self.mapHeight - VIRTUAL_HEIGHT

    -- Floor and gravity
    self.floor = self.mapHeight - 10
    self.gravity = 800

    --\\____________________________________________________________________//--

    --//____________________________ Animation ____________________________\\--

    self.backgroundImage = love.graphics.newImage('graphics/Backgrounds/' .. self.name .. '.png')
    self.backgroundQuads = generateQuads('graphics/Backgrounds/' .. self.name .. '.png', self.mapWidth, self.mapHeight)
    self.currentFrame = 1
    self.timer = 0
    self.interval = 0.2


    --\\____________________________________________________________________//--

    --//________________________ Sound and Music ___________________________\\--
    love.audio.setVolume(0.15)

    -- Effects
    self.sound = love.audio.newSource('music/' .. self.name .. '.wav', 'static')
    self.sound:play()
    self.sound:setLooping(true)


    self.waitTimer = 0
end


function Map:wait(time, action, dt)
    if self.waitTimer >= time then
        action()
    else
        self.waitTimer = self.waitTimer + dt
    end

end


function Map:play(dt)
    self:updateCam()
    self.player1:update(dt)
    self.player2:update(dt)
end


function Map:playRender()

    -- Draws then background current frame
    love.graphics.draw(self.backgroundImage, self.backgroundQuads[self.currentFrame], 0, 0)

    -- Renders the players' lifebars
    self.player1.lifebar:render()
    self.player2.lifebar:render()

    -- Renders the players
    self.player1:render()
    self.player2:render()

    -- Renders the projectiles
    self.player1:renderAllProjectiles()
    self.player2:renderAllProjectiles()

end
--============================================================================--
