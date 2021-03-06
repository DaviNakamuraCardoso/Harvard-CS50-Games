--============================ Button Class =================================--
require('superclass')
Button = Class(Block)

--============================================================================--


function Button:construct(map, x, y, width, height, color)
    Button.super.construct(self, map, x, y, width, height, color)
    self.map = map
    self.noHoverColor = color
    self.hoverColor = {
        self.color[1] / 2, self.color[2] / 2, self.color[3] / 2, self.color[4]
    }
    self.sound = love.audio.newSource('sounds/button.wav', 'static')
    self.clicked = false



end

function Button:hover()
    mouseX = love.mouse.getX() * VIRTUAL_WIDTH / love.graphics.getWidth() + 10
    mouseY = love.mouse.getY() * VIRTUAL_HEIGHT / love.graphics.getHeight()
    if self.x <= mouseX and mouseX <= self.x + self.width and self.y <= mouseY and mouseY <= self.y + self.height then
        self.color = self.hoverColor
        return true
    else
        self.color = self.noHoverColor
    end
end



function Button:update()
    self:getCamCoordinates()
    if self:hover() and mouse['clicked'] then
        self.clicked = true
        self.sound:play()
    else
        self.clicked = false
    end

end
