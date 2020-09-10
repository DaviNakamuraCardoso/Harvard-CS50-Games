--======================== The Life Bar Class ================================--

Lifebar = Class{}


function Lifebar:init(player)
    self.player = player
    self.side = self.player.side

    self.width = VIRTUAL_WIDTH / 2.4
    self.height = 10

    self.padding = 10

    self.relativeX = VIRTUAL_WIDTH / 2 - ((2 * self.padding + self.width) / 2)  + self.side * ((2 * self.padding + self.width) / 2) + self.padding
    self.relativeY = 10

    self.x = self.player.map.camX + self.relativeX
    self.y = self.player.map.camY + self.relativeY


    -- Hurt rectangle
    self.rectangleWidth = self.width * (1 - self.player.health / 100)



end


function Lifebar:update(dt)
    self.x = self.player.map.camX + self.relativeX
    self.y = self.player.map.camY + self.relativeY
    self.rectangleWidth = self.width * (1 - self.player.health / 100)
    self.rectangleWidth = math.max(0.1, self.rectangleWidth - dt * 100)

end


function Lifebar:render()
    -- The outside contour
    love.graphics.setColor(0.4, 0.4, 0.4, 1)
    love.graphics.rectangle('fill', self.x-2, self.y-2, self.width+4, self.height+4, 2, 2)

    -- The inside dark bar
    love.graphics.setColor(0.1, 0.1, 0.1, 1)
    love.graphics.rectangle('fill', self.x, self.y, self.width, self.height, 2, 2)

    -- The red bar
    love.graphics.setColor(1, 0, 0, 1)
    love.graphics.rectangle('fill', self.x + self.player.sideParameter * (self.width - self.width * self.player.health / 100), self.y, math.max(0.1, self.width * self.player.health / 100), self.height, 2, 2)

    -- Reseting the color set
    love.graphics.setColor(1, 1, 1, 1)
end
