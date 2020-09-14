--============================== Animation Class =============================--

Animation = Class{}


function Animation:init(animationsTable, interval)
    self.frames = animationsTable.frames
    self.quads = animationsTable.quads
    self.interval = interval or 0.15

    self.timer = 0
    self.currentFrame = 1

end

function Animation:update(dt)
    if self.timer >= self.interval then
        self.timer = 0
        self.currentFrame = (self.currentFrame + 1) % (#self.frames + 1)
    else
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
