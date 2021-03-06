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
MAX_POINTS = 10

-- References
X_CENTER = VIRTUAL_WIDTH / 2
Y_CENTER = VIRTUAL_HEIGHT / 3


    --//________________________ Imports _______________________________//--

--//                             Libraries                                  \\--

-- Class library from https://github.com/tenry92/class.lua
require("class")

-- Push library from https://github.com/Ulydev/push
push = require "push"

--\\                                                                        //--

--//                            Classes                                     \\--
require 'Game'
require 'Block'
require 'Paddle'
require 'Ball'
require 'Message'
require 'Button'
require 'Player'
require 'RadioButton'

--\\                                                                        //--
    --\\________________________________________________________________//--
--============================================================================--

--========================= Loads Love Framework =============================--
function love.load()

    updates = 0

    -- Colors
    blue = {
        [0] = 0.3,
        [1] = 0.3,
        [2] = 0.6,
        [3] = 1
    }

    -- Create the game object
    game = Game('menu', 'none', MAX_POINTS, 'MEDIUM')

    -- Starts the random number
    math.randomseed(os.time())

    -- Set the filter to nearest, preventing from unexpected blur
    love.graphics.setDefaultFilter('nearest', 'nearest')

    -- Fonts from https://dafont.com
    pixelu = 'pixelu.ttf'
    pixeled = 'pixeled.ttf'
    bitwonder = 'bitwonder.ttf'
    four = 'four.ttf'

    -- Sounds
    sounds = {
        ['paddle_hit'] = love.audio.newSource('paddle_hit.wav', 'static'),
        ['wall_hit'] = love.audio.newSource('wall_hit.wav', 'static'),
        ['reset'] = love.audio.newSource('reset.wav', 'static'),
        ['pause'] = love.audio.newSource('pause.wav', 'static'),
        ['play'] = love.audio.newSource('play.wav', 'static'),
        ['button'] = love.audio.newSource('button.wav', 'static')
    }

    block_smooth = Block(0, 0, VIRTUAL_WIDTH, VIRTUAL_HEIGHT)
    block_smooth.color = {
        [0] = 0,
        [1] = 0,
        [2] = 0,
        [3] = 0.4,
    }
--//___________________________ Buttons ____________________________________\\--
    -- Player vs Player button
    button_pvp = Button(X_CENTER - 150, Y_CENTER, 80, 48, 'player_vs_player')
    button_pvp.font_y = 2
    button_pvp.font_size = 12

    -- Player vs AI button
    button_pva = Button(X_CENTER + 80, Y_CENTER, 80, 48, 'player_vs_ai')
    button_pva.font_y = 2
    button_pva.font_size = 12

    -- Play button
    button_play = Button(X_CENTER - 50, Y_CENTER, 100, 20, 'mode_menu')

    --//______________________ Settings buttons _________________________\\--
    button_settings = Button(X_CENTER - 50, Y_CENTER + 30, 100,
    20, 'settings')
    points = {
        [0] = 3,
        [1] = 5,
        [2] = 10,
        [3] = 15,
    }

    -- Chages the max number of points
    buttons_points = RadioButton(Y_CENTER + 20, 20, points, 4, blue, 'points')
    buttons_points.font_family = bitwonder
    buttons_points:generate()

    -- Changes the AI dificulty
    dificulty = {
        [0] = 'EASY',
        [1] = 'MEDIUM',
        [2] = 'HARD',
    }
    buttons_dificulty = RadioButton(Y_CENTER + 90, 15, dificulty, 3, blue, 'dificulty')
    buttons_dificulty.font_size = 10
    buttons_dificulty.font_family = four
    buttons_dificulty:generate()



    --\\_________________________________________________________________//--
    -- Credit button
    button_credits = Button(X_CENTER - 50, Y_CENTER + 60, 100, 20, 'credits')

    -- Menu button
    button_menu = Button(40, 20, 45, 17, 'menu')
    button_menu.no_hover_color = blue
    button_menu.font_family = four
    button_menu.font_size = 10
    button_menu.font_y = 4

    -- Restart button
    button_restart = Button(X_CENTER - 45, Y_CENTER, 90, 20, 'start')
    button_restart.no_hover_color = blue
    button_restart.font_family = four
    button_restart.font_y = 5.2
    button_restart.font_size = 10
