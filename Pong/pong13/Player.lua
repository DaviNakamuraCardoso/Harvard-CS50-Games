--======================== Creating the Player Class =========================--

Player = Class()

--============================================================================--

--========================== Building the Class ==============================--
function Player:construct(name, side)
    -- body...
--//__________________________ Attributes  _________________________________//--
    self.side = side
    self.name = name
    self.score = 0
    self.adversary = 0
    self.isAi = false
--\\________________________________________________________________________\\--
end
--============================================================================--

--============================== Reset Method ================================--
function Player:reset(ball)
    self.score = self.score + 1
    ball:reset()
    serving_player = self.adversary
    ball.dx = 100 * self.side
    if self.score >= MAX_POINTS then
        game_state = 'victory'
        winner = self.name
    else
        game_state = 'serve'
    end
end
