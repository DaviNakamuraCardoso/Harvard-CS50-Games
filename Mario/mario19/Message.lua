Message = Class()


function Message:construct(x, y, font, size, color)
    self.x = x
    self.y = y
    self.font = font
    self.size = size
    self.color = color
    self.counter = 0
    self.dt = 0
    self.parameter = VIRTUAL_WIDTH
    self.sound = love.audio.newSource('sounds/score.wav', 'stream')
end


function Message:show(text)
    currentFont = love.graphics.getFont()
    messageFont = love.graphics.newFont(self.font, self.size)
    love.graphics.setFont(messageFont)
    currentColor = love.graphics.getColor()
    love.graphics.setColor(self.color[1], self.color[2], self.color[3], self.color[4])
    love.graphics.printf(text, map.camX + self.x, map.camY + self.y, self.parameter, 'center')
    love.graphics.setFont(currentFont)
    love.graphics.setColor(1, 1, 1, 1)

end



function Message:prettyShow(times, sound, message, velocity)
    if self.counter < times then
        self.counter = self.counter + velocity
        sound:play()
    end
    self:show(message .. ' ' ..tostring(self.counter))
end


function Message:twinkle(message, interval, sound)
    if self.dt > interval then
        sound:play()
        self.dt = 0
        self.counter = self.counter + 1
        self.color[4] = (self.counter) % 2
    end
    self:show(message)
end



function Message:update(dt)
    self.dt = self.dt + dt
end
