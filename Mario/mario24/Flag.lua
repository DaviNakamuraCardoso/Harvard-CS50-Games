--=========================== Flag Class =====================================--

Flag = Class{}


--============================================================================--

function Flag:init(x, y, height, map)
    self.x = x
    self.y = y
    self.height = height
    self.map = map
    self.texture = love.graphics.newImage('graphics/spritesheet.png')
    self.frames = generateQuads(self.texture, 16, 16)

    local sprite
    for i=1, self.height do

        if i == 1 then
            sprite = FLAG_BOTTOM
        elseif i == self.height then
            sprite = FLAG_TOP
        else
            sprite = FLAG_MIDDLE
        end
        self.map:setTile(x, y-i, sprite)
    end
    self.frames = {
        [0] = FLAG_ONE,
        [1] = FLAG_TWO,
        [2] = FLAG_THREE
    }
    self.timer = 0
    self.interval = 0.4
    self.currentFrame = 1
end

function Flag:update(dt)
    if self.timer > self.interval then
        self.timer = 0
        self.currentFrame = (self.currentFrame + 1) % #self.frames

    else
        self.timer = self.timer + dt
    end
    self.map:setTile(self.x + 1, self.y - self.height, self.frames[self.currentFrame])
end

--============================================================================--
