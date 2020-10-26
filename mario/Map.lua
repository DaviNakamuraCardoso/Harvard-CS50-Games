--[[
    Contains tile data and necessary code for rendering a tile map to the
    screen.
]]

require 'Util'
require 'Flag'

Map = Class{}

TILE_BRICK = 1
TILE_EMPTY = -1

-- cloud tiles
CLOUD_LEFT = 6
CLOUD_RIGHT = 7

-- bush tiles
BUSH_LEFT = 2
BUSH_RIGHT = 3

-- mushroom tiles
MUSHROOM_TOP = 10
MUSHROOM_BOTTOM = 11

-- jump block
JUMP_BLOCK = 5
JUMP_BLOCK_HIT = 9

-- Flag
FLAG_TOP = 8
FLAG_MIDDLE = 12
FLAG_BOTTOM = 16
FLAG_ONE = 13
FLAG_TWO = 14
FLAG_THREE = 15

-- a speed to multiply delta time to scroll map; smooth value
local SCROLL_SPEED = 62

-- constructor for our map object
function Map:init(level)

    self.level = level
    self.isPaused = false
    self.nextLevel = false
    local spritesheetName = 'graphics/spritesheetLevel' .. tostring(self.level) .. '.png'
    self.spritesheet = love.graphics.newImage(spritesheetName)
    self.sprites = generateQuads(self.spritesheet, 16, 16)

    self.tileWidth = 16
    self.tileHeight = 16
    self.mapWidth = 50  + self.level * 50
    self.mapHeight = 28
    -- cache width and height of map in pixels
    self.mapWidthPixels = self.mapWidth * self.tileWidth
    self.mapHeightPixels = self.mapHeight * self.tileHeight
    self.tiles = {}

    -- applies positive Y influence on anything affected
    self.gravity = 15

    -- associate player with map
    self.player = Player(self)

    -- camera offsets
    self.camX = 0
    self.camY = -3

    self.sounds = {
        ['kill'] = love.audio.newSource('sounds/kill.wav', 'static'),
        ['kill2'] = love.audio.newSource('sounds/kill2.wav', 'static'),
        ['kill3'] = love.audio.newSource('sounds/kill3.flac', 'static'),
        ['finalDeath'] = love.audio.newSource('sounds/finalDeath.wav', 'static'),
        ['finalScaryEffect'] = love.audio.newSource('sounds/alienTransmission.mp3', 'static'),
        ['finalScaryEffect2'] = love.audio.newSource('sounds/alienSpaceship.wav', 'static')
    }

    if self.level == 10 then
        self.sounds['finalScaryEffect']:play()
        self.sounds['finalScaryEffect2']:play()
        self.sounds['finalScaryEffect']:setLooping(true)
        self.sounds['finalScaryEffect2']:setLooping(true)
        love.graphics.clear(0.5, 0.5, 0.5, 1)
    end



    self.buttonPause = Button(self, VIRTUAL_WIDTH - 60, 10, 21, 20, colors['yellow'])
    self.pauseImage = love.graphics.newImage('graphics/pause.png')
    -- Generate the enemies
    self.enemies = {}
    self.numberOfEnemies = self.level
    for i=1, self.numberOfEnemies do
        local enemyPosition = i * self.mapWidthPixels / (self.numberOfEnemies * 2)
        self.enemies[i] = Enemy(self, 'graphics/redAlien.png', 16, 20, enemyPosition, 0)
    end

    -- first, fill map with empty tile
    for y = 1, self.mapHeight do
        for x = 1, self.mapWidth do

            -- support for multiple sheets per tile; storing tiles as tables
            self:setTile(x, y, TILE_EMPTY)
        end
    end

    for y = self.mapHeight / 2, self.mapHeight do
        for x = 1, self.mapWidth do
            self:setTile(x, y, TILE_BRICK)
        end
    end

    local x
    local l
    if self.level == 10 then
        x = 60
    else
        x = 30
    end
    l = x
    z = x
    while x < self.mapWidth - l do

        -- 3% of chance of generate a piramid
        if math.random(30) == 1 then
            self:generatePiramid(x, self.mapHeight / 2, math.random(5), 'more')
            x = x + 8
        -- 4% of chance of generate a floating island
        elseif math.random(20) then
            local islandHeight = math.random(self.mapHeight / 4, self.mapHeight / 2 - 6)
            local islandWidth = math.random(3, 8)
            local islandG = math.random(1, 3)
            self:generatePiramid(x, self.mapHeight / 2, islandHeight, 'less')
            for i=0, islandWidth do
                for j=0, islandG do
                    self:setTile(x+i, islandHeight+j, TILE_BRICK)
                end
            end
            x = x + 20
        end
    end

    x = 15

    -- Building the piramid
    self:generatePiramid(self.mapWidth - 12, self.mapHeight / 2, 7, 'less')
    -- begin generating the terrain using vertical scan lines
    while x < self.mapWidth-z do
        for y=1, self.mapHeight do
            if self:getTile(x, y) == 1 then
                ground = y
                break
            end
        end
        -- 2% chance to generate a cloud
        -- make sure we're 2 tiles from edge at least
        if x < self.mapWidth - 2 then
            if math.random(20) == 1 then

                -- choose a random vertical spot above where blocks/pipegenerate
                local cloudStart = ground - math.random(5, 8)

                self:setTile(x, cloudStart, CLOUD_LEFT)
                self:setTile(x + 1, cloudStart, CLOUD_RIGHT)
            end
        end
        -- creates column of tiles going to bottom of map
        if math.random(10) == 1 then
            for z =ground, self.mapHeight do
                self:setTile(x, z, TILE_EMPTY)
                self:setTile(x + 1, z, TILE_EMPTY)
            end
            x = x + 2
        elseif math.random(20) == 1 then
            -- 5% chance to generate a mushroom
            -- left side of pipe
            self:setTile(x, ground - 2, MUSHROOM_TOP)
            self:setTile(x, ground - 1, MUSHROOM_BOTTOM)
            self:resetBricks(x, ground)
            x = x + 1

            -- next vertical scan line

            -- 10% chance to generate bush, being sure to generate away from edge
        elseif math.random(10) == 1 and x < self.mapWidth - 3 then

            -- place bush component and then column of bricks
            self:setTile(x, ground-1, BUSH_LEFT)
            self:resetBricks(x, ground)
            x = x + 1

            self:setTile(x, ground-1, BUSH_RIGHT)
            self:resetBricks(x, ground)
            x = x + 1

            -- 10% chance to not generate anything, creating a gap
        elseif math.random(10) ~= 1 then

            -- chance to create a block for Mario to hit
            if math.random(15) == 1 then
                self:setTile(x, ground - 4, JUMP_BLOCK)

            end

            -- next vertical scan line
            x = x + 1
        else
            -- increment X so we skip two scanlines, creating a 2-tile gap
            x = x + 2
        end

    end

    if self.level ~= 10 then
    -- Building the piramid
        self.flag = Flag(self.mapWidth - 7, self.mapHeight / 2, 7, self)

    else
        self.enemies[1] = Enemy(self, 'graphics/finalBoss.png', 100, 100, self.mapWidthPixels - 590, 10)
        self.enemies[1].animation = self.enemies[1].animations['finalBoss']
        self.enemies[1].state = 'finalBoss'
        self.enemies[1].isFinal = true
        self.enemies[1].lives = 5
        self:generatePiramid(self.mapWidth
         - 40, self.mapHeight / 2, 8, 'more')
    end

    -- start the background music
    love.audio.setVolume(0.15)

