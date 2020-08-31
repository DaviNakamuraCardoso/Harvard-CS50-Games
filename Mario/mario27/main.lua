--[[
    Super Mario Bros. Demo
    Author: Colton Ogden
    Original Credit: Nintendo

    Demonstrates rendering a screen of tiles.
]]

Class = require 'class'
push = require 'push'

require 'Animation'
require 'Map'
require 'Player'
require 'Enemy'
require 'Block'
require 'Message'
require 'Button'

-- close resolution to NES but 16:9
VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 243

-- actual window resolution
WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

-- seed RNG
math.randomseed(os.time())

-- Colors
colors = {
    ['white'] = {
        1, 1, 1, 1
    },
    ['black'] = {
        0, 0, 0, 0.5
    },
    ['red'] = {
        1, 0, 0, 1
    },
    ['green'] = {
        0, 1, 0, 1
    },
    ['blue'] = {
        0, 0, 1, 1
    },
    ['yellow'] = {
        1, 1, 0, 1
    }
}
pixeled = 'fonts/font.ttf'

-- makes upscaling look pixel-y instead of blurry
love.graphics.setDefaultFilter('nearest', 'nearest')

-- an object to contain our map data
map = Map(1)
initialScreen  = Map(10)
initialScreen:generatePiramid(0, initialScreen.mapHeight / 2, 8, 'more')

-- performs initialization of all objects and data needed by program
function love.load()

    gameState = 'mainMenu'
    currentMap = initialScreen
    -- sets up a different, better-looking retro font as our default

        -- Messages
        -- sets up virtual screen resolution for an authentic retro feel
    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = true
    })

    love.window.setTitle('Super Mario 50')

    love.keyboard.keysPressed = {}
    love.keyboard.keysReleased = {}

    -- Buttons and covers for the Main Menu
    cover = Block(initialScreen, 0, 0, initialScreen.mapWidthPixels, initialScreen.mapHeightPixels, colors['black'])
    cover.fontSize = 28
    cover.fontY  = cover.height / 6
    buttonPlay = Button(initialScreen, VIRTUAL_WIDTH / 2 - 50, VIRTUAL_HEIGHT / 3, 100, 20, colors['yellow'])
end

-- called whenever window is resized
function love.resize(w, h)
    push:resize(w, h)
end

-- global key pressed function
function love.keyboard.wasPressed(key)
    if (love.keyboard.keysPressed[key]) then
        return true
    else
        return false
    end
end

-- global key released function
function love.keyboard.wasReleased(key)
    if (love.keyboard.keysReleased[key]) then
        return true
    else
        return false
    end
end

-- called whenever a key is pressed
function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    end

    love.keyboard.keysPressed[key] = true
end

-- called whenever a key is released
function love.keyreleased(key)
    love.keyboard.keysReleased[key] = true
end

-- called every frame, with dt passed in as delta in time since last frame
function love.update(dt)
    if gameState == 'play' then
        map:update(dt)
        if map.newLevel and map.player.generateNewLevel then
            local currentLevel = map.level
            map = Map(currentLevel + 1)
        end
    elseif gameState == 'mainMenu' then
        initialScreen:show(dt)
        cover:getCamCoordinates(initialScreen)
        buttonPlay:update()
        if buttonPlay.clicked then
            gameState = 'play'
        end

    end
    -- reset all keys pressed and released this frame
    love.keyboard.keysPressed = {}
    love.keyboard.keysReleased = {}
end

-- called each frame, used to render to the screen
function love.draw()
    -- begin virtual resolution drawing
    push:apply('start')

    -- clear screen using Mario background blue
    love.graphics.clear(108/255, 140/255, 255/255, 255/255)

    -- renders our map object onto the screen
    if gameState == 'play' then
        love.graphics.translate(math.floor(-map.camX + 0.5), math.floor(-map.camY + 0.5))
        map:render()
    elseif gameState == 'mainMenu' then
        love.graphics.translate(math.floor(-initialScreen.camX + 0.5), math.floor(-initialScreen.camY + 0.5))
        initialScreen:render()
        cover:render('SUPER MARIO 50')
        buttonPlay:render('PLAY')
    end

    -- end virtual resolution
    push:apply('end')
end
