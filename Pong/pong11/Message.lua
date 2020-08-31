--======================= Define a Message Class ============================--

Message = Class()

--======================= Initializing the Class =============================--

function Message:construct(x, y, font, size, align)

--//___________________________ Attributes _________________________________\\--
    self.x = x
    self.y = y
    self.parameter = VIRTUAL_WIDTH
    self.size = size
    self.font = font
    self.align = align
--\\________________________________________________________________________//--
end
--============================================================================--

--============= Print the message in the center of the screen ================--

function Message:show(message)

    --//___________________ Changes the font size  ____________________\\--
    current_font = love.graphics.getFont()
    message_font = love.graphics.newFont(self.font, self.size)
    love.graphics.setFont(message_font)
    --\\_______________________________________________________________//--

    --//____________________ Print the message ________________________\\--
    love.graphics.printf(message, self.x, self.y, self.parameter, self.align)
    love.graphics.setFont(current_font)

end
--============================================================================--
