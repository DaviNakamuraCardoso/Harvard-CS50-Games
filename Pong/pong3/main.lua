--=================== My version of Pong made in Lua =========================--

-- Defining the window width and height
WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

-- Defining the virtual width and height, that is, the size shown in screen
VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 243

-- Defining the paddle speed
PADDLE_SPEED = 200

-- Importing the push module to set the window size
push = require "push"
--============================================================================--

--========================== Main Function ===================================--
function love.load()
    -- Main function
    love.graphics.setDefaultFilter('nearest', 'nearest')

    -- Fonts
    hello_font = love.graphics.newFont('codie.ttf', 18)
    score_font = love.graphics.newFont('codie.ttf', 32)

    -- Scores
    player_1_score = 0
    player_2_score = 0

    -- Paddles y Position
    player_1_y = 30
    player_2_y = VIRTUAL_HEIGHT - 40

    -- Setup the window size and properties
    push:setupScreen(
    VIRTUAL_WIDTH, -- The width showed in screen
    VIRTUAL_HEIGHT, -- The height showed in screen
    WINDOW_WIDTH, -- The real width
    WINDOW_HEIGHT, -- The real height
    {
        fullscreen = false, -- Not fullscreen
        resizable = false, -- Not resizable
        vsync = true
    })
end
--============================================================================--

--======= Updates the game based on a delta time (dt) since last update ======--
function love.update(dt)
    -- Controls the left paddle movement

    -- Goes up when w key pressed
    if love.keyboard.isDown('w') then
        player_1_y = player_1_y - PADDLE_SPEED * dt
    elseif love.keyboard.isDown('s') then -- Goes down when s key pressed
        player_1_y = player_1_y + PADDLE_SPEED * dt
    end

    -- Controls the right paddle movement
    if love.keyboard.isDown('up') then -- Goes up when up arrow pressed
        player_2_y = player_2_y - PADDLE_SPEED * dt
    elseif love.keyboard.isDown('down') then -- Goes down when down arrow pressed
        player_2_y = player_2_y + PADDLE_SPEED * dt

    end
end
--============================================================================--

--======================= Draw objects on screen ============================--
function love.draw()
    -- Applies the push library
    push:apply('start')

    -- Set the screen color
    love.graphics.clear(40 / 255, 45 / 255, 52 / 255, 1)

    -- Draw the left paddle
    love.graphics.rectangle('fill', 5, player_1_y, 5, 20)

    -- Draw the right paddle
    love.graphics.rectangle('fill', VIRTUAL_WIDTH-10, player_2_y,
    5, 20)

    -- Draw the ball
    love.graphics.rectangle('fill',
    VIRTUAL_WIDTH / 2 - 2,
    VIRTUAL_HEIGHT / 2 - 2,
    4, -- Ball Width
    4) -- Ball Height

    -- Draw hello pong in the screen
    love.graphics.setFont(hello_font)
    love.graphics.printf('Hello Pong!', 0, 20, VIRTUAL_WIDTH,
    'center')

    -- Show the scores
    love.graphics.setFont(score_font)
    love.graphics.print(player_1_score, VIRTUAL_WIDTH / 2 - 50, VIRTUAL_HEIGHT / 3)
    love.graphics.print(player_2_score, VIRTUAL_WIDTH / 2 + 38.5, VIRTUAL_HEIGHT / 3)

    -- Stop applying push
    push:apply('end')
end
--============================================================================--

--==================== Exits when escape is pressed =========================--
function love.keypressed(key)
    -- Detects the keys pressed by the user
    if key == 'escape' then -- If esc pressed, then exit
        love.event.quit()
    end
end
--============================================================================--
