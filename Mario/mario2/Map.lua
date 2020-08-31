Map = Class()

TILE_BRICK = 1
TILE_CLOUD = 2
TILE_EMPTY = 4

SCROOL_SPEED = 60

function Map:construct()
    self.spritesheet = love.graphics.newImage('graphics/spritesheet.png')
    self.tileWidth = 16
    self.tileHeight = 16
    self.mapWidth = 30
    self.mapHeight = 28
    self.tiles = {}
    self.camX = 0
    self.camY = 0


    -- Generate the Quads (aka sprites)
    self.tileSprites = generateQuads(self.spritesheet, self.tileWidth, self.tileHeight)

    self.mapWidthPixels = self.mapWidth * self.tileWidth
    self.mapHeightPixels = self.mapHeight * self.tileHeight


    for y=1,self.mapHeight do
        for x=1,self.mapWidth do
            -- Filling the map with empty tiles
            self:setTile(x, y, TILE_EMPTY)
        end
    end

    for y=self.mapHeight/2, self.mapHeight do
        -- Filling the bottom with bricks
        for x=1, self.mapWidth do
            self:setTile(x, y, TILE_BRICK)
        end
    end

end

function Map:udpate(dt)
    if love.keyboard.isDown('w') then
        -- Up movement
        self.camY = math.max(0, math.floor(self.camY + dt * -SCROOL_SPEED))
    elseif love.keyboard.isDown('a') then
        -- Left movement
        self.camX = math.max(0, math.floor(self.camX + dt * -SCROOL_SPEED))
    elseif love.keyboard.isDown('s') then
        -- Down movement
        self.camY = math.min(math.floor(self.camY + dt * SCROOL_SPEED), self.mapHeightPixels - VIRTUAL_HEIGHT)
    elseif love.keyboard.isDown('d') then
        -- Right movement'
        self.camX = math.min(math.floor(self.camX + dt * SCROOL_SPEED), self.mapWidthPixels - VIRTUAL_WIDTH)
    end

end


function Map:render()
    for y = 1,self.mapHeight do
        -- body...
        for x=1,self.mapWidth do
            -- body...
            love.graphics.draw(self.spritesheet, self.tileSprites[self:getTile(x, y)],
                (x - 1) * self.tileWidth, (y - 1) * self.tileHeight)
        end
    end
end

function Map:setTile(x, y, tile)
    -- Translate a 1 dimension array into a matrix
    self.tiles[(y-1) * self.mapWidth + x] = tile
end

function Map:getTile(x, y)
    -- Translate a 1 dimension array into a matrix
    return self.tiles[(y-1) * self.mapWidth + x]
end
