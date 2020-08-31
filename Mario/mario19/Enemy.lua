--============================= The enemies Class ============================--

Enemy = Class()


ENEMY_SPEED = 35
--============================================================================--

function Enemy:init(map, spritesheet, x)
    self.map = map
    self.texture = love.graphics.newImage(spritesheet)
    self.width = 16
    self.height = 20

    -- Positions
    self.x = x
    self.y = map.tileHeight * ((map.mapHeight - 2) / 2) - self.height


    self.dy = 0
    self.dy = 0
    self.speed = ENEMY_SPEED * (1 + (self.map.level / 10))

    self.touchingEdge = false
    self.direction = 1



    self.xOffset = 8
    self.yOffset = 10

    self.behaviors = {
        ['walking'] = function(dt)
            if self.map:collides(self.map:tileAt(self.x + self.width, self.y)) or (self.map:tileAt(self.x + self.width, self.y + self.height)).id == TILE_EMPTY then
                self.x = self.x - 5
                self.direction = -self.direction

            elseif self.map:collides(self.map:tileAt(self.x - 1, self.y)) or (self.map:tileAt(self.x - 1, self.y + self.height)).id == TILE_EMPTY then
                self.x = self.x + 5
                self.direction = -self.direction
            end
            if self.direction < 0 then
                self.dx = math.floor(self.speed * self.direction * dt)
                self.x = math.floor(self.x + self.dx)
            else
                self.dx = math.ceil(self.speed * self.direction * dt)
                self.x = math.ceil(self.x + self.dx)
            end


        end,
        ['dying'] = function(dt)
            if self.y < self.map.mapHeightPixels - self.height then
                self.dx = self.dx / 2
                self.dy = math.ceil(self.map.gravity * 4 * dt)
                self.y = math.ceil(self.y + self.dy)
            else
                self.dy = 0
                self.dx = 0
            end
        end

    }

    self.animations  = {
        ['walking'] = Animation({
            texture = self.texture,
            frames = {
                love.graphics.newQuad(128, 0, 16, 20, self.texture:getDimensions()),
                love.graphics.newQuad(144, 0, 16, 20, self.texture:getDimensions()),
                love.graphics.newQuad(160, 0, 16, 20, self.texture:getDimensions()),
                love.graphics.newQuad(176, 0, 16, 20, self.texture:getDimensions()),
            },
            interval = 0.10  
        }),
        ['dying'] = Animation({
            texture = self.texture,
            frames = {
                love.graphics.newQuad(64, 0, 16, 20, self.texture:getDimensions())
            }
        })
    }

    self.state = 'walking'
    self.animation = self.animations['walking']
    self.currentFrame = self.animation:getCurrentFrame()

end


function Enemy:update(dt)
    self.behaviors[self.state](dt)
    self.animations[self.state]:update(dt)
    self.currentFrame = self.animation:getCurrentFrame()
end


--============================================================================--
function Enemy:render()
    love.graphics.draw(self.texture, self.currentFrame, math.floor(self.x + self.xOffset), math.floor(self.y + self.yOffset), 0, self.direction, 1,
    self.xOffset, self.yOffset)
end





--============================================================================--
