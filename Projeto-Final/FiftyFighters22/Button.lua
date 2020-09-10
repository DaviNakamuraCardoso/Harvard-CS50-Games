--========================= The Button Class =================================--

Button = Class{}


function Button:init(params)
    self.map = params.map

    self.relativeX = params.relativeX
    self.relativeY = params.relativeY

    self.width = params.width
    self.height = params.height

    self.x = self.relativeX - self.width / 2 + self.map.camX
    self.y = self.relativeY - self.height / 2 + self.map.camX


    self.label = params.label or nil
    self.action = params.action or nil

    self.noHover = params.color or {1, 0.1, 0.1, 1}
    self.hover = {self.noHover[1] / 3, self.noHover[2] / 3, self.noHover[3] / 3, 1}
    self.color = self.noHover

    self.message = Message{text = 'teste', map = self.map, parameter = self.width}

end


function Button:update()
    mouseX = love.mouse.getX() * VIRTUAL_WIDTH / WINDOW_WIDTH
    mouseY = love.mouse.getY() * VIRTUAL_HEIGHT / WINDOW_HEIGHT

    if mouseX >= self.relativeX - self.width / 2 and mouseX <= self.relativeX + self.width / 2 and
    mouseY >= self.relativeY - self.height / 2 and mouseY <= self.relativeY + self.height / 2 then
        self.color = self.hover
        if mouse['clicked'] then
            self.action()
        end
    else
        self.color = self.noHover
    end
    self.x = self.relativeX - self.width / 2 + self.map.camX
    self.y = self.relativeY - self.height / 2 + self.map.camY
    self.message:update()
end


function Button:render()
    love.graphics.setColor(self.color[1], self.color[2], self.color[3], 1)
    love.graphics.rectangle('fill', self.x, self.y, self.width, self.height, 6, 6, 6, 6)
    self.message:render()
    love.graphics.setColor(1, 1, 1, 1)
end














--============================================================================--
