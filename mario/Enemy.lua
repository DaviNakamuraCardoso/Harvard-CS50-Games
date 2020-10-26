--============================= The enemies Class ============================--

Enemy = Class()


ENEMY_SPEED = 35
--============================================================================--

function Enemy:init(map, spritesheet, width, height, x, y)
    self.map = map
    self.texture = love.graphics.newImage(spritesheet)
    self.width = width
    self.height = height
    self.isAlive = true

    -- Positions
    self.x = x
    self.y = y

    self.dy = 0
    self.dy = 0
    self.speed = ENEMY_SPEED * (1 + (self.map.level / 20))

    self.lives = 1

    self.direction = 1

    self.xOffset = 8
    self.yOffset = 10

    -- Counters for the final boss
    self.interval = 2
    self.timer = 0
    self.isFinal = false

    self.sounds = {
        ['triumph'] = love.audio.newSource('sounds/triumph.wav', 'static'),
        ['finalDeath'] = love.audio.newSource('sounds/finalDeath.wav', 'static')
    }

    self.finalBossFrames = {}
    local index = 0
    for i=0, 1200, 200 do
        for j=0, 800, 200 do
            self.finalBossFrames[index] = love.graphics.newQuad(j, i, 200, 200, self.texture:getDimensions())
            index = index + 1
        end
    end

    self.finalDeathFrames = {}
    self.finalTexture = love.graphics.newImage('graphics/finalDeath.png')
    index = 0
    for i=0, 600, 200 do
        for j=0, 800, 200 do
            self.finalDeathFrames[index] = love.graphics.newQuad(j, i, 200, 200, self.finalTexture:getDimensions())
            index = index + 1
        end
    end

    self.finalHeartsSheet = love.graphics.newImage('graphics/finalHeart.png')



    self.behaviors = {
        ['walking'] = function(dt)
            if self.map:collides(self.map:tileAt(self.x + self.width, self.y)) or (self.map:tileAt(self.x + self.width, self.y + self.height)).id == TILE_EMPTY then
                self.x = self.x - 5
                self.direction = -self.direction

            elseif self.map:collides(self.map:tileAt(self.x - 1, self.y)) or (self.map:tileAt(self.x - 1, self.y + self.height)).id == TILE_EMPTY then
                self.x = self.x + 5
                self.direction = -self.direction
            end
            if self.direction < 0 then
                self.dx = math.floor(self.speed * self.direction * dt)
                self.x = math.floor(self.x + self.dx)
            else
                self.dx = math.ceil(self.speed * self.direction * dt)
                self.x = math.ceil(self.x + self.dx)
            end
            if self.map:tileAt(self.x - self.map.tileWidth, self.y + self.height).id == TILE_EMPTY then
                if self.map:tileAt(self.x + self.map.tileWidth, self.y + self.height).id == TILE_EMPTY or self.map:tileAt(self.x + self.map.tileWidth, self.y + self.map.tileHeight).id == TILE_BRICK then
                    -- If between two holes or a block and a hole, stop
                    self.state = 'stopped'
                    self.animation = self.animations['stopped']
                end
            elseif self.map:tileAt(self.x + self.map.tileWidth, self.y + self.height).id == TILE_EMPTY then

                if self.map:tileAt(self.x - self.map.tileWidth, self.y + self.map.tileHeight).id == TILE_BRICK then
                    self.state = 'stopped'
                    self.animation = self.animations['stopped']
                end
            end


        end,
        ['dying'] = function(dt)
            self.isAlive = false
            if self.y < self.map.mapHeightPixels - self.height  and not self.isFinal then
                self.dy = math.ceil(self.map.gravity * 4 * dt)
                self.y = math.ceil(self.y + self.dy)
            else
                if self.animation.currentFrame >= 12 then
                    self.sounds['triumph']:play()
                    self.animation = self.animations['dead']
                    self.state = 'stopped'
                    self.map.newLevel = true
                    self.map.player.state = 'waiting'
                    self.map.player.dx = 0
                    self.map.player.dy = 0
                end
                self.dy = 0
                self.dx = 0
            end
        end,
        ['fly'] = function(dt)
            if self.map:collides(self.map:tileAt(self.x, self.y  + self.height)) or self.map:collides(self.map:tileAt(self.x + self.width, self.y + self.height)) then
                if self.direction > 0 then
                    self.state = 'walking'
                    self.animation = self.animations['walking']
                else
                    self.dy = self.map.gravity
                    self.y = math.floor(self.y + self.dy * self.direction * dt * 5)
                end
            else
                self.dy = self.map.gravity
                if self.direction > 0 then
                    self.y = math.ceil(self.y + self.dy * dt * self.direction)
                else
                    self.y = math.floor(self.y + self.dy * dt * self.direction * 3)
                end
            end
        end,
        ['stopped'] = function(dt)
            self.dx = 0
            self.dy = 0
        end,
        ['finalBoss'] = function(dt)
            if self.timer >= self.interval and self.map.player.x > self.x - 30 then
                self.timer = 0
                self.map.numberOfEnemies = self.map.numberOfEnemies + 1
                self.map.enemies[self.map.numberOfEnemies] = Enemy(self.map, 'graphics/redAlien.png', 16, 20, self.x + self.width - 10, self.y + 20)
            else
                self.timer = self.timer + dt
            end



        end



    }

    self.animations  = {
        ['walking'] = Animation({
            texture = self.texture,
            frames = {
                love.graphics.newQuad(112, 0, self.width, self.height,  self.texture:getDimensions()),
                love.graphics.newQuad(128, 0, self.width, self.height, self.texture:getDimensions()),
                love.graphics.newQuad(144, 0, self.width, self.height, self.texture:getDimensions()),
                love.graphics.newQuad(160, 0, self.width, self.height, self.texture:getDimensions()),
            },
            interval = 0.10
        }),
        ['dying'] = Animation({
            texture = self.texture,
            frames = {
                love.graphics.newQuad(64, 0, self.width, self.height, self.texture:getDimensions())
            }
        }),
        ['fly'] = Animation({
            texture = self.texure,
            frames = {
                love.graphics.newQuad(160, 0, self.width, self.height,self.texture:getDimensions()),
                love.graphics.newQuad(176, 0, self.width, self.height,self.texture:getDimensions()),
                love.graphics.newQuad(176, 0, self.width, self.height, self.texture:getDimensions())
            },
            interval = 0.3
        }),
        ['stopped'] = Animation({
            texture = self.texture,
            frames = {
                love.graphics.newQuad(0, 0, self.width, self.height, self.texture:getDimensions()),
                love.graphics.newQuad(16, 0, self.width, self.height, self.texture:getDimensions()),
                love.graphics.newQuad(192, 0, self.width, self.height, self.texture:getDimensions()),
                love.graphics.newQuad(0, 0, self.width, self.height, self.texture:getDimensions())


            },
            interval = 1
        }),
        ['finalBoss'] = Animation({
            texture = self.texture,
            frames = self.finalBossFrames,
            interval = 0.10

        }),
        ['finalDeath'] = Animation({
            texture = self.finalTexture,
            frames = self.finalDeathFrames,
            interval = 0.2
        }),
        ['dead'] = Animation({
            texture = self.finalTexture,
            frames = {
                love.graphics.newQuad(20, 620, 160, 160, self.finalTexture:getDimensions())
            }
        })
    }

    self.state = 'fly'
    self.animation = self.animations['fly']
    self.currentFrame = self.animation:getCurrentFrame()

end


function Enemy:update(dt)
    self.behaviors[self.state](dt)
    self.animation:update(dt)
    self.currentFrame = self.animation:getCurrentFrame()
    if self.lives == 0 then
        self.state = 'dying'
        if self.isFinal then
            self.animation = self.animations['finalDeath']
            self.texture = love.graphics.newImage('graphics/finalDeath.png')

        else
            self.animation = self.animations['dying']
        end
    end
end


--============================================================================--
function Enemy:render()
    love.graphics.draw(self.texture, self.currentFrame, math.floor(self.x + self.xOffset), math.floor(self.y + self.yOffset), 0, self.direction, 1,
    self.xOffset, self.yOffset)
    if self.isFinal then
        for i=1, self.lives do
            love.graphics.draw(self.finalHeartsSheet, love.graphics.newQuad(0, 0, 10, 10, self.finalHeartsSheet), self.x -30 + i * 15 + self.width/2, self.map.camY + 10)
        end
    end
end





--============================================================================--
