--=================== My version of Pong made in Lua =========================--

-- Defining the window width and height
WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

-- Defining the virtual width and height, that is, the size shown in screen
VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 243

-- Defining the paddle speed
PADDLE_SPEED = 200

-- Defining the MAX_POINTS
MAX_POINTS = 3

    --//________________________ Imports _______________________________//--

--//                             Libraries                                  \\--

-- Class library from https://github.com/tenry92/class.lua
require("class")

-- Push library from https://github.com/Ulydev/push
push = require "push"

--\\                                                                        //--

--//                            Classes                                     \\--
require 'Block'
require 'Paddle'
require 'Ball'
require 'Message'
require 'Player'
--\\                                                                        //--
    --\\________________________________________________________________//--
--============================================================================--

--========================= Loads Love Framework =============================--
function love.load()

    -- Starts the random number
    math.randomseed(os.time())

    -- Set the filter to nearest, preventing from unexpected blur
    love.graphics.setDefaultFilter('nearest', 'nearest')

    -- Font
    font = 'codie.ttf'

    -- Sounds
    sounds = {
        ['paddle_hit'] = love.audio.newSource('paddle_hit.wav', 'static'),
        ['wall_hit'] = love.audio.newSource('wall_hit.wav', 'static'),
        ['reset'] = love.audio.newSource('reset.wav', 'static')
    }

    -- Build the left paddle
    paddle_1 = Paddle(5, 20, 5, 20)

    -- Build the right paddle
    paddle_2 = Paddle(VIRTUAL_WIDTH - 10, VIRTUAL_HEIGHT - 40, 5, 20)

    -- Build the ball (Ball(x, y, width, height))
    ball = Ball(VIRTUAL_WIDTH / 2 - 2, VIRTUAL_HEIGHT / 2 - 2, 4, 4)

    -- Creating the players
    player_1 = Player(1, 'left')
    player_2 = Player(2, 'right')
    winner = 0

    -- Serving Player
    serving_player = math.random(2) == 1 and player_1 or player_2
    serving_player:reset(ball)


    -- Keeping track of the game state (start or play)
    game_state = 'start'

    -- Create message objects Message(x, y, font, size, align)
    message_1 = Message(0, 20, font, 12, 'center')
    message_2 = Message(0, 40, font, 12, 'center')
    score_1 = Message(-50, VIRTUAL_HEIGHT / 3, font, 32, 'center' )
    score_2 = Message(50, VIRTUAL_HEIGHT / 3, font, 32, 'center' )
    fps = Message(30, 20, font, 26, 'left')

    -- Setup the window size and properties
    -- Window title
    love.window.setTitle('Pong')
    -- Window size
    push:setupScreen(
    VIRTUAL_WIDTH,                      -- The width showed in screen
    VIRTUAL_HEIGHT,                     -- The height showed in screen
    WINDOW_WIDTH,                       -- The real width
    WINDOW_HEIGHT,                      -- The real height
    {
        fullscreen = false,             -- Not fullscreen
        resizable = false,              -- Not resizable
        vsync = true
    })
end
--============================================================================--

