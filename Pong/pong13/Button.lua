--========================= Creating a Button Class ==========================--

Button = Class(Block)

--============================================================================--


--=========================== Button init ====================================--
function Button:construct(x, y, width, height, text, mode)
--//______________________________ Attributes ______________________________\\--
    Button.super.construct(self, x, y, width, height)
    self.text = text
    self.xcorner = 4
    self.ycorner = 4
    self.mode = mode
    self.no_hover_color = {
        [0] = 0.6,
        [1] = 0.6,
        [2] = 0.6,
        [3] = 1
    }
    self.hover_color = {
        [0] = self.no_hover_color[0] / 3,
        [1] = self.no_hover_color[1] / 3,
        [2] = self.no_hover_color[2] / 3,
        [3] = 1
    }
    self.color = self.no_hover_color
--\\________________________________________________________________________//--
end
--============================================================================--

--========================= Overwrite the render Method =======================--
function Button:draw()
    self:render()
    message = Message(self.x, self.y + self.height / 8, self.height / 4, 'center')
    message.parameter = self.width
    message:show(self.text)
end
--============================================================================--

--=========================== Button hover ===================================--
function Button:update()
    mouse_x = love.mouse.getX() * VIRTUAL_WIDTH / WINDOW_WIDTH - 15
    mouse_y = love.mouse.getY() * VIRTUAL_HEIGHT / WINDOW_HEIGHT
    if mouse_x >= self.x and mouse_x <= (self.x + self.width) and mouse_y >= self.y and mouse_y <= (self.y + self.height) then
        if love.mouse.isDown(1) then
            game_mode = self.mode
            game_state = 'start'
        else
            self.color = self.hover_color
        end
    else
        self.color = self.no_hover_color
    end
end
--============================================================================--
