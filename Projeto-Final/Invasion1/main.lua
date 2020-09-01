--=========================== Invasion - A game =============================--



VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 243


WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

--//____________________________ Imported Libraries ________________________\\--
local push = require "push"


require "Util"

function love.load()

    --//__________________________ Screen ______________________________\\--
    love.graphics.setDefaultFilter('nearest', 'nearest')


    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT,
    {
        resizable = false,                    -- Disables the resizing
        fullscreen = true                     -- Displays in fullscreen
    })

end

function love.update(dt)


end


function love.draw()

    push:apply('start')
    -- body...
    love.graphics.print("Hello, World!")
    backgroundImage = love.graphics.newImage('graphics/background.jpg')
    backgroundQuads = generateQuads('graphics/background.jpg', 720, 240)
    love.graphics.draw(backgroundImage, backgroundQuads[0], 0, 0)

    push:apply('end')




end

function love.keypressed(key)
    -- body...
    if key == 'escape' then
        love.event.quit()
    end
end













--============================================================================--
