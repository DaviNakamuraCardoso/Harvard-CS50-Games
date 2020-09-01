--============================== Animation Class =============================--

Animation = Class{}


function Animation:init(texture, frames, interval)
    self.texture = texture
    self.frames = frames
    self.interval = interval or 0.15

    self.timer = 0
    self.currentFrame = 1

end

function Animation:update(dt)
    if self.timer > self.interval then
        self.timer = 0
        self.currentFrame = (self.currentFrame + 1) % #self.frames
        if self.currentFrame == 0 then
            self.currentFrame = 1
        end
    else
        self.timer = self.timer + dt
    end
end

function Animation:getCurrentFrame()
    return self.frames[self.currentFrame]
end 










--============================================================================--
