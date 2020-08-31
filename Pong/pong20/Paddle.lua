--========================= Defining the Paddle Class ========================--

Paddle = Class(Block)

--========================= Defining Paddle Attributes =======================--
function Paddle:construct(x, y, width, height)

--//_______________________ Position and size ______________________________//--

    --//        Inherits Attributes from the Superclass Block               //--
    Paddle.super.construct(self, x, y, width, height)

--\\________________________________________________________________________\\--

--//_____________________________ Speed ____________________________________//--

    self.dy = 0

--\\________________________________________________________________________\\--
end
--============================================================================--

--===== Updates the paddle position based on the time since last update ======--
function Paddle:update(dt)

    --//_________ Updates the paddle y to a value greater than 0 _______//--
    if self.dy < 0 then
        self.y = math.max(0, self.y + self.dy * dt)
    --\\________________________________________________________________\\--

    --//_ Updates the paddle x to a value lower than the screen height _//--
    elseif self.dy > 0 then
        self.y = math.min(VIRTUAL_HEIGHT - 20, self.y + self.dy * dt)
    --\\_________________________________________________________________\\--
    end
end
--============================ Returns the ball ==============================--
function Paddle:bounce_ball(ball)
    if ball.dx < 0 then
        if self.dy < 0 then
            ball.dx = - math.max(ball.dx + self.dy/4, -300)
        elseif self.dy > 0 then
            ball.dx = - math.min(ball.dx + self.dy/4, -70)
        else
            ball.dx = -ball.dx
        end
    elseif ball.dx > 0 then
        if self.dy < 0 then
            ball.dx = -math.max(ball.dx - self.dy/4, -300)
        elseif self.dy > 0 then
            ball.dx = -math.max(ball.dx - self.dy/4, 70)
        else
            ball.dx = -ball.dx
        end
    end
end


--============================================================================--
function Paddle:aiupdate(dt, ball, dificulty)
    dificulties = {
        ['EASY'] = 5,
        ['MEDIUM'] = 2,
        ['HARD'] = 1
    }
    if ball.x > VIRTUAL_WIDTH / 2 and ball.dx > 0 then
        move = math.random(2*dificulties[dificulty]) == 1 and true or false
        if move then
            if ball.y < self.y then
                self.dy = -PADDLE_SPEED
            elseif ball.y > self.y + self.height then
                self.dy = PADDLE_SPEED
            else
                self.dy = 0
            end
        end
    else
        self.dy = 0
    end
    self:update(dt)
end
