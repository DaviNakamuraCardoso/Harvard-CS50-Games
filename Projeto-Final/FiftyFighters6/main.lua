--=========================== Invasion - A game =============================--



VIRTUAL_WIDTH = 640
VIRTUAL_HEIGHT = 380
 

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

--//____________________________ Imported Libraries ________________________\\--
local push = require "push"
Class = require 'class'




require "Util"
--//________________________________ Classes _______________________________\\--
require 'Animation'
require 'Map'
require 'Player'



function love.load()

    --//__________________________ Screen ______________________________\\--
    love.graphics.setDefaultFilter('nearest', 'nearest')


    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT,
    {
        resizable = false,                    -- Disables the resizing
        fullscreen = false                     -- Displays in fullscreen
    })

    map = Map()

    love.keyboard.wasPressed =  {}

end

function love.update(dt)

    map:update(dt)
    love.keyboard.wasPressed =  {}

end


function love.draw()

    push:apply('start')
    -- body...
    love.graphics.translate(math.floor(-map.camX), math.floor(-map.camY))
    map:render()

    push:apply('end')



end

function love.keypressed(key)
    -- body...
    if key == 'escape' then
        love.event.quit()
    end
    love.keyboard.wasPressed[key] = true
end















--============================================================================--
