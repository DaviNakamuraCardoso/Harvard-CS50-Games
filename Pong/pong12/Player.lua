--======================== Creating the Player Class =========================--

Player = Class()

--============================================================================--

--========================== Building the Class ==============================--
function Player:construct(n, side)
    -- body...
--//__________________________ Attributes  _________________________________//--
    self.number = n
    self.side = side
    self.score = 0
    if self.number > 1 then
        self.adversary = 1
    else
        self.adversary = 2
    end
--\\________________________________________________________________________\\--
end
--============================================================================--

--============================== Reset Method ================================--
function Player:reset(ball)
    self.score = self.score + 1
    ball:reset()
    if self.side == 'right' then
        ball.dx = 100
    else
        ball.dx = -100
    end
    if self.score >= MAX_POINTS then
        game_state = 'victory'
        winner = self.number
    else
        game_state = 'serve'
        serving_player.number = self.adversary
    end
end
