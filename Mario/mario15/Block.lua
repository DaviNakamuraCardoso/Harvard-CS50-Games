--=============================== Block Class ================================--
require('superclass')
Block = Class()

--============================================================================--

function Block:construct(map, x, y, width, height, color)
    self.map = map
    self.x = x
    self.y = y
    self.width = width
    self.height = height
    self.color = color


end



function Block:render(text)
    love.graphics.setColor(self.color[1], self.color[2], self.color[3], self.color[4])
    love.graphics.rectangle('fill', self.x + self.map.camX, self.y + self.map.camY, self.width, self.height, 4, 4)
    love.graphics.setColor(1, 1, 1, 1)
    messageText = Message(0, self.y + self.height / 4 - 1, 'fonts/four.ttf', 14, colors['white'])
    messageText:show(text)
end
