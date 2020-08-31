--=========================== Map Object =====================================--

Map = Class()


--//____________________________ Sprite Numbers ____________________________\\--

TILE_BRICK = 1
TILE_EMPTY = 4

-- Cloud tiles
CLOUD_LEFT = 6
CLOUD_RIGHT = 7

-- Bush tiles
BUSH_LEFT = 2
BUSH_RIGHT = 3

-- Mushroom tiles
MUSHROOM_TOP = 10
MUSHROOM_BOTTOM = 11

-- Jump blocks
JUMP_BLOCK = 5

-- Flags
FLAG_TOPSUPPORT = 8
FLAG_MIDDLESUPPORT = 12
FLAG_BOTSUPPORT = 16
FLAG_FRONT = 13

--\\________________________________________________________________________//--


local SCROOL_SPEED = 62

--============================================================================--


--================================ Init ======================================--

function Map:construct()
    self.spriteSheet = love.graphics.newImage('graphics/spritesheet.png')
    self.tileWidth = 16
    self.tileHeight = 16
    self.mapWidth = 30
    self.mapHeight = 28
    self.tiles = {}
    self.camY = 0
    self.camX = 0

    -- Generates the quads
    self.tileSprites = generateQuads(self.spriteSheet, self.tileWidth, self.tileHeight)

    self.mapWidthPixels = self.tileWidth * self.mapWidth
    self.mapHeightPixels = self.tileHeight * self.mapHeight

    for  y=1, self.mapHeight do
        for x=1, self.mapWidth do
            -- Filling the screen with empty blocks
            self:setTile(x, y, TILE_EMPTY)
        end
    end

    for y=self.mapHeight/2, self.mapHeight do
        for x=1, self.mapWidth do
            -- Fill the bottom of the screen with bricks
            self:setTile(x, y, TILE_BRICK)
        end
    end

    local x = 1
    while x < self.mapWidth do
        -- 4% of chance of generating a cloud
        if x < self.mapWidth-2 then
            if math.random(10) == 1 then
                -- Cloud y position is somewhere between the middle of the screen (where the bricks are) + 6 tiles and the top
                local cloudStart = math.random(self.mapHeight / 2 - 6)
                self:setTile(x, cloudStart, CLOUD_LEFT)
                self:setTile(x + 1, cloudStart, CLOUD_RIGHT)
            end
        end

        if math.random(20) == 1 then
            -- Left side of mushroom
            self:setTile(x, self.mapHeight / 2 - 2, MUSHROOM_TOP)
            self:setTile(x, self.mapHeight / 2 - 1, MUSHROOM_BOTTOM)

            -- Create a column of tiles
            for y=self.mapHeight/2, self.mapHeight do
                self:setTile(x, y, TILE_BRICK)
            end
            x = x + 1

        elseif math.random(10) == 1 and x < self.mapWidth - 3 then
            local bushLevel = self.mapHeight / 2 - 1

            -- place bush component and then column of bricks
            self:setTile(x, bushLevel, BUSH_LEFT)
            self:setTile(x + 1, bushLevel, BUSH_RIGHT)
            for y = self.mapHeight / 2, self.mapHeight do
                self:setTile(x, y, TILE_BRICK)
            end
            x = x + 2
        elseif math.random(10) ~= 1 then

            -- Creates a column of tiles going to bottom of the map
            for y=self.mapWidth/2, self.mapWidth do
                self:setTile(x, y, TILE_BRICK)
            end

            -- Chance to create a block to hit
            if math.random(15) == 1 then
                self:setTile(x, self.mapHeight / 2 - 4, JUMP_BLOCK)
            end

            -- Next vertical scan value
            x = x + 1
        else
            x = x + 2
        end
        x = x + 1
    end
end

--=========================== Updates the map ================================--

function Map:update(dt)
    if love.keyboard.isDown('w') then
        -- Goes up
        self.camY = math.max(0, math.floor(self.camY + -SCROOL_SPEED * dt))

    elseif love.keyboard.isDown('s') then
        -- Goes down
        self.camY = math.min(math.floor(self.camY + dt * SCROOL_SPEED), self.mapHeightPixels - VIRTUAL_HEIGHT)

    elseif love.keyboard.isDown('a') then
        -- Goes left
        self.camX = math.max(0, math.floor(self.camX - SCROOL_SPEED * dt))

    elseif love.keyboard.isDown('d') then
        -- Goes right
        self.camX = math.min(self.camX + dt * SCROOL_SPEED, self.mapWidthPixels - VIRTUAL_WIDTH)
    end
end
--============================================================================--

--=============================== Draw the map ===============================--
function Map:render()
    for y=1, self.mapHeight do
        for x=1, self.mapWidth do
            love.graphics.draw(self.spriteSheet, self.tileSprites[self:getTile(x, y)], (x-1) * self.tileWidth, (y-1) * self.tileHeight)
        end
    end
end
--============================================================================--

--=============== Set the tile in position x, y to the number tile ===========--
function Map:setTile(x, y, tile)
    self.tiles[(y-1) * self.mapWidth + x] = tile
end
--============================================================================--

--================== Get the number of the tile in x and y position ==========--
function Map:getTile(x, y)
    return self.tiles[(y-1) * map.mapWidth + x]
end
--============================================================================--






















--============================================================================--
