--======================== The Life Bar Class ================================--

Lifebar = Class{}


function Lifebar:init(player)

    --//_________________________ Position and Side ________________________\\--

    self.player = player
    self.side = self.player.side

    self.width = VIRTUAL_WIDTH / 2.4
    self.height = 10

    self.padding = 10

    self.relativeX = VIRTUAL_WIDTH / 2 - ((2 * self.padding + self.width) / 2)  + self.side * ((2 * self.padding + self.width) / 2) + self.padding
    self.relativeY = 15

    self.x = self.player.map.camX + self.relativeX
    self.y = self.player.map.camY + self.relativeY

    --//______________________________ HP __________________________________\\--

    self.color = {1, 1, 0, 1}
    self.messageHP = Message{
        text = tostring(math.floor(self.player.health)) .. '/100',
        map = self.player.map,
        color = self.color,
        relativeX = self.player.side * 50,
        relativeY = 0,

    }
    self.rectangleWidth = self.width * (self.player.health / 100)
    self.rectangleX = self.x + self.player.sideParameter * self.rectangleWidth
    self.rectangleY = self.y

    self.borderColor = self.side == -1 and {1, 0, 0, 1} or {0, 0, 1, 1}

    --//________________________ Player Image ______________________________\\--

    self.image = love.graphics.newImage('graphics/CSEL/little_' .. self.player.name .. '_portrait.png')

    -- Dimensions
    self.quad = love.graphics.newQuad(0, 0, self.image:getWidth(), self.image:getHeight(), self.image:getDimensions())
    self.imageWidth = self.image:getWidth()
    self.imageHeight = self.image:getHeight()

    -- Position
    self.imageX = self.x + self.width / 2 + self.side * self.width / 2 - self.player.sideParameter * self.imageWidth
    self.imageCountour = {105 / 255, 92 / 255, 250 / 255, 1}

    -- Message
    self.messageName = Message{
        text = self.player.name,
        map = self.player.map,
        color = {1, 1, 1, 1},
        borderColor = {0, 0, 0, 1},
        relativeX = self.player.side * 160,
        relativeY = -5,
        size = 13,
        font = 'sfighter.otf'
    }





end


function Lifebar:update(dt)

    -- X and Y positions
    self.x = self.player.map.camX + self.relativeX
    self.y = self.player.map.camY + self.relativeY

    self.messageHP:update()

    -- Special bar

    -- Character portrait
    self.imageX = self.x + self.width / 2 + self.side * self.width / 2 - self.player.sideParameter * self.imageWidth + (self.imageWidth * self.player.side)
    self.messageName:update()




end


function Lifebar:render()

    -- The outside contour
    love.graphics.setColor(self.borderColor[1], self.borderColor[2], self.borderColor[3], 1)
    love.graphics.rectangle('fill', self.x-2, self.y-2, self.width+4, self.height+4, 2, 2)

    -- The inside dark bar
    love.graphics.setColor(0.1, 0.1, 0.1, 1)
    love.graphics.rectangle('fill', self.x, self.y, self.width, self.height, 2, 2)

    -- The yellow bar
    love.graphics.setColor(self.color[1], self.color[2], self.color[3], 1)
    love.graphics.rectangle('fill',self.x + self.rectangleX, self.y, self.rectangleWidth, self.height, 2, 2)
    self.messageHP:render()


    --//________________________ Character Portrait ________________________________\\--

    -- Contour
    love.graphics.setColor(self.borderColor[1], self.borderColor[2], self.borderColor[3], 1)
    love.graphics.rectangle('line', self.imageX-1, self.y-1, self.imageWidth+2, self.imageHeight+2, 2, 2)

    -- Reseting the color set
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.draw(self.image, self.quad, self.imageX, self.y)
    self.messageName:render()

    love.graphics.setColor(1, 1, 1, 1)
end


function Lifebar:updateDimensionsAndColors()


    self.rectangleWidth = math.max(0.1, math.floor(self.width * (self.player.health / 100)))

    self.rectangleX = self.player.sideParameter * (self.width - self.rectangleWidth)

    self.messageHP.text = tostring(math.floor(math.max(0, self.player.health))) .. '/100'
end
