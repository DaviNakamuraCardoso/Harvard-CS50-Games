--=============================== Block Class ================================--

Block = Class{}

--============================================================================--

function Block:init(x, y, width, height, color)
    self.x = x
    self.y = y
    self.width = width
    self.color = color

end



function Block:render()
    love.graphics.setColor(self.color[0], self.color[1], self.color[2], self.color[3])
    love.graphics.rectangle(self.x, self.y, self.width, self.height, 4, 4)

end
