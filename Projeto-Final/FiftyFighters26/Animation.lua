--============================== Animation Class =============================--

Animation = Class{}


function Animation:init(player, state)
    animationsTable = generateAnimation(player, state)
    self.frames = animationsTable.frames
    self.quads = animationsTable.quads
    self.interval = 0.05

    self.timer = 0
    self.currentFrame = 1
    self.ending = false
    self.changing = false

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










--============================================================================--
