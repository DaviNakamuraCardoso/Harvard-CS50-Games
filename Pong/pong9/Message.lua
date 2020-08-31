--======================= Define a Message Class ============================--

Message = Class()

--======================= Initializing the Class =============================--

function Message:construct(x, y, font, size, align)

--//___________________________ Attributes _________________________________\\--
    self.x = x
    self.y = y
    self.parameter = VIRTUAL_WIDTH
    self.font = love.graphics.newFont(font, self.size)
    self.align = align
    self.isVisible = true
--\\________________________________________________________________________//--
end
--============================================================================--

--============= Print the message in the center of the screen ================--

function Message:show(message)

    --//___________________ Changes the font size  ____________________\\--

    love.graphics.setFont(self.font)
    --\\_______________________________________________________________//--

    --//_____________________ Set the visibility  _____________________\\--
    if self.isVisible then
        love.graphics.setColor(1, 1, 1, 1)
    else
        love.graphics.setColor(1, 1, 1, 0)
    end
    --\\_______________________________________________________________//--

    --//____________________ Print the message ________________________\\--
    love.graphics.printf(message, self.x, self.y, self.parameter, self.align)

    -- Resetting the visibility
    love.graphics.setColor(1, 1, 1, 1)
end
--============================================================================--
