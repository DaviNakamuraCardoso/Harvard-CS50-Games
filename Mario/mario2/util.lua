--============================ Generate the Quads ============================--

-- Generate Quads based on a atlas (aka spritesheet), a tileWidth and tileHeight
function generateQuads(atlas, tilewidth, tileheight)

    -- How many tiles wide is our sheet
    local sheetWidth = atlas:getWidth() / tilewidth

    -- How many tiles height is our sheet 
    local sheetHeight = atlas:getHeight() / tileheight


    local sheetCounter = 1
    local quads = {}

    for y=0, sheetHeight - 1 do
        -- body...
        for x=0, sheetWidth - 1 do
            -- body...
            quads[sheetCounter] = love.graphics.newQuad(x * tilewidth, y * tileheight, tilewidth, tileheight, atlas:getDimensions())
            sheetCounter = sheetCounter + 1
        end
    end

    return quads
end

--============================================================================--
