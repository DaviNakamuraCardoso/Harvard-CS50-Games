--============================ Player Class ==================================--

Player = Class{}


function Player:init(map, name, side)
    self.map = map
    self.name = name

    -- 1 or -1, 1 representing the right side and -1 the left side
    self.side = side
    -- Position and dimensions
    self.x = 20
    self.y = self.map.floor
    self.width = width
    self.height = height

    self.dx = 0
    self.dy = 0

    --//_________________________ Animations ___________________________\\--
    self.animations = {

        ['idle'] = Animation(
            love.graphics.newImage('graphics/' .. self.name ..  '/idle.png'),
            generateQuads('graphics/' .. self.name .. '/idle.png', 100, 160),
            0.3
        ),
        ['walking'] = Animation(
            love.graphics.newImage('graphics/' .. self.name .. '/walking.png'),
            generateQuads('graphics/' .. self.name .. '/walking.png', 100, 160),
            0.1
        ),
        ['attacking'] = Animation(
            love.graphics.newImage('graphics/' .. self.name .. '/attacking.png'),
            generateQuads('graphics/' .. self.name .. '/attacking.png', 100, 160),
            0.05
        ),
        ['jumping'] = Animation(
            love.graphics.newImage('graphics/' .. self.name .. '/jumping.png'),
            generateQuads('graphics/' .. self.name .. '/jumping.png', 100, 160),
            0.4
        ),
        ['dying'] = Animation(
            love.graphics.newImage('graphics/' .. self.name .. '/dying.png'),
            generateQuads('graphics/' .. self.name .. '/dying.png', 110, 160),
            0.4
        ),
        ['waiting'] = Animation(
            love.graphics.newImage('graphics/' .. self.name .. '/waiting.png'),
            generateQuads('graphics/' .. self.name .. '/waiting.png', 100, 160),
            0.2
        )

    }

    self.animation = self.animations['idle']
    self.currentFrame = self.animation:getCurrentFrame()

    --//_________________________ Behaviors ____________________________\\--
    self.speed = 200
    self.jumpSpeed = -800
    self.direction = 1
    local keyRelations = {
        [-1] = {
            ['forward'] = 'd',
            ['backward'] = 'a'
        },
        [1] = {
            ['forward'] = 'left',
            ['backward'] = 'right'
        }
    }
    self.behaviors = {
        ['idle'] = function(dt)
            if love.keyboard.isDown('a') then
                self.x = math.max(128, math.floor(self.x - self.speed * dt))
                self.state = 'walking'
                self.direction = 1

            elseif love.keyboard.isDown('d') then
                self.x = math.min(540, math.floor(self.x + self.speed * dt))
                self.state = 'walking'
                self.direction = -1

            elseif love.keyboard.wasPressed['r'] then
                self.state = 'attacking'

            elseif love.keyboard.wasPressed['space'] then
                self.dy = self.jumpSpeed
                self.state = 'jumping'

            elseif love.keyboard.wasPressed['f'] then
                self.state = 'dying'

            end

        end,
        ['walking'] = function(dt)
            if love.keyboard.isDown('a') then
                self.x = math.max(128, math.floor(self.x - self.speed * dt))
                self.direction = 1
            elseif love.keyboard.isDown('d') then
                self.x = math.min(540, math.floor(self.x + self.speed * dt))
                self.direction = -1

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
        end,
        ['dying'] = function(dt)
            if self.animation.currentFrame == (#self.animation.frames) then
                self.state = 'waiting'

            else
                self.x = math.floor(self.x + self.direction * self.speed * dt / 2)
            end
        end,
        ['waiting'] = function(dt)

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