--\\________________________________________________________________________//--
    -- Build the left paddle
    paddle_1 = Paddle(5, 20, 5, 20)

    -- Build the right paddle
    paddle_2 = Paddle(VIRTUAL_WIDTH - 10, VIRTUAL_HEIGHT - 40, 5, 20)

    -- Build the ball (Ball(x, y, width, height))
    ball = Ball(X_CENTER - 2, VIRTUAL_HEIGHT / 2 - 2, 4, 4)

    -- Create message objects Message(x, y, font, size, align)
    title = Message(0, 20, 20, bitwonder)
    subtitle = Message(0, 20, 20, four)
    message_1 = Message(0, 20, 15, four)
    message_2 = Message(0, 50, 8, pixeled)
    score_1 = Message(-50, Y_CENTER, 32, pixelu)
    score_2 = Message(50, Y_CENTER, 32, pixelu)
    fps = Message(30, 20, 18, pixelu)
    fps.align = 'left'
    credits_message = Message(0, VIRTUAL_HEIGHT, 8, pixeled)
    max_points_message = Message(0, Y_CENTER - 10, 10, four)
    dificulty_message = Message(0, Y_CENTER + 60, 10, four)

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
        resizable = true,              -- Resizable
        vsync = true
    })
end
--============================================================================--

--=========================== Resize function ================================--
function love.resize(w, h)
    push:resize(w, h)
end
--============================================================================--

