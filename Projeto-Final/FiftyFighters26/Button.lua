--========================= The Button Class =================================--

Button = Class{}


function Button:init(params)
    self.map = params.map

    self.relativeX = params.relativeX or VIRTUAL_WIDTH / 2
    self.relativeY = params.relativeY or VIRTUAL_HEIGHT / 2

    self.width = params.width or 100
    self.height = params.height or 20

    self.x = self.relativeX - self.width / 2 + self.map.camX
    self.y = self.relativeY - self.height / 2 + self.map.camY


    self.label = params.label or nil
    self.action = params.action or nil

    self.noHover = params.color or {1, 1, 0.1, 1}
    self.hover = {self.noHover[1] / 3, self.noHover[2] / 3, self.noHover[3] / 3, 1}
    self.color = self.noHover

    self.font = params.font or 'great_fighter.ttf'

    self.imageSource = params.image or nil

    if self.image ~= nil then
        self.image = love.graphics.newImage(self.imageSource)
        self.width = self.image:getWidth() + 6
        self.height = self.image:getHeight() + 6
        self.quad = love.graphics.newQuad(0, 0, self.image:getWidth(), self.image:getHeight(), self.image:getDimensions())
    end

    self.message = Message{
        text = self.label,
        map = self.map,
        parameter = VIRTUAL_WIDTH,
        relativeX = self.relativeX - VIRTUAL_WIDTH / 2,
        relativeY = self.relativeY - self.height / 2,
        font = self.font,
        size = 20
    }

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
    if self.image ~= nil then
        love.graphics.draw(self.image, self.quad, self.x + 3, self.y + 3)
    end
end














--============================================================================--
