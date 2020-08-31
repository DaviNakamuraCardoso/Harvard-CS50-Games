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
    self.clicked = false



end

function Button:hover()
    mouseX = love.mouse.getX() * VIRTUAL_WIDTH / love.graphics.getWidth()
    mouseY = love.mouse.getY() * VIRTUAL_HEIGHT / love.graphics.getHeight()
    if self.x <= mouseX and mouseX <= self.x + self.width and self.y <= mouseY and mouseY <= self.y + self.height then
        self.color = self.hoverColor
        return true
    else
        self.color = self.noHoverColor
    end
end



function Button:update()
    if self:hover() and love.mouse.isDown(1) then
        self.clicked = true
    else
        self.clicked = false
    end

end
