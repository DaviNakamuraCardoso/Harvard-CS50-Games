--========================== Generating the Quads ============================--

require 'characters'

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


function generateAnimation(character, table)

    frames = {}
    quads = {}
    local index = 0
    if #table == 2 then

        for i=table[1], table[2]+1 do
            local image = 'graphics/' .. character.name .. '/' .. tostring(i) .. '.png'
            frames[index] = love.graphics.newImage(image)
            quads[index] = love.graphics.newQuad(0, 0, frames[index]:getWidth(),    frames[index]:getHeight(), frames[index]:getWidth(), frames[index]:getHeight())
            index = index + 1
        end
    else
        for i=1, #table do
            local image = 'graphics/' .. character.name .. '/' .. tostring(table[i]) .. '.png'
            frames[i] = love.graphics.newImage(image)
            quads[i] = love.graphics.newQuad(0, 0, frames[i]:getWidth(), frames[i]:getHeight(), frames[i]:getDimensions())
        end
    end

    return {
        frames = frames,
        quads = quads
    }
end











--============================================================================--
