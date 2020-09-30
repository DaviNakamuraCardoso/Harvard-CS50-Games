--========================= The Projectile Class =============================--


Projectile = Class{}


function Projectile:init(parameters)

    self.player = parameters.player
    self.type = parameters.type
    self.number = parameters.number

    self.range = parameters.range or 300
    self.playerPosition = self.player.x

    self.velocity = parameters.velocity or 0
    self.damage = parameters.damage or self.player.damage

    self.incline = parameters.incline or 0
    self.infinity = parameters.infinity or false
    self.explodeAtEnemy = parameters.explode or true


    self.player.numberOfProjectiles = self.player.numberOfProjectiles + 1
    self.index = self.player.numberOfProjectiles
    self.player.projectiles[self.player.numberOfProjectiles] = self



    local relativeX = parameters.relativeX or - self.player.width / 4
    local relativeY = parameters.relativeY or - self.player.height / 2

    -- Initial Position
    self.direction = parameters.direction or self.player.direction
    self.x = self.player.x + self.player.width / 2 + relativeX
    self.y = self.player.y + self.player.height / 2 + relativeY

    -- Animation
    self.animations = {
        ['exploded'] = Animation(self.player, 'projectile_' .. tostring(self.number) .. '_exploded'),
        ['destroyed'] = Animation(self.player, 'projectile_'.. tostring(self.number) .. '_destroyed')
    }

    if self.type == 'fly' then
        self.animations['fly'] = Animation(self.player, 'projectile_' .. tostring(self.number) ..'_fly')
    else
        self.animations['spawn'] = Animation(self.player, 'projectile_' .. tostring(self.number) .. '_spawn')
    end

    self.animation = self.animations['destroyed']
    self.behaviors = {
        ['fly'] = function(dt)
            self:checkCollisions()
            self.x = math.floor(self.x - self.velocity * self.direction * math.cos(math.rad(self.incline)) * dt)
            self.y = math.floor(self.y - self.velocity * math.sin(math.rad(self.incline)) * dt)
            if (self.x > self.player.map.mapWidth or self.x < 0) then
                if not self.infinity then
                    self.state = 'destroyed'
                end
            end
        end,
        ['spawn'] = function(dt)
            self.x = self.player.x - self.direction * self.range
            self:checkCollisions()
            if self.animation.ending then
                if self.player.enemy.state == 'hurt' then
                    self.state = 'exploded'
                else
                    self.state = 'destroyed'
                end
                if self.infinity then
                    self.animation.currentFrame = 0
                    self.state = 'spawn'
                end

            end
        end,

        ['exploded'] = function(dt)
            if self.explodeAtEnemy then
                self.x = self.player.enemy.x + self.direction * (self.currentFrame:getWidth() / 2 - self.player.enemy.width / 2)
                self.y = self.player.enemy.y
            else
                self.x = self.x
                self.y = self.y
            end
            if self.animation.ending then
                self.state = 'destroyed'
            end
        end,
        ['destroyed'] = function(dt)
        end
    }

    self.state = self.type
    self.currentFrame = self.animation:getCurrentFrame()
    self.currentQuad =  self.animation:getCurrentQuad()

    self.size = parameters.size or 40
    -- Sounds
    self.sound = love.audio.newSource('sounds/' .. self.player.name .. '/projectile.wav', 'static')
end


function Projectile:render()
    love.graphics.draw(self.currentFrame, self.currentQuad, (self.x + self.currentFrame:getWidth() / 2), self.y + self.currentFrame:getHeight() / 2, 0, self.direction, 1, self.currentFrame:getWidth() / 2, self.currentFrame:getHeight() / 2)

end


function Projectile:update(dt)
    self.animation = self.animations[self.state]
    self.behaviors[self.state](dt)
    self.animation:update(dt)
    self.currentFrame = self.animation:getCurrentFrame()
    self.currentQuad = self.animation:getCurrentQuad()
end


function Projectile:checkCollisions()
    for i=0, 360, 10 do
        local x = math.floor(self.x + self.size / 2 + self.size / 2 * math.cos(math.rad(i)))
        local y = math.floor(self.y + self.size / 2 + self.size / 2 * math.sin(math.rad(i)))
        if self.player:hit(x, y, self.size, self.damage, self.index) then
            if not self.infinity then
                self.state = 'exploded'
                self.sound:play()
            end 
        end

    end
end



--============================================================================--
