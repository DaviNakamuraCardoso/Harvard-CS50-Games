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

    for y=1,self.mapHeight do
        for x=1,self.mapWidth do
            -- Filling the map with empty tiles
            self:setTile(x, y, TILE_EMPTY)
        end
    end

    for y=self.mapHeight - 6, self.mapHeight do
        -- Filling the bottom with bricks
        for x=1, self.mapWidth do
            self:setTile(x, y, TILE_BRICK)
        end
    end

end

function Map:udpate(dt)
    self.camX = self.camX + SCROOL_SPEED * dt


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
