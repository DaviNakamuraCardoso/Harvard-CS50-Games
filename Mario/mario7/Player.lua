--========================= Player Class =====================================--

Player = Class()

require 'Animation'

local MOVE_SPEED = 70
local JUMP_VELOCITY = 400
local GRAVITY = 40
--============================================================================--


function Player:construct(map)
    self.width = 16
    self.height = 20

    self.x = map.tileWidth * 10
    self.y = map.tileHeight * (map.mapHeight / 2 - 1) - self.height

    self.texture = love.graphics.newImage('graphics/blue_alien.png')
    self.frames = generateQuads(self.texture, 16, 20)

    self.state = 'idle'
    self.direction = 'right'

    self.dx = 0
    self.dy = 0

    local idle = {
        texture = self.texture,
        frames = {
            self.frames[1]
        },
        interval = 1
    }

    local walking = {
        texture = self.texture,
        frames = {
        self.frames[9], self.frames[10], self.frames[11]
    },
        interval = 0.15
    }

    local jumping = {
        texture = self.texture,
        frames = {
            self.frames[3]
        },
        interval = 0.15
    }

    self.animations = {
        ['idle'] = Animation(idle),
        ['walking'] = Animation(walking),
        ['jumping'] = Animation(jumping)

    }

    self.animation = self.animations['idle']

    self.behaviors = {
        ['idle'] = function(dt)
            if love.keyboard.wasPressed('space') then
                self.dy = -JUMP_VELOCITY
                self.state = 'jumping'
                self.animation = self.animations['jumping']
            elseif love.keyboard.isDown('a') then
                self.dx = -MOVE_SPEED
                self.animation = self.animations['walking']
                self.direction = 'left'
            elseif love.keyboard.isDown('d') then
                self.dx = MOVE_SPEED
                self.animation = self.animations['walking']
                self.direction = 'right'
            else
                self.dx = 0
                self.animation = self.animations['idle']
            end
        end,
        ['walking'] = function(dt)
            if love.keyboard.wasPressed('space') then
                self.dy = -JUMP_VELOCITY
                self.state = 'jumping'
                self.animation = self.animations['jumping']
            elseif love.keyboard.isDown('a') then
                self.dx = -MOVE_SPEED
                self.animation = self.animations['walking']
                self.direction = 'left'

            elseif love.keyboard.isDown('d') then
                self.dx = MOVE_SPEED
                self.animation = self.animations['walking']
                self.direction = 'right'
            else
                self.dx = 0
                self.animation = self.animations['idle']
            end

        end,
        ['jumping'] = function(dt)
            if love.keyboard.isDown('a') then
                self.direction = 'left'
                self.dx = -MOVE_SPEED
            elseif love.keyboard.isDown('d') then
                self.direction = 'right'
                self.dx = MOVE_SPEED

            end
            self.dy = self.dy + GRAVITY
            if self.y >= map.tileHeight * (map.mapHeight / 2 - 1) - self.height then
                self.y = map.tileHeight * (map.mapHeight / 2 - 1) - self.height
                self.dy = 0
                self.state = 'idle'
                self.animation = self.animations[self.state]
            end

        end
    }
end


function Player:update(dt)
    self.behaviors[self.state](dt)
    self.animation:update(dt)
    self.x = math.ceil(self.x + self.dx * dt)
    self.y = math.ceil(self.y + self.dy * dt)

end


function Player:render()
    local scaleX = 1
    if self.direction == 'right' then
        scaleX = 1
    else
        scaleX = -1
    end
    love.graphics.draw(self.texture, self.animation:getCurrentFrame(),
         math.floor(self.x + self.width / 2), math.floor(self.y + self.height / 2),
     0, scaleX, 1,
    self.width / 2, self.height / 2)

end
