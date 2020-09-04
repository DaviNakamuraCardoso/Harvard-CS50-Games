--============================== Map Class ===================================--


Map = Class{}



SCROOL_SPEED = 0
function Map:init()
    --//______________________ Background Setup ________________________\\--
    self.backgroundImage = love.graphics.newImage('graphics/city.png')
    self.backgroundQuads = generateQuads('graphics/city.png', 960, 640, 4800, 12800)

    self.mapWidth = 90
    self.mapHeight = 40


    self.camX = 0
    self.camY = 0

    self.animation = Animation(self.backgroundImage, self.backgroundQuads, 0.2)





end



function Map:render()
    love.graphics.draw(self.backgroundImage, self.animation:getCurrentFrame(), 0, 0)
end


function Map:update(dt)
    self.animation:update(dt)

end













--============================================================================--
