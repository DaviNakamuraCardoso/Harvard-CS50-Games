--============================== Radio Buttons ===============================--
RadioButton = Class(Button)
--============================================================================--

--============================== Init ===============================--
function RadioButton:construct(y, height, values, number, color, type)
    RadioButton.super.construct(self, 0, y, 0, height, 0)
    self.font_size = 12
    self.active_color = color
    self.buttons = {}
    self.values = values
    self.number = number
    self.type = type

end


function RadioButton:generate()
    screen_width = VIRTUAL_WIDTH
    for i=0,self.number-1 do
        -- body...
        button_width = (screen_width) / (self.number * 2)
        button_x = 12 + button_width / (self.number) + screen_width / 2 + (screen_width / self.number * (i-self.number/2))
        self.buttons[i] = Button(button_x, self.y, button_width, self.height, self.values[i])
        self.buttons[i].font_family = self.font_family
        self.buttons[i].no_hover_color = self.no_hover_color
        self.buttons[i].font_size = self.font_size

    end
end

function RadioButton:renderAll()
    for i=0,self.number-1 do
        -- body...
        self.buttons[i]:draw(tostring(self.values[i]))
    end
end

function RadioButton:updateAll(game)
    for i=0, self.number-1 do
        -- body...
        if self.buttons[i]:hover() then
           if self.type == 'points' then
                game.points = self.buttons[i].value
            elseif self.type == 'dificulty' then
                game.dificulty = self.buttons[i].value
            end
        end
        if self.buttons[i].value == game.points then
            self.buttons[i].color = self.active_color
        elseif self.buttons[i].value == game.dificulty then
            self.buttons[i].color = self.active_color
        end
    end
end















--============================================================================--
