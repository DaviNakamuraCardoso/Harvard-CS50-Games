--============================== Animation Class =============================--

Animation = Class{}


function Animation:init(player, state)
    self.player = player
    self.state = state
    self.table = Characters[self.player.name]['animations'][state]
    self.animations = {}
    for i=1, #self.table do
        self.animations[i] = generateAnimation(player, self.table[i])
    end
    self.animationsTable = self.animations[math.random(#self.table)]
    self.frames = self.animationsTable.frames
    self.quads = self.animationsTable.quads
    self.interval = 0.075

    self.timer = 0
    self.currentFrame = 1
    self.player.currentFrame = self.frames[1]
    self.ending = false
    self.changing = false
    self.shuffled = true

end

function Animation:update(dt)

    if self.timer >= self.interval then

        self.changing = true
        self.timer = 0
        if self.currentFrame == #self.frames-1 then
            self.ending = true
            self.currentFrame = 0
        else
            self.ending = false
            self.currentFrame = (self.currentFrame + 1) % (#self.frames)
        end
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
        self.animationsTable = self.animations[math.random(#self.animations)]
        self.frames = self.animationsTable.frames
        self.quads = self.animationsTable.quads
        self.currentFrame = 0
        self.shuffled = true
    elseif self.state == self.player.state then
        self.shuffled = false
    end
end







--============================================================================--