--====== Updates the game based on the delta time (dt) since last update =====--
function love.update(dt)

    if game.state == 'menu' then
        button_play:gameStateUpdate(game)
        button_settings:gameStateUpdate(game)
        button_credits:gameStateUpdate(game)
    elseif game.state ~= 'menu' and game.state ~= 'play' and game.state ~= 'serve' then
        button_menu:gameStateUpdate(game)
    end
    if game.state == 'credits' then
        credits_message:float(dt)
    elseif game.state == 'settings' then
        buttons_points:updateAll(game)
        buttons_dificulty:updateAll(game)
    elseif game.state == 'mode_menu' then
        button_pvp:gameModeUpdate(game)
        button_pva:gameModeUpdate(game)
        if button_pva:hover() or button_pvp:hover() then
            game.state = 'start'
        end
        player_1 = Player("Player 1", -1)
        player_2 = Player("Player 2", 1)
        player_1.adversary = player_2
        player_2.adversary = player_1
        if game.mode == 'player_vs_ai' then
            player_2.name = 'A.I.'
            player_2.isAi = true
        end
    elseif game.state == 'pause' then
        button_restart:gameStateUpdate(game)
    elseif game.state == 'play' then
    --//___________________ Check if the ball is coliding _________________\\
        if ball:collides(paddle_1) then
            -- Deflect ball to the right
            ball.x = paddle_1.x + paddle_1.width + 5
            paddle_1:bounce_ball(ball)
            sounds['paddle_hit']:play()
        end
        if ball:collides(paddle_2) then
            -- Deflect ball to the left
            ball.x = paddle_2.x - 6
            paddle_2:bounce_ball(ball)
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
            updates = 0
            sounds['reset']:play()
        end
    elseif game.state == 'start' then
        -- Reseting the scores
        -- Serving Player
        serving_player = math.random(2) == 1 and player_1 or player_2
        winner = 0
        ball:reset()
        ball.dx = 100 * serving_player.adversary.side
        paddle_1.y = 20
        paddle_2.y = VIRTUAL_HEIGHT - 40
        player_1.score = 0
        player_2.score = 0

    end
    --\\________________________________________________________________//--
    if game.state == 'play' or game.state == 'serve' or game.state == 'start' then


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
        if game.mode == 'player_vs_player' then
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
        else
            if game.state == 'serve' and serving_player.isAi then
                if updates > 90 then
                    game.state = 'play'
                    updates = 0
                else
                    updates = updates + 1
                end
            end

            paddle_2:aiupdate(dt, ball, game.dificulty)
        end

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

    if game.state == 'play' or game.state == 'serve' or game.state == 'play' or game.state == 'pause' or game.state == 'start' or game.state == 'victory' then

        -- Draw the left paddle
        paddle_1:render()

        -- Draw the right paddle
        paddle_2:render()

        -- Draw the ball
        ball:render()

        -- Show the scores
        score_1:show(player_1.score)
        score_2:show(player_2.score)

    elseif game.state ~= 'menu' then
        button_menu:draw('MENU')
    end
    if game.state == 'mode_menu' then
        -- Draw the button
        button_pvp:draw('PLAYER\nvs\nPLAYER')
        button_pva:draw('PLAYER\nvs\nA.I.')

    elseif game.state == 'menu' then
        -- Draw the three initial buttons
        button_play:draw('PLAY GAME')
        button_settings:draw('SETTINGS')
        button_credits:draw('CREDITS')
    end

    --//__________Changes the message based on the game_state___________\\--

    -- If in start state, display Welcome Pong and press enter to play
    if game.state == 'menu' then
        title:show('Pong')
        message_2:show('by Davi Nakamura')

    elseif game.state == 'start' then
        message_1:show('Hello Pong!')
        message_2:show('Press enter to play!')

    -- If in serve state, display the serving_player and "press enter to serve"
    elseif game.state == 'serve' then
        message_1:show(serving_player.name .. "'s turn")
        if not serving_player.isAi then
            message_2:show('Press Enter to serve')
        else
            message_2:show("Get Ready!")
        end

    -- If in victory state, display a message with the winner
    elseif game.state == 'victory' and winner ~= 'none' then
        subtitle:show(winner .. ' wins!')
        message_2:show('Press Enter to play again')

    elseif game.state == 'pause' then
        block_smooth:render()
        message_1:show('Game Paused')
        message_2:show('Press Space to resume')
        button_menu:draw('MENU')
        button_restart:draw('RESTART')

    elseif game.state == 'play' then
        message_2:show('Press Space to Pause')

    elseif game.state == 'mode_menu' then
        message_1:show('Welcome to Pong!')
        message_2:show('Select a Game Mode:')

    elseif game.state == 'credits' then
        credits_message:show("A DAVI NAKAMURA PRODUCTION FOR\nHarvard CS50x\n\nIMPORTED LIBRARIES\nPush, by Ulysse 'Ulydev' on GitHub\nClass, by Tenry 'tenry92' on GitHub\n\nSOUND EFFECTS FROM\nRFXGen\n\nFONTS\n8 Bit Wonder, by Joiro Hatgaya on Dafont\nI Pixel U, by Rodrigo S. T. on Dafont\nPixeled and Four, by 04 on Dafont\n\nTEACHERS\nDavid J. Malan\nColton Ogden\nDoug Lloyd\nBrian Yu\n")
    elseif game.state == 'settings' then
        message_1:show('Settings')
        max_points_message:show('NUMBER OF POINTS')
        dificulty_message:show('A.I. DIFICULTY')
        buttons_points:renderAll()
        buttons_dificulty:renderAll()
    end
    --\\________________________________________________________________//--

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
        if game.state == 'start' then
            game.state = 'serve'
        -- If in victory state, reset
        elseif game.state == 'victory' then
            game.state = 'start'
        -- If the game is in serve state, changes to play
        elseif game.state == 'serve' and not serving_player.isAi then
            game.state = 'play'
        end
    elseif key == 'space' then
        if game.state == 'pause' then
            sounds['play']:play()
            game.state = previous_state
        elseif game.state == 'play' or game.state == 'start' or game.state == 'serve' then
            sounds['pause']:play()
            previous_state = game.state
            game.state = 'pause'
        end

    end
    --\\________________________________________________________________//--
end
--============================================================================--
