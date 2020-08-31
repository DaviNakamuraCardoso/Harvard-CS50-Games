--===================== Defining the Ball Class ==============================--

Ball = Class(Block)

--============================================================================--

--================== Constructing (init) the Ball Attributes =================--
function Ball:construct(x, y, width, height)
    --//__________________________ Size ________________________________\\--
    -- Inherits it's size from Superclass Block
    Ball.super.construct(self, x, y, width, height)
    --\\________________________________________________________________//--

    --//__________________________ Speed _______________________________\\--
    self.dy = math.random(2) == 1 and 100 or -100
    self.dx = math.random(-50, 50)
    --\\________________________________________________________________//--

end
--============================================================================--

--======================== Updates the ball position =========================--
function Ball:update(dt)
    --//____________ Move the ball when the game is started ____________\\--

    if game.state == 'play' then
        self.x = self.x + self.dx * dt
        self.y = self.y + self.dy * dt
    end
    --\\________________________________________________________________\\--
end
--============================================================================--

--============ Start the ball position to the middle of the screen ===========--
function Ball:reset()
    --//__________ Start the ball at the middle of the screen __________\\--
    self.x = VIRTUAL_WIDTH / 2 - 2
    self.y = VIRTUAL_HEIGHT / 2 - 2
    --\\________________________________________________________________//--

    --//__________ Give ball and x and y random starting value _________\\--
    self.dx = math.random(2) == 1 and 100 or -100
    self.dy = math.random(-50, 50) * 1.5
    --\\________________________________________________________________//--
end
--============================================================================--

--============== Determines if the ball is coliding with a box ===============--
function Ball:collides(box)
    if self.x > box.x + box.width or self.x + self.width < box.x then
        return false
    end
    if self.y > box.y + box.height or self.y + self.height < box.y then
        return false
    end
    return true
end
--============================================================================--
