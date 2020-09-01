--============================== Map Class ===================================--


Map = Class{}



SCROOL_SPEED = 70
function Map:init()
    --//______________________ Background Setup ________________________\\--
    self.backgroundImage = love.graphics.newImage('graphics/background.jpg')
    self.backgroundQuads = generateQuads('graphics/background.jpg', 1440, 480)

    self.mapWidth = 90
    self.mapHeight = 40


    self.camX = 0
    self.camY = 0






end



function Map:render()
    love.graphics.draw(self.backgroundImage, self.backgroundQuads[0], 0, 0)
end


function Map:update(dt)
    self.camX = math.floor(self.camX + SCROOL_SPEED * dt)
end













--============================================================================--
