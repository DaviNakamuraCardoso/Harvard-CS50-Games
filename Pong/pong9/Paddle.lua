--========================= Defining the Paddle Class ========================--

Paddle = Class(Block)

--========================= Defining Paddle Attributes =======================--
function Paddle:construct(x, y, width, height)

--//_______________________ Position and size ______________________________//--

    --//          Inherits size from the Superclass Block               //--
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
--============================================================================--
