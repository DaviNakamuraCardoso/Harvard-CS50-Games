--[[
    Represents our player in the game, with its own sprite.
]]

Player = Class{}



local WALKING_SPEED = 140
local JUMP_VELOCITY = 400

function Player:init(map)

    self.x = 0
    self.y = 0
    self.width = 16
    self.height = 20
    self.lives = 3
    self.generateNewLevel = false

    -- offset from top left to center to support sprite flipping
    self.xOffset = 8
    self.yOffset = 10

    -- reference to map for checking tiles
    self.map = map
    self.texture = love.graphics.newImage('graphics/blueAlien.png')
    self.score = 0
    self.coins = 0
    self.enemiesKilled = 0



    -- sound effects

    self.sounds = {
        ['jump'] = love.audio.newSource('sounds/jump.wav', 'static'),
        ['hit'] = love.audio.newSource('sounds/hit.wav', 'static'),
        ['coin'] = love.audio.newSource('sounds/coin.wav', 'static'),
        ['winning'] = love.audio.newSource('sounds/powerup-reveal.wav', 'static'),
        ['reviving'] = love.audio.newSource('sounds/twinkle.wav', 'static'),
        ['triumph'] = love.audio.newSource('sounds/triumph.wav', 'static'),
        ['score'] = love.audio.newSource('sounds/score.wav', 'static'),
        ['box'] = love.audio.newSource('sounds/box.wav', 'static'),
        ['gameOver'] = love.audio.newSource('sounds/gameOver.wav', 'static')
    }

    -- animation frames
    self.frames = {}

    -- current animation frame
    self.currentFrame = nil

    -- used to determine behavior and animations
    self.state = 'idle'

    -- determines sprite flipping
    self.direction = 'left'

    -- x and y velocity
    self.dx = 0
    self.dy = 0


    -- position on top of map tiles
    self.y = map.tileHeight * ((map.mapHeight - 2) / 2) - self.height
    self.groundPosition = self.y
    self.x = 5 * self.map.tileWidth

    self.hearts = love.graphics.newImage('graphics/heart.png')


    self.cover = Block(map, 0, 0, VIRTUAL_WIDTH, VIRTUAL_HEIGHT, colors['black'])
    self.cover.message.size = 28
    self.cover.message.y = 30
    self.nextLevelButton = Button(map, VIRTUAL_WIDTH / 2 - 50, VIRTUAL_HEIGHT / 3, 100, 20, colors['yellow'])
    self.menuButton = Button(map, VIRTUAL_WIDTH / 2 - 50, VIRTUAL_HEIGHT / 3 + 30, 100, 20, colors['yellow'])
    self.buttonTryAgain = Button(map, VIRTUAL_WIDTH / 2 - 50, VIRTUAL_HEIGHT / 3, 100, 20, colors['yellow'])

    -- Messages
    self.messageRevive = Message(0, VIRTUAL_HEIGHT / 3, 'fonts/four.ttf', 14, colors['white'])
    self.messageScore = Message(0, VIRTUAL_HEIGHT / 2 + 20, 'fonts/four.ttf', 14, colors['white'])
    self.messageBoxes = Message(0, VIRTUAL_HEIGHT / 2 + 50, 'fonts/four.ttf', 14,
    colors['white'])
    self.messageEnemies = Message(0, VIRTUAL_HEIGHT / 2 + 30, 'fonts/four.ttf', 14, colors['white'])
    self.messageCredits = Message(0, VIRTUAL_HEIGHT / 2, 'fonts/pixelu.ttf', 8, colors['white'])

    -- initialize all player animations
    self.animations = {
        ['idle'] = Animation({
            texture = self.texture,
            frames = {
                love.graphics.newQuad(0, 0, 16, 20, self.texture:getDimensions())
            }
        }),
        ['walking'] = Animation({
            texture = self.texture,
            frames = {
                love.graphics.newQuad(128, 0, 16, 20, self.texture:getDimensions()),
                love.graphics.newQuad(144, 0, 16, 20, self.texture:getDimensions()),
                love.graphics.newQuad(160, 0, 16, 20, self.texture:getDimensions()),
                love.graphics.newQuad(176, 0, 16, 20, self.texture:getDimensions()),
            },
            interval = 0.15
        }),
        ['jumping'] = Animation({
            texture = self.texture,
            frames = {
                love.graphics.newQuad(32, 0, 16, 20, self.texture:getDimensions())
            }
        }),
        ['winning'] = Animation({
            texture = self.texture,
            frames = {
                love.graphics.newQuad(48, 0, 16, 20, self.texture:getDimensions())
            },
            interval = 0.05
        }),
        ['dying'] = Animation({
            texture = self.texture,
            frames = {
                love.graphics.newQuad(64, 0, 16, 20, self.texture:getDimensions())
            }
        }),
        ['killing'] = Animation({
            texture = self.texture,
            frames = {
                love.graphics.newQuad(16, 0 ,16, 20, self.texture:getDimensions())
            }
        }),
        ['reviving'] = Animation({
            texture = self.texture,
            frames = {
                [1] = love.graphics.newQuad(0, 0, 16, 20, self.texture:getDimensions()),
                [2] = love.graphics.newQuad(176, 0, 16, 20, self.texture:getDimensions()),
                [3] = love.graphics.newQuad(0, 0, 16, 20, self.texture:getDimensions())
            },
            interval = 0.15
        })
    }

    -- initialize animation and current frame we should render
    self.animation = self.animations['idle']
    self.currentFrame = self.animation:getCurrentFrame()

    -- behavior map we can call based on player state
    self.behaviors = {
        ['idle'] = function(dt)

            -- add spacebar functionality to trigger jump state
            if love.keyboard.wasPressed('space') then
                self.dy = -JUMP_VELOCITY
                self.state = 'jumping'
                self.animation = self.animations['jumping']
                self.sounds['jump']:play()
            elseif love.keyboard.isDown('left') then
                self.direction = 'left'
                self.dx = -WALKING_SPEED
                self.state = 'walking'
                self.animations['walking']:restart()
                self.animation = self.animations['walking']
            elseif love.keyboard.isDown('right') then
                self.direction = 'right'
                self.dx = WALKING_SPEED
                self.state = 'walking'
                self.animations['walking']:restart()
                self.animation = self.animations['walking']
            else
                self.dx = 0
            end
            self.map:enemyKilling()
        end,
        ['walking'] = function(dt)

            -- keep track of input to switch movement while walking, or reset
            -- to idle if we're not moving
            if love.keyboard.wasPressed('space') then
                self.dy = -JUMP_VELOCITY
                self.state = 'jumping'
                self.animation = self.animations['jumping']
                self.sounds['jump']:play()
            elseif love.keyboard.isDown('left') then
                self.direction = 'left'
                self.dx = -WALKING_SPEED
            elseif love.keyboard.isDown('right') then
                self.direction = 'right'
                self.dx = WALKING_SPEED
                self.score = self.score + 1
            else
                self.dx = 0
                self.state = 'idle'
                self.animation = self.animations['idle']
            end

            -- check for collisions moving left and right

            if self.map.level ~= 10 then
                self:checkFlagCollision()

            else
                self.map:checkFinalCollision()
            end
            if self.state ~= 'winning' then
                self:checkRightCollision()
                self:checkLeftCollision()
            end
            self.map:enemyKilling()

            -- check if there's a tile directly beneath us
            if not self.map:collides(self.map:tileAt(self.x, self.y + self.height)) and
                not self.map:collides(self.map:tileAt(self.x + self.width - 1, self.y + self.height)) then

                -- if so, reset velocity and position and change state
                self.state = 'jumping'
                self.animation = self.animations['jumping']
            end
        end,
        ['jumping'] = function(dt)
            -- break if we go below the surface
            if self.y > 300 then
                self.lives = 0
                return
            end

            if love.keyboard.isDown('left') then
                self.direction = 'left'
                self.dx = -WALKING_SPEED
            elseif love.keyboard.isDown('right') then
                self.direction = 'right'
                self.dx = WALKING_SPEED
            end

            -- apply map's gravity before y velocity
            self.dy = self.dy + self.map.gravity

            -- check if there's a tile directly beneath us
            if self.map:collides(self.map:tileAt(self.x, self.y + self.height)) or
                self.map:collides(self.map:tileAt(self.x + self.width - 1, self.y + self.height)) then

                -- if so, reset velocity and position and change state
                self.dy = 0
                self.state = 'idle'
                self.animation = self.animations['idle']
                self.y = (self.map:tileAt(self.x, self.y + self.height).y - 1) * self.map.tileHeight - self.height
            end

            -- check for collisions moving left and right
            if self.map.level ~= 10 then
                self:checkFlagCollision()

            else
                self.map:checkFinalCollision()
            end
            if self.state ~= 'winning' then
                self:checkRightCollision()
                self:checkLeftCollision()


            end
            self.map:enemyKilling()
        end,

        ['winning'] = function(dt)
            self.x = (self.map.flag.x - 1) * self.map.tileWidth
            self.dx = 0
            if self.y >= math.floor(self.map.mapHeightPixels / 2 - self.height - self.map.tileHeight) then
                self.dy = 0
                self.map.newLevel = true
                self.sounds['triumph']:play()
                self.state = 'waiting'
            else
                self.dy = self.map.gravity * 3
                self.y = math.floor(math.min(self.map.mapHeightPixels / 2 - self.height -   self.map.tileHeight, self.y + self.dy * dt))

            end
        end,
        ['waiting'] = function(dt)

        end,
        ['dying'] = function(dt)
            self.dx = 0
            if self.y + self.height < self.map.mapHeightPixels then
                self.dy = self.map.gravity * 8
                if self.dx > 0 then
                    self.dx = self.dx * 0.5
                end
            else
                self.lives = self.lives - 1

                self.state = 'reviving'
                self.dy = 0
                self.animation = self.animations['reviving']
            end
        end,
        ['killing'] = function(dt)
            self.dy = -JUMP_VELOCITY
            self.y = self.y - self.height / 2
            self.state = 'jumping'
        end,
        ['reviving'] = function(dt)
            self.animation = self.animations['reviving']
            self.dy = 0
            self.y = self.groundPosition
            if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
                self.state = 'jumping'
                self.animation = self.animations['jumping']
            end
        end
    }
