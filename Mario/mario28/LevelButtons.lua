--============================== Level Buttons ===============================--

LevelButtons = Class()

--============================================================================--

function LevelButtons:construct(map, number, y, screenWidth, screenHeight, color)
    self.map = map
    self.number = number
    self.y = y
    self.color = color
    self.buttons = {}
    self.buttonsUnlocked = {}
    local buttonHeight = 2 * (screenHeight - y) / (3 * (self.number + 1)) + 1
    for i=1, self.number do
        local buttonY = self.y + buttonHeight / 2 + ((i - 1) * 1.5 * buttonHeight)
        self.buttons[i] = Button(self.map, screenWidth / 2 - 40, buttonY, 80, buttonHeight, self.color)
    end
end


function LevelButtons:renderAll()
    for i=1, self.number do
        if not self.buttonsUnlocked[i] then
            self.buttons[i].color = colors['red']
            self.buttons[i]:render('LOCKED')
        else
            self.buttons[i]:render(tostring(i))
        end
    end

end


function LevelButtons:updateAll()
    for i=1, self.number do
        self.buttons[i]:update()
        if self.buttonsUnlocked[i] and self.buttons[i].clicked then
            gameState = 'play'
            map = Map(i)
            break
        end

    end
end