end

-- return whether a given tile is collidable
function Map:collides(tile)
    -- define our collidable tiles
    local collidables = {
        TILE_BRICK, JUMP_BLOCK, JUMP_BLOCK_HIT,
        MUSHROOM_TOP, MUSHROOM_BOTTOM
    }

    -- iterate and return true if our tile type matches
    for _, v in ipairs(collidables) do
        if tile.id == v then
            return true
        end
    end

    return false
end

-- function to update camera offset with delta time
function Map:update(dt)
    if not self.isPaused then

        self.player:update(dt)
        for i=1, self.numberOfEnemies do
            self.enemies[i]:update(dt)
        end

        if self.level ~= 10 then
            self.flag:update(dt)

        end

        -- keep camera's X coordinate following the player, preventing camera from
        -- scrolling past 0 to the left and the map's width
        self.camX = math.max(0, math.min(self.player.x - VIRTUAL_WIDTH / 2,
            math.min(self.mapWidthPixels - VIRTUAL_WIDTH, self.player.x)))
            self.buttonPause:update()
            if self.buttonPause.clicked then
                self.isPaused = true
            end
    else
        self.buttonPause:update()
        self.player.cover:getCamCoordinates()
        self.player.menuButton:update()
        self.player.buttonTryAgain:update()
        if self.player.menuButton.clicked then
            gameState = 'mainMenu'
        elseif self.player.buttonTryAgain.clicked then
            self:init(self.level)
            gameState = 'play'
        end
        if self.buttonPause.clicked then
            self.isPaused = false
        end

    end

end

-- gets the tile type at a given pixel coordinate
function Map:tileAt(x, y)
    return {
        x = math.floor(x / self.tileWidth) + 1,
        y = math.floor(y / self.tileHeight) + 1,
        id = self:getTile(math.floor(x / self.tileWidth) + 1, math.floor(y / self.tileHeight) + 1)
    }
end

