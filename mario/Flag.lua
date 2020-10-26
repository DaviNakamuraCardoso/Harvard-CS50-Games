--=========================== Flag Class =====================================--

Flag = Class{}


--============================================================================--

function Flag:init(x, y, height, map)
    self.x = x
    self.y = y
    self.height = height
    self.map = map
    self.texture = self.map.spritesheet 
    self.frames = generateQuads(self.texture, 16, 16)
    self.flagX = self.x * self.map.tileWidth
    self.flagY = (self.y - self.height - 1) * self.map.tileWidth

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

    self.animations = {
        ['float'] = Animation({
            texture = self.texture,
            frames = {
                love.graphics.newQuad(0, 48, 16, 16, self.texture:getDimensions()),
                love.graphics.newQuad(16, 48, 16, 16, self.texture:getDimensions()),
                love.graphics.newQuad(0, 48, 16, 16, self.texture:getDimensions())

            },
            interval = 0.25

        }),
        ['win'] = Animation({
            texture = self.texture,
            frames = {
                love.graphics.newQuad(32, 48, 16, 16, self.texture:getDimensions())
            }
        })
    }
    self.animation = self.animations['float']
    self.currentFrame = self.animation:getCurrentFrame()
end

function Flag:update(dt)
    if self.map.player.state == 'winning' or self.map.player.state == 'waiting' then
        self.flagX = (self.x - 0.3) * self.map.tileWidth
        self.flagY = math.ceil(self.flagY + self.map.gravity * 2 * dt)
        self.animation = self.animations['win']
    end
    self.animation:update(dt)
    self.currentFrame = self.animation:getCurrentFrame()

end

--============================================================================--
function Flag:render()

    love.graphics.draw(self.texture, self.currentFrame, self.flagX, math.min(self.flagY, self.map.mapHeightPixels / 2 - 2 * self.map.tileHeight))
end