end

function Player:update(dt)
    self.behaviors[self.state](dt)
    self.animation:update(dt)
    self.currentFrame = self.animation:getCurrentFrame()
    self.x = math.floor(self.x + self.dx * dt)
    self.messageRevive:update(dt)

    self.messageBoxes:getCamCoordinates(self.map)
    self.messageScore:getCamCoordinates(self.map)
    self.messageRevive:getCamCoordinates(self.map)

    self.cover:getCamCoordinates(self.map)
    self:calculateJumps()

    -- apply velocity
    self.y = self.y + self.dy * dt

    -- Buttons
    if self.map.newLevel then
        self.menuButton:update()
        if self.menuButton.clicked then
            gameState = 'mainMenu'
        end
        if self.map.level ~= 10 then
            self.nextLevelButton:update()
            levelsButtons.buttonsUnlocked[self.map.level + 1] = true
        end
        self.buttonTryAgain:update()

    elseif self.lives <= 0 and gameState == 'play' then
        gameState = 'gameOver'
        self.sounds['gameOver']:play()
        self.state = 'waiting'
    elseif gameState == 'gameOver' or self.map.isPaused then
        self.buttonTryAgain:update()
        self.menuButton:update()
        if self.menuButton.clicked then
            map = Map(self.map.level)
            gameState = 'mainMenu'
        elseif self.buttonTryAgain.clicked then
            map = Map(self.map.level)
            gameState = 'play'
        end
    end



