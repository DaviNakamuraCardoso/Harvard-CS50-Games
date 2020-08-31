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

--===================== Move the ball to start position ======================--
function reset_ball()

    -- Ball initial position
    ball_x = VIRTUAL_WIDTH / 2 - 2
    ball_y = VIRTUAL_HEIGHT / 2 - 2

    -- Ball movement
    ball_dx = math.random(2) == 1 and 100 or -100 -- if random = 1, move 100 right, else move 100 left
    ball_dy = math.random(-50, 50) -- Gets random between -50 and 50
end
--============================================================================--

--========================= Loads Love Framework =============================--
function love.load()
    -- Starts the random number
    math.randomseed(os.time())

    -- Set the filter to nearest, preventing from unexpected blur
    love.graphics.setDefaultFilter('nearest', 'nearest')

    -- Fonts
    hello_font = love.graphics.newFont('codie.ttf', 18)
    score_font = love.graphics.newFont('codie.ttf', 32)

    -- Scores
    player_1_score = 0
    player_2_score = 0

    -- Paddles initial y Position
    player_1_y = 30
    player_2_y = VIRTUAL_HEIGHT - 40

    -- Reset the ball position at the start of the game
    reset_ball()

    -- Keeping track of the game state (start or play)
    game_state = 'start'

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


--====== Updates the game based on the delta time (dt) since last update =====--
function love.update(dt)

    --//////////////// Controls the left paddle movement /////////////////--

    -- Goes up when w key pressed
    if love.keyboard.isDown('w') then
        player_1_y = math.max(player_1_y - PADDLE_SPEED * dt, 0)

    -- Goes down when s key pressed
    elseif love.keyboard.isDown('s') then
        player_1_y = math.min(player_1_y + PADDLE_SPEED * dt, VIRTUAL_HEIGHT-20)
    end
    --\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\--

    --/////////////// Controls the right paddle movement /////////////////--

    -- Goes up when up arrow pressed
    if love.keyboard.isDown('up') then
        player_2_y = math.max(player_2_y - PADDLE_SPEED * dt, 0)

    -- Goes down when down arrow pressed
    elseif love.keyboard.isDown('down') then
        player_2_y = math.min(player_2_y + PADDLE_SPEED * dt, VIRTUAL_HEIGHT-20)

    end
    --\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\--

    --///////////// Move the ball when the game is started ///////////////--

    if game_state == 'play' then
        ball_x = ball_x + ball_dx * dt
        ball_y = ball_y + ball_dy * dt
    end
    --\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\--
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
    ball_x,  -- X position
    ball_y, -- Y position
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


--====================== Starts and exits the game ===========================--
function love.keypressed(key)

    -- When escape key pressed, quit the game
    if key == 'escape' then
        love.event.quit()

    -- When space key pressed, start the ball movement
    elseif key == 'enter' or key == 'return' then
        if game_state == 'start' then
            game_state = 'play'
        elseif game_state == 'play' then
            game_state = 'start'
            reset_ball()
        end
    end
end
--============================================================================--
