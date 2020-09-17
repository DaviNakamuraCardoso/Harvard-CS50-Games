--========================= The Message Class ================================--


Message = Class{}

function Message:init(params)
    self.text = params.text
    self.map = params.map

    -- Position
    self.relativeX = params.relativeX or 0
    self.relativeY = params.relativeY or VIRTUAL_HEIGHT / 3
    self.x = self.relativeX + self.map.camX
    self.y = self.relativeY + self.map.camY
    self.parameter = params.parameter or VIRTUAL_WIDTH
    self.align = params.align or 'center'

    -- Font, size and color
    self.font = params.font or 'four.ttf'
    self.size = params.size or 14
    self.color = params.color or {1, 1, 1, 1}
    self.borderColor = params.borderColor or {0, 0, 0, 0}

    --
end


function Message:update()
    self.x = self.relativeX + self.map.camX
    self.y = self.relativeY + self.map.camY

end

function Message:render()
    love.graphics.setColor(self.borderColor[1], self.borderColor[2], self.borderColor[3], self.borderColor[4])
    love.graphics.setFont(love.graphics.newFont('fonts/' .. self.font, self.size + 2))
    love.graphics.printf(self.text, self.x-1, self.y-1, self.parameter, self.align)

    love.graphics.setColor(self.color[1], self.color[2], self.color[3], self.color[4])
    love.graphics.setFont(love.graphics.newFont('fonts/' .. self.font, self.size))
    love.graphics.printf(self.text, self.x, self.y, self.parameter, self.align)
    love.graphics.setColor(1, 1, 1, 1)

end



--============================================================================--