end

-- jumping and block hitting logic
function Player:calculateJumps()

    -- if we have negative y velocity (jumping), check if we collide
    -- with any blocks above us
    if self.dy < 0 then

        if self.map:collides(self.map:tileAt(self.x, self.y))  or self.map:collides(self.map:tileAt(self.x + self.width - 1, self.y)) then
            -- reset y velocity
            self.dy = 0

            -- change block to different block
            local playCoin = false
            local playHit = false
            if self.map:tileAt(self.x, self.y).id == JUMP_BLOCK then
                local enemy = self.map:enemyAt(self.x + self.width, self.y - 3 * self.map.tileHeight/2)
                if enemy then
                    enemy.isAlive = false
                    enemy.state = 'dying'
                end
                self.map:setTile(math.floor(self.x / self.map.tileWidth) + 1,
                    math.floor(self.y / self.map.tileHeight) + 1, JUMP_BLOCK_HIT)
                playCoin = true
            else
                playHit = true
            end
            if self.map:tileAt(self.x + self.width - 1, self.y).id == JUMP_BLOCK then
                local enemy2 = self.map:enemyAt(self.x + self.width, self.y - 3 * self.map.tileHeight / 2)
                if enemy2 then
                    enemy2.state = 'dying'
                    enemy2.isAlive = false

                end

                self.map:setTile(math.floor((self.x + self.width - 1) / self.map.tileWidth) + 1,
                    math.floor(self.y / self.map.tileHeight) + 1, JUMP_BLOCK_HIT)
                playCoin = true
            else
                playHit = true
            end

            if playCoin then
                self.sounds['coin']:play()
                self.score = self.score + 50
                self.coins = self.coins + 1
            elseif playHit then
                self.sounds['hit']:play()
            end
        end
    end
