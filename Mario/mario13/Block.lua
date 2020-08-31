--=============================== Block Class ================================--
require('superclass')
Block = Class()

--============================================================================--

function Block:construct(x, y, width, height, color)
    self.x = x
    self.y = y
    self.width = width
    self.height = height
    self.color = color


end



function Block:render(text, x, y)
    love.graphics.setColor(self.color[1], self.color[2], self.color[3], self.color[4])
    love.graphics.rectangle('fill', x + self.x, y + self.y, self.width, self.height, 4, 4)
    love.graphics.setColor(1, 1, 1, 1)
    message = Message(0, self.y + self.height / 4, 'fonts/super_mario.ttf', 9, colors['white'])
    message:show(text)
end
