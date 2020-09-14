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
    self.floor = self.mapHeight - 180
    self.gravity = 40

    --\\____________________________________________________________________//--

    --//____________________________ Animation ____________________________\\--

    self.backgroundImage = love.graphics.newImage('graphics/Backgrounds/' .. self.name .. '.png')
    self.backgroundQuads = generateQuads('graphics/Backgrounds/' .. self.name .. '.png', self.mapWidth, self.mapHeight)
    self.animation = Animation(self.backgroundImage, self.backgroundQuads, 0.2)

    --\\____________________________________________________________________//--

    --//____________________________ Players _______________________________\\--

    -- Creates the players
    self.player1 = Player(self, 'Athena', -1, 50)
    self.player2 = Player(self, 'Benimaru', 1, 40)

    -- Sets each one as other's enemy
    self.player1.enemy = self.player2
    self.player2.enemy = self.player1

    --\\____________________________________________________________________//--

    --//________________________ Sound and Music ___________________________\\--
    love.audio.setVolume(0.25)

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
            self.state = 'play'
        end
    }

    --\\____________________________________________________________________//--

    --//_____________________ States and Behaviors _________________________\\--
    self.behaviors = {
        ['menu'] = function(dt)
            self.animation:update(dt)
            self:updateCam()
            self.buttonPlay:update()
        end,
        ['play'] = function(dt)
            self.animation:update(dt)
            self:updateCam()
            self.player1:update(dt)
            self.player2:update(dt)
            if love.keyboard.wasPressed['space'] then
                self.state = 'pause'
            end
        end,
        ['pause'] = function(dt)
            self:cover()
            if love.keyboard.wasPressed['space'] then
                self.state = 'play'
            end
        end


    }

    self.renders = {
        ['menu'] = function()
            self.buttonPlay:render()
        end,
        ['play'] = function()
            love.graphics.draw(self.backgroundImage, self.animation:getCurrentFrame(), 0, 0)
            self.player1:render()
            self.player2:render()
        end,
        ['pause'] = function()
            love.graphics.draw(self.backgroundImage, self.animation:getCurrentFrame(), 0, 0)
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


function Map:cover()
    -- Draws a black cover in the screen
    love.graphics.setColor(0, 0, 0, 0.8)
    love.graphics.rectangle('fill', 0, self.camY, WINDOW_WIDTH, WINDOW_HEIGHT)
    love.graphics.setColor(1, 1, 1, 1)
end


--============================================================================--
