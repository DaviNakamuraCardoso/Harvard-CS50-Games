--============================== Map Class ===================================--


Map = Class{}

require 'backgrounds'

SCROOL_SPEED = 0
function Map:init(name)

    self.name = name

    --//______________________ Camera and Dimensions _______________________\\--

    -- Dimensions
    self.mapWidth = Backgrounds[self.name]['width']
    self.mapHeight = Backgrounds[self.name]['height']

    -- Camera
    self.camX = self.mapWidth / 2 - VIRTUAL_WIDTH / 2
    self.camY = self.mapHeight - VIRTUAL_HEIGHT

    -- Floor and gravity
    self.floor = self.mapHeight
    self.gravity = 800

    --\\____________________________________________________________________//--

    --//____________________________ Animation ____________________________\\--

    self.backgroundImage = love.graphics.newImage('graphics/Backgrounds/' .. self.name .. '.png')
    self.backgroundQuads = generateQuads('graphics/Backgrounds/' .. self.name .. '.png', self.mapWidth, self.mapHeight)
    self.currentFrame = 1
    self.timer = 0
    self.interval = 0.2


    --\\____________________________________________________________________//--

    --//____________________________ Players _______________________________\\--

    -- Creates the players
    self.player1 = Player(self, 'Athena', -1)
    self.player2 = Player(self, 'Bonne', 1)

    -- Sets each one as other's enemy
    self.player1.enemy = self.player2
    self.player2.enemy = self.player1

    --\\____________________________________________________________________//--

    --//________________________ Sound and Music ___________________________\\--
    love.audio.setVolume(0)

    -- Effects
    self.sound = love.audio.newSource('music/' .. self.name .. '.wav', 'static')
    self.sound:play()
    self.sound:setLooping(true)

    -- Music
    self.music = love.audio.newSource('music/' .. tostring(math.random(3)) .. '.wav', 'static')
    self.music:play()
    self.music:setLooping(true)

    --\\____________________________________________________________________//--

    --//__________________________ Buttons _________________________________\\--
    self.buttonPlay = Button{
        map = self,
        label = 'Play',
        action = function()
            self.state = 'player1_select'
        end
    }

    --\\____________________________________________________________________//--

    --//__________________________ Messages ________________________________\\--
    self.title = Message{
        map = self,
        text = 'Fifty Fighters',
        size = 50,
        font = 'fighter.ttf',
        relativeY = 30
    }
    self.charactersButtons = {}
    local counter = 1
    for k, v in pairs(Characters) do
        self.charactersButtons[k] = Button{
            label = k,
            image = 'graphics/CSEL/' .. 'little_' .. k .. '_portrait.png',
            map = self,
            action = function()
                if self.state == 'player1_select' then
                    self.player1 = Player(self, k, -1)
                    self.state = 'player2_select'
                elseif self.state == 'player2_select' then
                    self.player2 = Player(self, k, 1)
                    self.state = 'play'
                end
            end,
            relativeX = (counter) * 150

        }
        counter = counter + 1
    end

    --\\____________________________________________________________________//--

    --//_____________________ States and Behaviors _________________________\\--
    self.behaviors = {
        ['menu'] = function(dt)
            --self.animation:update(dt)
            self.title:update()
            self:updateCam()
            self.buttonPlay:update()
        end,
        ['player1_select'] = function(dt)
            self:updateCam()
            self:updateAllButtons()
        end,
        ['player2_select'] = function(dt)
            self:updateCam()
            self:updateAllButtons()
        end,
        ['play'] = function(dt)
        --    self.animation:update(dt)
            self:updateCam()
            self.player1:update(dt)
            self.player2:update(dt)
        end,
        ['pause'] = function(dt)
        end


    }

    self.renders = {
        ['menu'] = function()
            self.buttonPlay:render()
            self.title:render()
        end,
        ['play'] = function()
            love.graphics.draw(self.backgroundImage, self.backgroundQuads[self.currentFrame], 0, 0)
            self.player1.lifebar:render()
            self.player2.lifebar:render()
            self.player1:render()
            self.player2:render()
            self.player1:renderAllProjectiles()
            self.player2:renderAllProjectiles()
        end,
        ['player1_select'] = function()
            self:renderAllButtons()
        end,
        ['player2_select'] = function()
            self:renderAllButtons()
        end,
        ['map_select'] = function()
            self.

        ['pause'] = function()
            self.player1:render()
            self.player2:render()
            self:cover()
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

function Map:cover()
    -- Draws a black cover in the screen
    love.graphics.setColor(0, 0, 0, 0.8)
    love.graphics.rectangle('fill', 0, self.camY, WINDOW_WIDTH, WINDOW_HEIGHT)
    love.graphics.setColor(1, 1, 1, 1)
end


function Map:updateAllButtons()
    for k, v in pairs(self.charactersButtons) do
        v:update()
    end
end

function Map:renderAllButtons()
    for k, v in pairs(self.charactersButtons) do
        v:render()
    end
end
--============================================================================--