function Map:enemyAt(x, y)
    for i=1, self.numberOfEnemies do
        if  x >= self.enemies[i].x and x <= self.enemies[i].x + self.enemies[i].width and
        y >= self.enemies[i].y and y <= self.enemies[i].y + self.enemies[i].height then
            return self.enemies[i]
        end
    end
end

-- returns an integer value for the tile at a given x-y coordinate
function Map:getTile(x, y)
    return self.tiles[(y - 1) * self.mapWidth + x]
end

-- sets a tile at a given x-y coordinate to an integer value
function Map:setTile(x, y, id)
    self.tiles[(y - 1) * self.mapWidth + x] = id
end

-- renders our map to the screen, to be called by main's render
function Map:render()
    for y = 1, self.mapHeight do
        for x = 1, self.mapWidth do
            local tile = self:getTile(x, y)
            if tile ~= TILE_EMPTY then
                love.graphics.draw(self.spritesheet, self.sprites[tile],
                    (x - 1) * self.tileWidth, (y - 1) * self.tileHeight)
            end
        end
    end

    self.player:render()
    for i=1, self.numberOfEnemies do
        self.enemies[i]:render()
    end
    if self.level ~= 10 then
        self.flag:render()
    else
        self.enemies[1]:render()
    end
    self.buttonPause:render('')
    if self.isPaused then
        love.graphics.draw(self.pauseImage, love.graphics.newQuad(0, 0, 8, 16, self.pauseImage), self.buttonPause.x + self.camX + 6, self.buttonPause.y + self.camY + 2)
    else
        love.graphics.draw(self.pauseImage, love.graphics.newQuad(8, 0, 8, 16, self.pauseImage), self.buttonPause.x + self.camX + 6, self.buttonPause.y + self.camY + 2)

    end
end


function Map:getCamCoordinates()
    return {
        x = self.camX,
        y = self.camY
    }
end


function Map:resetBricks(x, ground)
    for y=ground, self.mapHeight do
        self:setTile(x, y, TILE_BRICK)
    end
end

function Map:generatePiramid(x, y, height, type)
    if type == 'less' then
        -- Build a one-side piramid
        for i=0, height do
            for j=0, height-i do
                self:setTile(x - j, y - i, TILE_BRICK)
                self:resetBricks(x, y, TILE_BRICK)
            end
        end
    else
        -- Build a 2 side piramid
        for i=0, height do
            for j=-height+i, height-i do
                self:setTile(x - j, y - i, TILE_BRICK)
                self:resetBricks(x, y-i, TILE_BRICK)
            end
        end
    end

end


function Map:enemyKilling()
    for i=1, self.numberOfEnemies do
        if self.player.x + self.player.width >= self.enemies[i].x and self.enemies[i].x + self.enemies[i].width > self.player.x and self.player.y + self.player.height > self.enemies[i].y and self.player.y < self.enemies[i].y + self.enemies[i].height and self.enemies[i].isAlive and not self.enemies[i].isFinal then
            if self.player.y + self.player.height > self.enemies[i].y + self.enemies[i].height / 2 then
                -- Plays the sound
                self.sounds['kill']:play()

                -- Player in dying state
                self.player.groundPosition = self.player.y
                self.player.state = 'dying'
                self.player.animation = self.player.animations['dying']

                -- Enemy in fly state
                if not self.enemies[i].isFinal then
                    self.enemies[i].y = self.enemies[i].y - 5
                    self.enemies[i].direction = -1
                    self.enemies[i].state = 'fly'
                    self.enemies[i].animation = self.enemies[i].animations['fly']
                end
            else

                self.enemies[i].lives = self.enemies[i].lives - 1
                self.sounds['kill2']:play()


                self.player.state = 'killing'
                self.player.animation = self.player.animations['killing']
                self.player.enemiesKilled = self.player.enemiesKilled + 1
            end
        end
    end
end


function Map:checkFinalCollision()
    if self.player.x < self.enemies[1].x + 3 * self.enemies[1].width / 4 and
    self.player.x + self.player.width > self.enemies[1].x + self.enemies[1].width / 4 then
        if self.player.y + self.player.height > self.enemies[1].y and self.player.y < self.enemies[1].y then
            self.player.dy = -400
            self.player.y = self.enemies[1].y - self.player.height - 2
            self.player.state = 'jumping'
            self.player.animation = self.player.animations['jumping']
            self.player.dx = 200

            -- The consequences for the enemy
            self.enemies[1].lives = self.enemies[1].lives - 1
            self.sounds['kill3']:play()
            if self.enemies[1].lives == 0 then
                self.sounds['finalDeath']:play()
            end
        end
    end
end


function Map:show(dt)
    self.camX = math.ceil(self.camX + 30 * dt)
    self.buttonPause:update()
    for i=1, self.numberOfEnemies do
        self.enemies[i]:update(dt)
    end
end
