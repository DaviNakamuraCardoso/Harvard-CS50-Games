--========================== Fifty Fighters - A game =========================--



VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 243


WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

--//__________________________ Imported Libraries __________________________\\--
local push = require "push"
Class = require 'class'


math.randomseed(os.clock())

require "Util"
--//________________________________ Classes _______________________________\\--
require 'Animation'
require 'Map'
require 'Player'
require 'Projectile'
require 'Button'
require 'Message'



math.randomseed(os.time())

function love.load()

    --//__________________________ Screen ______________________________\\--
    love.graphics.setDefaultFilter('nearest', 'nearest')

    love.window.setTitle('Fifty Fighters - Beta Version')




    map = Map('Select')

    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT,
    {
        resizable = false,                    -- Disables the resizing
        fullscreen = false                     -- Displays in fullscreen
    })


    love.keyboard.wasPressed =  {}
    mouse = {
        ['clicked'] = false,
        ['updated'] = false
    }


end

function love.update(dt)

    updateMouse()
    map:update(dt)
    love.keyboard.wasPressed =  {}




end


function love.draw()

    push:apply('start')
    -- body...
    love.graphics.clear(160 / 255, 170 / 255, 227 / 255, 1)
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


function updateMouse()
    if love.mouse.isDown(1) then
        if not mouse['updated'] then
            mouse['clicked'] = true
            mouse['updated'] = true
        else
            mouse['clicked'] = false
        end
    else
        mouse['updated'] = false
        mouse['clicked'] = false
    end
end











--============================================================================--