--====== Updates the game based on the delta time (dt) since last update =====--
function love.update(dt)

    if game_state == 'play' then

    --//___________________ Check if the ball is coliding _________________\\
        if ball:collides(paddle_1) then
            -- Deflect ball to the right
            ball.dx = -ball.dx
            sounds['paddle_hit']:play()
        end
        if ball:collides(paddle_2) then
            -- Deflect ball to the left
            ball.dx = -ball.dx
            sounds['paddle_hit']:play()
        end

        -- Bounce if in bottom edge
        if ball.y <= 0 then
            ball.dy = -ball.dy
            ball.y = 0
            sounds['wall_hit']:play()
        end
        -- Bounce if in top edge
        if ball.y >= VIRTUAL_HEIGHT - 4 then
            ball.dy = -ball.dy
            ball.y = VIRTUAL_HEIGHT - 4
            sounds['wall_hit']:play()
        end
        -- Reset the game when touching the left edge
        if ball.x <= 0 then
            player_2:reset(ball)
            sounds['reset']:play()
        end
        -- Reset the game when touching in the right edge
        if ball.x >= VIRTUAL_WIDTH - 4 then
            player_1:reset(ball)
            sounds['reset']:play()
        end
    elseif game_state == 'start' then
        -- Reseting the scores
        player_1.score = 0
        player_2.score = 0
        winner = 0

    end

    --\\________________________________________________________________//--
    if game_state ~= 'pause' then

        --//______________ Controls the left paddle movement _______________\\--

        -- Goes up when w key pressed
        if love.keyboard.isDown('w') then
            paddle_1.dy = - PADDLE_SPEED

            -- Goes down when s key pressed
        elseif love.keyboard.isDown('s') then
            paddle_1.dy = PADDLE_SPEED

            -- Stops when no key pressed
        else
            paddle_1.dy = 0
        end

        paddle_1:update(dt)
        --\\________________________________________________________________//--

        --//______________ Controls the right paddle movement ______________\\--

        -- Goes up when up arrow pressed
        if love.keyboard.isDown('up') then
            paddle_2.dy = - PADDLE_SPEED

            -- Goes down when down arrow pressed
        elseif love.keyboard.isDown('down') then
            paddle_2.dy = PADDLE_SPEED

            -- Stops when no key pressed
        else
            paddle_2.dy = 0

        end

        paddle_2:update(dt)

        --\\________________________________________________________________//--

        --//___ Updating the ball position based on the game_state value ___\\--

        ball:update(dt)

        --\\________________________________________________________________//--
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
    paddle_1:render()

    -- Draw the right paddle
    paddle_2:render()

    -- Draw the ball
    ball:render()


    --//__________Changes the message based on the game_state___________\\--

    -- If in start state, display Welcome Pong and press enter to play
    if game_state == 'start' then
        message_1:show('Welcome to pong')
        message_2:show('Press Enter to Play')

    -- If in serve state, display the serving_player and "press enter to serve"
    elseif game_state == 'serve' then
        message_1:show("Player " .. tostring(serving_player.number) .. "'s turn")
        message_2:show('Press Enter to serve')

    -- If in victory state, display a message with the winner
    elseif game_state == 'victory' and winner > 0 then
        message_1.size = 24
        message_1:show('Player ' .. tostring(winner) .. ' is the winner')
        message_2:show('Press Enter to play again')
        message_1.size = 12
    elseif game_state == 'pause' then
        message_1:show('Game Paused')
        message_2:show('Press Space to resume')
    else
        message_1:show('Press Space to Pause')


    end
    --\\________________________________________________________________//--

    -- Show the scores
    score_1:show(player_1.score)
    score_2:show(player_2.score)

    -- Stop applying push
    push:apply('end')

    -- Calls display_fps
    love.graphics.setColor(0, 1, 0, 1)
    fps:show('FPS: ' .. tostring(love.timer.getFPS()))
    love.graphics.setColor(1, 1, 1, 1)
end
--============================================================================--

--====================== Starts and exits the game ===========================--
function love.keypressed(key)

    --//___________ When escape key pressed, quit the game _____________\\--
    if key == 'escape' then
        love.event.quit()

    --//_______ When enter key pressed, start the ball movement ________\\--
    elseif key == 'enter' or key == 'return' then
        -- If the game ball is stoped (start state), changes to serve
        if game_state == 'start' then
            game_state = 'serve'
        -- If in victory state, reset
        elseif game_state == 'victory' then
            game_state = 'start'
        -- If the game is in serve state, changes to play
        elseif game_state == 'serve' then
            game_state = 'play'
        end
    elseif key == 'space' then
        if game_state == 'play' then
            game_state = 'pause'
        elseif game_state == 'pause' then
            game_state = 'play'
        end

    end
    --\\________________________________________________________________//--
end
--============================================================================--
