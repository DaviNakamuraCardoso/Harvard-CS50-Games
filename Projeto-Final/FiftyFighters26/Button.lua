--========================= The Button Class =================================--

Button = Class{}


function Button:init(params)
    self.map = params.map
    self.active = params.active or true

    self.relativeX = params.relativeX or VIRTUAL_WIDTH / 2
    self.relativeY = params.relativeY or VIRTUAL_HEIGHT / 2

    self.width = params.width or 100
    self.height = params.height or 20

    self.x = self.relativeX - self.width / 2 + self.map.camX
    self.y = self.relativeY - self.height / 2 + self.map.camY


    self.label = params.label or nil
    self.action = params.action or nil

    self.border = params.border or {6, 6}

    self.noHover = params.color or {252 / 255, 173 / 255, 38 / 255, 0.9}
    self.hover = {224 / 255, 170 / 255, 99 / 255, 1}
    self.inactiveColor = {0.6, 0.6, 0.6, 1}
    self.color = self.active and self.noHover or self.inactiveColor

    self.font = params.font or 'strikefighter.ttf'
    self.size = params.size or 19

    self.imageSource = params.imageSource or nil

    if self.imageSource ~= nil then
        self.image = love.graphics.newImage(self.imageSource)
        self.width = self.image:getWidth() + 6
        self.height = self.image:getHeight() + 6
        self.quad = love.graphics.newQuad(0, 0, self.image:getWidth(), self.image:getHeight(), self.image:getDimensions())

    end

    self.noLabel = params.noLabel or false

    self.message = Message{
        text = self.label,
        map = self.map,
        parameter = VIRTUAL_WIDTH,
        relativeX = self.relativeX - VIRTUAL_WIDTH / 2,
        relativeY = self.relativeY - self.height / 2 -1 ,
        font = self.font,
        size = self.size
    }


end


function Button:update(mouseX, mouseY)

    if mouseX >= self.relativeX - self.width / 2 and mouseX <= self.relativeX + self.width / 2 and
    mouseY >= self.relativeY - self.height / 2 and mouseY <= self.relativeY + self.height / 2 then
        if not self.active then
            self.color = self.inactiveColor
        else
            self.color = self.hover
        end

        if mouse['clicked'] and self.active then
            self.action()
        end
    else
        if self.active then
            self.color = self.noHover
        end
    end
    self.x = self.relativeX - self.width / 2 + self.map.camX
    self.y = self.relativeY - self.height / 2 + self.map.camY
    self.message:update()
end


function Button:render()
    love.graphics.setColor(self.color[1], self.color[2], self.color[3], 1)
    love.graphics.rectangle('fill', self.x, self.y, self.width, self.height, self.border[1], self.border[2])
    if not self.noLabel then
        self.message:render()
    end
    love.graphics.setColor(1, 1, 1, 1)
    if self.image ~= nil then
        love.graphics.draw(self.image, self.quad, self.x + 3, self.y + 3)
    end
end














--============================================================================--
