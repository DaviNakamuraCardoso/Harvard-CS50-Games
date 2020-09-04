--============================ Player Class ==================================--

Player = Class{}


function Player:init(map, name, width, height)
    self.map = map
    self.name = name
    -- Position and dimensions
    self.x = 20
    self.y = 259
    self.width = width
    self.height = height

    self.dx = 0
    self.dy = 0

    --//_________________________ Animations ___________________________\\--
    self.animations = {
        ['idle'] = Animation(
            love.graphics.newImage('graphics/' .. self.name ..  '_idle.png'),
            generateQuads('graphics/' .. self.name .. '_idle.png', self.width, self.height),
            0.3
        ),
        ['walking'] = Animation(
            love.graphics.newImage('graphics/walking.png'),
            generateQuads('graphics/walking.png', 115, 100),
            0.1
        ),
        ['attacking'] = Animation(
            love.graphics.newImage('graphics/attacking.png'),
            generateQuads('graphics/attacking.png', 80, 100),
            0.05
        ),
        ['jumping'] = Animation(
            love.graphics.newImage('graphics/jumping.png'),
            generateQuads('graphics/jumping.png', 80, 150),
            0.8
        )

    }

    self.animation = self.animations['idle']
    self.currentFrame = self.animation:getCurrentFrame()

    --//_________________________ Behaviors ____________________________\\--
    self.speed = 200
    self.jumpSpeed = -800
    self.direction = 1
    self.behaviors = {
        ['idle'] = function(dt)
            if love.keyboard.isDown('a') then
                self.x = math.max(128, math.floor(self.x - self.speed * dt))
                self.state = 'walking'
                self.direction = -1

            elseif love.keyboard.isDown('d') then
                self.x = math.min(540, math.floor(self.x + self.speed * dt))
                self.state = 'walking'
                self.direction = 1

            elseif love.keyboard.wasPressed['r'] then
                self.state = 'attacking'

            elseif love.keyboard.wasPressed['f'] then
                self.dy = self.jumpSpeed
                self.state = 'jumping'
            end

        end,
        ['walking'] = function(dt)
            if love.keyboard.isDown('a') then
                self.x = math.max(128, math.floor(self.x - self.speed * dt))
                self.direction = -1
            elseif love.keyboard.isDown('d') then
                self.x = math.min(540, math.floor(self.x + self.speed * dt))
                self.direction = 1

            elseif love.keyboard.wasPressed['r'] then
                self.state = 'attacking'
            else
                self.state = 'idle'
            end
        end,
        ['attacking'] = function(dt)
            if self.animation.currentFrame == #self.animation.frames - 1 then
                self.animation.currentFrame = 0
                self.state = 'idle'

            end
        end,
        ['jumping'] = function(dt)
            self.y = math.floor(self.y + self.dy * dt)
            if self.y >= self.map.floor then
                self.y = self.map.floor
                self.dy = 0
                self.state = 'idle'
            else
                self.dy = self.dy + self.map.gravity
            end
        end

    }
    self.state = 'idle'

end



function Player:update(dt)
    self.animation = self.animations[self.state]
    self.currentFrame = self.animation:getCurrentFrame()
    self.animation:update(dt)
    self.behaviors[self.state](dt)
end



function Player:render()
    love.graphics.draw(self.animation.texture, self.currentFrame, self.x, self.y, 0, self.direction, 1)

end
