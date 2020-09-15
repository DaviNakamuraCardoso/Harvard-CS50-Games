--============================== Animation Class =============================--

Animation = Class{}


function Animation:init(player, state)
    self.player = player
    self.state = state
    self.table = Characters[self.player.name]['animations'][state]
    self.animationsTable = generateAnimation(player, self.table[1])
    self.frames = self.animationsTable.frames
    self.quads = self.animationsTable.quads
    self.interval = 0.05

    self.timer = 0
    self.currentFrame = 1
    self.ending = false
    self.changing = false
    self.shuffled = true

end

function Animation:update(dt)
    if self.timer >= self.interval then
        if self.currentFrame == #self.frames then
            self.ending = true
        else
            self.ending = false
        end
        self.changing = true
        self.timer = 0
        self.currentFrame = (self.currentFrame + 1) % (#self.frames + 1)
    else
        self.ending = false
        self.changing = false
        self.timer = self.timer + dt
    end
end

function Animation:getCurrentFrame()
    return self.frames[self.currentFrame]
end

function Animation:getCurrentQuad()
    return self.quads[self.currentFrame]
end


function Animation:shuffle()
    if not self.shuffled and self.player.state ~= self.state  and #self.table > 1 then
        self.animationsTable = generateAnimation(self.player, self.table[math.random(#self.table)])
        self.frames = self.animationsTable.frames
        self.quads = self.animationsTable.quads
        self.currentFrame = 0
    elseif self.state == self.player.state then
        self.shuffled = false
    end
end







--============================================================================--
