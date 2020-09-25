--=========================== Invasion - A game =============================--



VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 243


WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720


local push = require "push"


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
    -- body...
    love.graphics.print("Hello, World!")



end














--============================================================================--
