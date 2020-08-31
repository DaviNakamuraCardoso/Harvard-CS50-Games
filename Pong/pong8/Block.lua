--=============== Defining a Superclass for Paddles and Balls ================--

Block = Class()

--============================================================================--

--====================== Constructing (init) the Block class =================--
function Block:construct(x, y, width, height)
    --//__________________________ Size ________________________________//--
    self.x = x
    self.y = y
    self.width = width
    self.height = height
    --\\________________________________________________________________\\--

end
--============================================================================--

--========================== Renders the Block ===============================--
function Block:render()
    love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
end
--============================================================================--
