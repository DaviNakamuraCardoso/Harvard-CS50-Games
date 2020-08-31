--============================ Block generator ==============================--


--============================================================================--

--======================= Turns the sprites into quads =======================--
function generateQuads(atlas, tilewidth, tileheight)

    quads = {}
    -- How many tiles wide is the sheet
    local sheetWidth = atlas:getWidth() / tilewidth

    -- How many tiles height is the sheet
    local sheetHeight = atlas:getHeight() / tileheight

    local sheetCounter = 1

    for y=0, sheetHeight-1 do
        -- body...
        for x= 0, sheetWidth-1 do
            quads[sheetCounter] = love.graphics.newQuad(x * tilewidth, y * tileheight, tilewidth, tileheight, atlas:getDimensions())
            sheetCounter = sheetCounter + 1
        end
    end

    return quads

end
--============================================================================--
