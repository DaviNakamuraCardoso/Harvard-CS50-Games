--========================= Creating a Button Class ==========================--

Button = Class(Block)

--============================================================================--


--=========================== Button init ====================================--
function Button:construct(x, y, width, height, value)
--//______________________________ Attributes ______________________________\\--
    Button.super.construct(self, x, y, width, height)
    self.value = value
    self.text = text
    self.xcorner = 4
    self.ycorner = 4
    self.font_size = self.width * self.height / 230
    self.font_y = self.height / 5
    self.font_family = pixelu
    self.no_hover_color = {
        [0] = 0.6,
        [1] = 0.6,
        [2] = 0.6,
        [3] = 1
    }
    self.hover_color = {
        [0] = self.no_hover_color[0] / 2.2,
        [1] = self.no_hover_color[1] / 2.2,
        [2] = self.no_hover_color[2] / 2.2,
        [3] = 1
    }
    self.color = self.no_hover_color
--\\________________________________________________________________________//--
end
--============================================================================--

--========================= Overwrite the render Method =======================--
function Button:draw(text)
    self:render()
    message = Message(self.x, self.y + self.font_y, self.font_size, 'center')
    message.font = self.font_family
    message.parameter = self.width
    message:show(text)
end
--============================================================================--
function Button:mouse_in_bounds(x, y)
    x = x * VIRTUAL_WIDTH / love.graphics.getWidth()
    y = y * VIRTUAL_HEIGHT / love.graphics.getHeight()
    if x > self.x and x < self.x + self.width and y > self.y and y < self.y + self.height then
        return true
    else
        return false
    end
end
--=========================== Button hover ===================================--
function Button:hover()
    x, y = love.mouse.getPosition()
    local left_click = love.mouse.isDown(1)
    if self:mouse_in_bounds(x, y) then
        if left_click then
            sounds['button']:play()
            return true
        else
            self.color = self.hover_color
            return false
        end
    else
        self.color = self.no_hover_color
        return false
    end
end

--============================================================================--

--================================ Game State Update =========================--
function Button:gameStateUpdate(game)
    if self:hover() then
        game.state = self.value
    end
end
--============================================================================--

--========================= Game Mode Udpate ================================--
function Button:gameModeUpdate(game)
    if self:hover() then
        game.mode = self.value
    end
end
--============================================================================--
