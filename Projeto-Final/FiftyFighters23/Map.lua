--============================== Map Class ===================================--


Map = Class{}

require 'backgrounds'

SCROOL_SPEED = 0
function Map:init(name)
    --//______________________ Background Setup ________________________\\--
    self.name = name
    self.backgroundImage = love.graphics.newImage('graphics/Backgrounds/' .. self.name .. '.png')
    -- Dimensions
    self.mapWidth = Backgrounds[self.name]['width']
    self.mapHeight = Backgrounds[self.name]['height']

    self.backgroundQuads = generateQuads('graphics/Backgrounds/' .. self.name .. '.png', self.mapWidth, self.mapHeight)



    self.floor = self.mapHeight - 180
    self.gravity = 40

    -- Camera Position
    self.camX = self.mapWidth / 2 - VIRTUAL_WIDTH / 2
    self.camY = self.mapHeight - VIRTUAL_HEIGHT

    self.animation = Animation(self.backgroundImage, self.backgroundQuads, 0.2)

    self.player1 = Player(self, 'Athena', -1, 50)
    self.player2 = Player(self, 'Benimaru', 1, 40)
    self.player1.enemy = self.player2
    self.player2.enemy = self.player1

    self.testButton = Button{
        map = self,
        relativeX = VIRTUAL_WIDTH / 2,
        relativeY = VIRTUAL_HEIGHT / 2,
        width = 100,
        height = 20
    }
    love.audio.setVolume(0.25)
    self.sound = love.audio.newSource('music/' .. self.name .. '.wav', 'static')
    self.sound:play()
    self.sound:setLooping(true)

end



function Map:render()
    love.graphics.draw(self.backgroundImage, self.animation:getCurrentFrame(), 0, 0)
    self.player1:render()
    self.player2:render()
end


function Map:update(dt)
    self.animation:update(dt)


    if  math.max(self.player1.x - self.player2.x, self.player2.x - self.player1.x) <= VIRTUAL_WIDTH - 100  then
        if self.player1.x <= self.camX or self.player2.x <= self.camX then

            self.camX = math.max(0, math.min(self.mapWidth - VIRTUAL_WIDTH,         math.max(math.min(self.player1.x, self.player2.x), math.max(self.player1.x,     self.player2.x) - VIRTUAL_WIDTH + 100)))

        elseif self.player1.x >= self.camX + VIRTUAL_WIDTH - 100 or self.player2.x >=   self.camX + VIRTUAL_WIDTH - 100 then
            self.camX = math.max(0, math.min(self.mapWidth - VIRTUAL_WIDTH,         math.min(math.min(self.player1.x, self.player2.x), math.max(self.player1.x,     self.player2.x) - VIRTUAL_WIDTH + 100)))
        end
    end

    self.camY = self.mapHeight - VIRTUAL_HEIGHT

    self.player1:update(dt)
    self.player2:update(dt)


end













--============================================================================--
