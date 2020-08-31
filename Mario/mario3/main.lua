--===================== My version of Mario made in Lua ======================--

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 243

-- Push library from https://github.com/Ulydev/push
push = require "push"

-- Class library from https://github.com/tenry92/class.luaw
require("class")

require 'utils'
require 'Map'
--============================================================================--



function love.load()

    math.randomseed(os.time())
    -- Set the filter to no blurs
    love.graphics.setDefaultFilter('nearest', 'nearest')

    -- Loads the map
    map = Map()

    -- Set up the screen
    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
            resizable = false,
            fullscreen = false,
            vsync = true
    })
end


function love.update(dt)
    -- Udpates the map width
    map:update(dt)
end


function love.draw()
    push:apply('start')

    love.graphics.clear(108 / 255, 140 / 255, 1, 1)
    love.graphics.translate(math.floor(-map.camX), math.floor(-map.camY))

    -- Renders the map
    map:render()

    push:apply('end')
end






























--============================================================================--
