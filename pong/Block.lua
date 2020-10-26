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
    self.color = {
        [0] = 1,
        [1] = 1,
        [2] = 1,
        [3] = 1}
    self.xcorner = 0
    self.ycorner = 0
    self.isVisible = true
    --\\________________________________________________________________\\--

end
--============================================================================--

--========================== Renders the Block ===============================--
function Block:render()
    if self.isVisible then
        love.graphics.setColor(self.color[0], self.color[1], self.color[2], self.color[3])
    else
        love.graphics.setColor(self.color[0], self.color[1], self.color[2], 0)
    end
    love.graphics.rectangle('fill', self.x, self.y, self.width, self.height, self.xcorner, self.ycorner)
    love.graphics.setColor(1, 1, 1, 1)
end
--============================================================================--
