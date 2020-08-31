WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 432 -- Emulates a smaller screen
VIRTUAL_HEIGHT = 243

push = require "push"

function love.load()
    -- set the window size and the window properties
    love.graphics.setDefaultFilter('nearest', 'nearest')

    small_font = love.graphics.newFont('dogica.ttf', 8)
    love.graphics.setFont(small_font)

    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        vsync = true,
        resizable = false
    })
end


function love.draw()
    -- Print Hello Pong in the middle of the screen
    push:apply('start')

    love.graphics.clear(40 / 255, 45 / 255, 52 / 255, 1)

    love.graphics.rectangle('fill',
    VIRTUAL_WIDTH / 2 - 2,              -- X position
    VIRTUAL_HEIGHT / 2 - 2,             -- Y position
    5,                              -- width
    5)                              -- height

    love.graphics.rectangle('fill', 5, 20, 5, 20)

    love.graphics.rectangle('fill', VIRTUAL_WIDTH-10, VIRTUAL_HEIGHT - 40, 5, 20)

    love.graphics.printf('Hello Pong!', -- Message
    0,                                  -- X position
    20,                                  -- Y position
    VIRTUAL_WIDTH,                       -- From WINDOW_WIDTH get...
    'center')                           -- ...center
    push:apply('end')
end


function love.keypressed(key)
    -- Identifies the keys pressed
    if key == 'escape' then -- If escape pressed, quit
        love.event.quit()
    end
end