end

-- checks two tiles to our left to see if a collision occurred
function Player:checkLeftCollision()
    if self.dx < 0 then
        -- check if there's a tile directly beneath us
        if self.map:collides(self.map:tileAt(self.x - 1, self.y)) or
            self.map:collides(self.map:tileAt(self.x - 1, self.y + self.height - 1)) then

            -- if so, reset velocity and position and change state
            self.dx = 0
            self.x = self.map:tileAt(self.x - 1, self.y).x * self.map.tileWidth
        end
    end
end

-- checks two tiles to our right to see if a collision occurred
function Player:checkRightCollision()
    if self.dx > 0 then
        -- check if there's a tile directly beneath us
        if self.map:collides(self.map:tileAt(self.x + self.width, self.y)) or
            self.map:collides(self.map:tileAt(self.x + self.width, self.y + self.height - 1)) then

            -- if so, reset velocity and position and change state
            self.dx = 0
            self.x = (self.map:tileAt(self.x + self.width, self.y).x - 1) * self.map.tileWidth - self.width
        end
    end
end

function Player:checkFlagCollision()
    if self.x >=(self.map.flag.x - 1) * self.map.tileWidth then
        self.y = math.max((self.map.flag.y - self.map.flag.height - 1) * self.map.tileHeight, self.y)
        self.state = 'winning'
        self.sounds['winning']:play()
        self.animation = self.animations['winning']
        self.map.flag.currentFrame = 2
        self.dx = 0
        self.dy = self.map.gravity / 2
    end
end



function Player:render()
    local scaleX

    -- set negative x scale factor if facing left, which will flip the sprite
    -- when applied
    if self.direction == 'right' then
        scaleX = 1
    else
        scaleX = -1
    end

    -- draw sprite with scale factor and offsets
    love.graphics.draw(self.texture, self.currentFrame, math.floor(self.x + self.xOffset),
        math.floor(self.y + self.yOffset), 0, scaleX, 1, self.xOffset, self.yOffset)

    for i=1, self.lives do
        love.graphics.draw(self.hearts, love.graphics.newQuad(0, 0, 16, 16, self.hearts), self.map.camX + i * 20, self.map.camY + 10)
    end

    if self.state == 'reviving' then
        self.messageRevive:twinkle('PRESS ENTER TO REVIVE', 0.4, self.sounds['reviving'])
    end

    -- Buttons and cover

    if self.map.newLevel then

        if self.map.level ~= 10 then
            self.cover:render('LEVEL ' .. tostring(self.map.level) .. ' COMPLETE!')
            self.nextLevelButton:render('NEXT LEVEL')
            if self.nextLevelButton.clicked then
                self.generateNewLevel = true
            end

        else
            self.cover:render('FINAL LEVEL COMPLETE!')
        end
        self.menuButton:render('MENU')

        -- Messages
        self.messageScore:prettyShow(self.score, self.sounds['score'],'SCORE:', 4)
        self.messageBoxes:prettyShow(self.coins, self.sounds['box'],'BOXES COLLECTED:   ', 1)


    elseif gameState == 'gameOver' then
        self.cover:render('GAME OVER')
        self.buttonTryAgain:render('TRY AGAIN')
        self.menuButton:render('MENU')

    elseif self.map.isPaused then
        self.cover:render('GAME PAUSED')
        self.buttonTryAgain:render('RESTART')
        self.menuButton:render('MENU')
    end
end
