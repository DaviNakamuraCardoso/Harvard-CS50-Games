--========================== Generating the Quads ============================--

function generateQuads(sheet, width, height)
    -- Load the sheet into a image
    spritesheet = love.graphics.newImage(sheet)

    -- Spritesheet Dimensions
    spritesheetWidth = spritesheet:getWidth()
    spritesheetHeight = spritesheet:getHeight()


    quads = {}

    local index = 0

    for i=0, spritesheetWidth - width, width do
        for j=0, spritesheetHeight - height, height do
            quads[index] = love.graphics.newQuad(i, j, width, height, spritesheetWidth, spritesheetHeight)
            index = index + 1
        end
    end

    return quads
end
