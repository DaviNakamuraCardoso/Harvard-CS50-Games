--============================ Player Class ==================================--

Player = Class{}


function Player:init(map)
    self.map = map

    self.texture = love.graphics.newImage('graphics/soldier_pack1.png')
    self.frames = generateQuads('graphics/soldier_pack1.png', 42, 42)
    -- Position and dimensions
    self.x = 300
    self.y = 300

    --//_________________________ Animations ___________________________\\--
    self.animations = {
        ['idle'] = Animation(
            love.graphics.newImage('graphics/idleSoldier.png'),
            generateQuads('graphics/idleSoldier.png', 30, 42),
            0.8
        )
    }

    self.animation = self.animations['idle']
    self.currentFrame = self.animation:getCurrentFrame()

    --//_________________________ Behaviors ____________________________\\--
    self.speed = 30
    self.behaviors = {
        ['idle'] = function(dt)
            if love.keyboard.isDown('a') then
                self.x = math.floor(self.x + self.speed * dt)

            elseif love.keyboard.isDown('d') then
                self.x = math.floor(self.x + self.speed * dt)
            end

        end

    }
    self.state = 'idle'

end



function Player:update(dt)
    self.currentFrame = self.animation:getCurrentFrame()
    self.animation:update(dt)
    self.behaviors[self.state](dt)
end



function Player:render()
    love.graphics.draw(self.animation.texture, self.currentFrame, self.x, self.y)

end
