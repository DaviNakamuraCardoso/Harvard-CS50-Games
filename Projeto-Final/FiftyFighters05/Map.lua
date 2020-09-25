--============================== Map Class ===================================--


Map = Class{}



SCROOL_SPEED = 0
function Map:init()
    --//______________________ Background Setup ________________________\\--
    self.backgroundImage = love.graphics.newImage('graphics/city.png')
    self.backgroundQuads = generateQuads('graphics/city.png', 960, 640)

    -- Dimensions
    self.mapWidth = self.backgroundImage:getWidth()
    self.mapHeight = self.backgroundImage:getHeight()

    -- Camera Position
    self.camX = 0
    self.camY = 60

    self.animation = Animation(self.backgroundImage, self.backgroundQuads, 0.2)

    self.player = Player(self)







end



function Map:render()
    love.graphics.draw(self.backgroundImage, self.animation:getCurrentFrame(), 0, 0)
    self.player:render()
end


function Map:update(dt)
    self.animation:update(dt)
    self.player:update(dt)


end













--============================================================================--
