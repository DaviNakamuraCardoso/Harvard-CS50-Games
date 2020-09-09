--========================= The Projectile Class =============================--


Projectile = Class{}


function Projectile:init(player, velocity, size, relativeX, relativeY)

    self.player = player
    self.velocity = velocity
    self.size = size


    self.player.numberOfProjectiles = self.player.numberOfProjectiles + 1
    self.player.projectiles[self.player.numberOfProjectiles] = self


    -- Initial Position
    self.direction = self.player.direction
    self.x = self.player.x + self.player.width / 2 + relativeX
    self.y = self.player.y + self.player.height / 2 + relativeY

    -- Animation
    self.animations = {
        ['fly'] = Animation(
        love.graphics.newImage('graphics/' .. self.player.name .. '/projectile.png'),
        generateQuads('graphics/' .. self.player.name .. '/projectile.png', self.size,  self.size),
        0.2),
        ['exploded'] = Animation(
            love.graphics.newImage('graphics/' .. self.player.name .. '/projectileExploded.png'),
            generateQuads('graphics/' .. self.player.name .. '/projectileExploded.png', self.size, self.size),
            0.2
        ),
        ['destroyed'] = Animation(
            love.graphics.newImage('graphics/' .. self.player.name .. '/projectileDestroyed.png'),
            generateQuads('graphics/' .. self.player.name .. '/projectileDestroyed.png', self.size, self.size),
            0.2
        )
    }
    self.animation = self.animations['fly']

    self.behaviors = {
        ['fly'] = function(dt)
            self:checkCollisions()
            self.x = math.floor(self.x - self.velocity * self.direction * dt)
            if self.x > self.player.map.mapWidth or self.x < 0 then
                self.state = 'destroyed'
            end
        end,
        ['exploded'] = function(dt)
            self.x = self.player.enemy.x + self.player.enemy.width / 4
            self.y = self.player.enemy.y + self.player.enemy.height / 2
            if self.animation.currentFrame == #self.animation.frames and self.animation.timer >= self.animation.interval then
                self.state = 'destroyed'
            end
        end,
        ['destroyed'] = function(dt)
        end
    }

    self.state = 'fly'
    self.currentFrame = self.animation:getCurrentFrame()
end


function Projectile:render()
    love.graphics.draw(self.animation.texture, self.currentFrame, self.x, self.y)

end


function Projectile:update(dt)
    self.animation = self.animations[self.state]
    self.behaviors[self.state](dt)
    self.animation:update(dt)
    self.currentFrame = self.animation:getCurrentFrame()
end

function Projectile:checkCollisions()
    for i=0, 360 do
        local x = math.floor(self.x + self.size / 2 + self.size / 2 * math.cos(math.rad(i)))
        local y = math.floor(self.y + self.size / 2 + self.size / 2 * math.sin(math.rad(i)))
        if self.player:hit(x, y) then
            self.state = 'exploded'
        end

    end
end



--============================================================================--
