--============================ Player Class ==================================--

Player = Class{}

require 'Util'
require 'characters'
require 'Lifebar'

function Player:init(map, name, side)
    self.map = map
    local randoms = {'Athena-Asamiya', 'Bonne-Jenet', 'Momoko', 'Magaki', 'Kaede', 'K'}
    self.name = name == '???' and randoms[math.random(#randoms)] or name

    -- Stats
    self.health = 100
    self.armor = Characters[self.name]['armor']
    self.punch_range = Characters[self.name]['punch_range']
    self.kick_range = Characters[self.name]['kick_range']
    self.damage = Characters[self.name]['damage']
    self.sex = Characters[self.name]['sex']

    --//__________________________ Abilities _______________________________\\--

    -- Passive
    self.passive = Characters[self.name]['passive']

    -- Special 1
    self.special_1 = Characters[self.name]['special_1']
    self.cooldown = Characters[self.name]['cooldown']
    self.timer = self.cooldown

    -- Special 2
    self.special_2 = Characters[self.name]['special_2']
    self.specialPoints = 0.1

    -- Shoots
    self.shoot = Characters[self.name]['shoot']



    --//____________________ Position and Side _____________________________\\--

    -- 1 or -1, 1 representing the right side and -1 the left side
    self.side = side
    self.sideParameter = self.side == 1 and 1 or 0
    self.lifebar = Lifebar(self)
    self.lifebar:updateDimensionsAndColors()

    -- Position and dimensions
    self.x = self.map.camX + VIRTUAL_WIDTH / 2 + (VIRTUAL_WIDTH / 2 * self.side)
    self.y = self.map.floor
    self.width = 0
    self.height = 0

    -- x and y var
    self.dx = 0
    self.dy = 0

    -- Offsets for flipping
    self.xOffset = self.width / 2
    self.yOffset = self.height / 2



    --//_________________________ Behaviors ____________________________\\--

    -- Walk and Jump
    self.speed = 200
    self.jumpSpeed = -400
    self.direction = self.side
    self.inAir = false

    -- Projectiles
    self.projectiles = {}
    self.numberOfProjectiles = 0

    -- Enemy
    self.enemy = nil

    -- Controls
    local keyRelations = {
        [-1] = {
            ['forward'] = 'd',
            ['backward'] = 'a',
            ['jump'] = 'w',
            ['run'] = 'space',
            ['duck'] = 's',
            ['punch'] = 'f',
            ['kick'] = 'c',
            ['shoot'] = 'q',
            ['special_1'] = 'e',
            ['special_2'] = 'r',
            ['dancing'] = 'v'

        },
        [1] = {
            ['forward'] = 'l',
            ['backward'] = 'j',
            ['jump'] = 'i',
            ['run'] = 'p',
            ['duck'] = 'k',
            ['punch'] = 'h',
            ['kick'] = 'm',
            ['shoot'] = 'o',
            ['special_1'] = 'u',
            ['special_2'] = 'y',
            ['dancing'] = 'n'
        }
    }

    self.animation = Animation(self, 'idle')

    self.behaviors = {
        ['idle'] = function(dt)
            self.tag = self.specialPoints == 100 and self.ctag or self.ptag
            if love.keyboard.isDown(keyRelations[self.side]['backward']) then
                self.x = math.max(0, math.floor(self.x - self.speed * dt))
                self.state = 'walking'
                self.direction = 1

            elseif love.keyboard.isDown(keyRelations[self.side]['forward']) then
                self.x = math.min(self.map.mapWidth - self.width, math.floor(self.x + self.speed * dt))
                self.state = 'walking'
                self.direction = -1

            elseif love.keyboard.wasPressed[keyRelations[self.side]['punch']] then
                self.state = 'punch'

            elseif love.keyboard.wasPressed[keyRelations[self.side]['kick']] then
                self.state = 'kick'

            elseif love.keyboard.wasPressed[keyRelations[self.side]['jump']] then
                self.dy = self.jumpSpeed
                self.y = self.y - 30
                self.state = 'jumping'
                self.inAir = true

            elseif love.keyboard.wasPressed[keyRelations[self.side]['duck']] then
                self.state = 'duck'

            elseif love.keyboard.wasPressed[keyRelations[self.side]['shoot']] then
                self.state = 'shoot'

            elseif love.keyboard.wasPressed[keyRelations[self.side]['special_1']] and self.timer >= self.cooldown then
                self.state = 'special_1'

            elseif love.keyboard.wasPressed[keyRelations[self.side]['special_2']] and self.specialPoints == 100 and self.enemy.state ~= 'special_1' then
                self.specialPoints = 0.1
                self.state = 'special_2'

            elseif love.keyboard.wasPressed[keyRelations[self.side]['dancing']] then
                self.state = 'dancing'

            end


        end,
        ['start'] = function(dt)
            if self.animation.ending then
                self.state = 'idle'
            end
        end,
        ['dancing'] = function(dt)
            if self.animation.ending then
                self.state = 'idle'
            end
        end,
        ['walking'] = function(dt)
            if love.keyboard.isDown(keyRelations[self.side]['backward']) then
                if love.keyboard.isDown(keyRelations[self.side]['run']) then
                    self.state = 'running'
                end
                self.x = math.max(0, math.floor(self.x - self.speed * dt))
                self.direction = 1
            elseif love.keyboard.isDown(keyRelations[self.side]['forward']) then
                if love.keyboard.isDown(keyRelations[self.side]['run']) then
                    self.state = 'running'
                end
                self.x = math.min(self.map.mapWidth - self.width, math.floor(self.x + self.speed * dt))
                self.direction = -1

            else
                self.state = 'idle'
            end
        end,
        ['running'] = function(dt)
            if love.keyboard.isDown(keyRelations[self.side]['backward']) then
                if love.keyboard.isDown(keyRelations[self.side]['run']) then
                    self.x = math.max(0, math.floor(self.x - 2 * self.speed * dt))
                else
                    self.x = math.max(0, math.floor(self.x - self.speed * dt))
                end
                self.direction = 1
            elseif love.keyboard.isDown(keyRelations[self.side]['forward']) then
                if love.keyboard.isDown(keyRelations[self.side]['run']) then
                    self.x = math.min(self.map.mapWidth - self.width, math.floor(self.x + 2 * self.speed * dt))
                    self.direction = -1
                else
                    self.x = math.min(self.map.mapWidth - self.width, math.floor(self.x + self.speed * dt))
                end
            else
                self.state = 'idle'
            end


        end,
        ['punch'] = function(dt)
            self:detectDamage('front')
            if self.animations['punch'].ending then
                self.animation.currentFrame = 0
                self.state = 'idle'

            end
            if love.keyboard.isDown(keyRelations[self.side]['backward']) then
                self.x = math.max(0, math.floor(self.x - self.speed * dt))
                self.state = 'walking'
                self.direction = 1

            elseif love.keyboard.isDown(keyRelations[self.side]['forward']) then
                self.x = math.min(self.map.mapWidth - self.width, math.floor(self.x + self.speed * dt))
                self.state = 'walking'
                self.direction = -1
            elseif love.keyboard.isDown(keyRelations[self.side]['duck']) then
                self.state = 'duck'
            end
        end,
        ['kick'] = function(dt)
            self:detectDamage('front', self.kick_range)
            if self.animations['kick'].ending then
                self.state = 'idle'
            end

        end,
        ['duck_kick'] = function(dt)
            self:detectDamage('around', self.kick_range)
            if self.animations['duck_kick'].ending then
                self.state = 'duck'
            end
        end,

        ['air_kick'] = function(dt)
            self:detectDamage('down', self.kick_range)
            if self.animations['air_kick'].ending then
                self.state = 'jumping'
            end
        end,
        ['jumping'] = function(dt)
            self.y = math.floor(self.y + self.dy * dt)
            self.dy = self.dy + self.map.gravity * dt
            if self.y >= self.map.floor - self.height then
                self.inAir = false
                self.state = 'idle'
            else
                self.inAir = true
            end

            if love.keyboard.wasPressed[keyRelations[self.side]['punch']] then
                self.state = 'air_punch'

            elseif love.keyboard.wasPressed[keyRelations[self.side]['kick']] then
                self.state = 'air_kick'
            end

        end,
        ['duck'] = function(dt)
            if not love.keyboard.isDown(keyRelations[self.side]['duck']) then
                self.inAir = false
                self.state = 'idle'
                self.y = self.map.floor - self.height
            elseif love.keyboard.wasPressed[keyRelations[self.side]['punch']] then
                self.state = 'duck_punch'

            elseif love.keyboard.wasPressed[keyRelations[self.side]['kick']] then
                self.state = 'duck_kick'

            end
        end,
        ['duck_punch'] = function(dt)
            self.y = self.map.mapHeight - 100
            self:detectDamage('around')
            if self.animations['duck_punch'].ending then
                self.state = 'duck'
            end
        end,
        ['air_punch'] = function(dt)
            self:detectDamage('down')
            self.inAir = true
            if self.animations['air_punch'].ending then
                self.state = 'jumping'
            end
        end,

        ['dying'] = function(dt)
            if self.animation.ending then
                if self.inAir then
                    self.state = 'fall'

                else
                    self.state = 'waiting'
                end
            else
                self.direction = - self.enemy.direction
                self.x = math.min(self.map.mapWidth - self.width, math.max(self.map.camX, math.floor(self.x + self.speed * dt / 2 * self.direction)))

            end
        end,
        ['waiting'] = function(dt)
            self.y = self.map.floor - self.height

        end,
        ['fall'] = function(dt)
            if self.y < self.map.floor - self.height then
                self.y = math.floor(self.y + self.map.gravity/4 * dt)
                self.x = math.floor(self.x + self.enemy.direction * 100 * dt)
            else
                if self.health <= 0 then
                    self.state = 'waiting'
                else
                    self.state = 'idle'
                end
            end
        end,

        ['hurt'] = function(dt)
            if self.animation.ending then
                if self.health <= 0 then
                    self.state = 'dying'
                    self.enemy.state = 'winning'
                    self.map.rounds[self.map.round] = self.enemy
                    self.map.round = self.map.round + 1

                else
                    self:land()
                end
            end
        end,
        ['winning'] = function(dt)
            self.y = self.map.floor - self.height

        end,
        ['shoot'] = function(dt)
            if self.animation.currentFrame == Characters[self.name]['shootTrigger'] and self.animation.timer >= self.animation.interval then
                self:shoot(self)
            elseif self.animation.ending then
                self.animation.currentFrame = 0
                self.state = 'idle'
            end

        end,
        ['special_1'] = function(dt)
            self.special_1(dt, self)
        end,
        ['special_2'] = function(dt)
            self.special_2(dt, self)
        end
    }
    self.passiveUpdated = false

    --//_________________________ Animations ___________________________\\--

    self.animations = {}
    for k, v in pairs(self.behaviors) do
        self.animations[k] = Animation(self, k)
    end
    self.animations['dying'].interval = 0.2



    self.state = 'idle'
    self.animation = self.animations['idle']


    self.currentFrame = self.animation:getCurrentFrame()
    self.currentQuad = self.animation:getCurrentQuad()

    self.p = self.side == -1 and 1 or 2
    self.ptag = love.graphics.newImage('graphics/' .. self.name .. '/p' .. self.p .. '.png')
    self.tag = self.ptag
    self.ctag = love.graphics.newImage('graphics/' .. self.name .. '/com.png')
    self.tagWidth = self.tag:getWidth()
    self.tagHeight = self.tag:getHeight()

    --//_______________________ Sound Effects ______________________________\\--

    -- Sound Directory
    self.soundDir = 'sounds/' .. self.sex .. '/'

    -- Sounds
    self.sounds = {}

    -- Keeps track if the sound was already played
    self.soundPlayed = {}

    -- Loads the sounds for the character
    for k, v in pairs(self.behaviors) do
        self.sounds[k] = love.audio.newSource(self.soundDir .. k .. '.wav', 'static')
    end
    self.shuffle = true
end


function Player:update(dt)

    -- Animation
    self.animation = self.animations[self.state]
    self.currentFrame = self.animation:getCurrentFrame()
    self.currentQuad = self.animation:getCurrentQuad()
    self.animation:update(dt)

    -- Position and dimensions
    self:position(dt)

    -- Behavior and abilities
    self.passive(dt, self)
    self.behaviors[self.state](dt)
    self.timer = self.timer + dt
    self:updateAllProjectiles(dt)


    -- Lifebar
    self.lifebar:update(dt)

    -- Sounds
    self:playSounds()

    self:shuffleAnimations()
end


function Player:render()
    love.graphics.draw(self.currentFrame, self.currentQuad, math.floor(self.x + self.xOffset), math.floor(self.y + self.yOffset), 0, self.direction, 1, self.xOffset, self.yOffset)
    love.graphics.draw(self.tag, love.graphics.newQuad(0, 0, self.tagWidth, self.tagHeight, self.tag:getDimensions()), math.floor(self.x + self.width / 2 - self.tagWidth / 2), self.y - self.tagHeight)

end


function Player:shuffleAnimations()
    if self.shuffle then
        for k, v in pairs(self.animations) do
            self.animations[k]:shuffle()
        end
    end
end

function Player:enemyAt(x, y)
    if self.enemy.y <= y and y <= self.enemy.y + self.enemy.height then
        if self.enemy.x <= x and x <= self.enemy.x + self.enemy.width then
            return true
        else
            return false
        end
    else
        return false
    end
end


--//__________________________ Damage detection ____________________________\\--
function Player:detectDamage(position, range)

    local range = range or self.punch_range
    local positions = {
        ['front'] = {
            ['start'] = 90,
            ['end'] = 270,
            ['direction'] = 1
        },
        ['back'] = {
            ['start'] = -90,
            ['end'] = 270,
            ['direction'] = -1
        },
        ['up'] = {
            ['start'] = 0,
            ['end'] = 180,
            ['direction'] = 1
        },
        ['down'] = {
            ['start'] = 0,
            ['end'] = 180,
            ['direction'] = -1
        },
        ['around'] = {
            ['start'] = 0,
            ['end'] = 360,
            ['direction'] = 1
        }
    }
    local distance = (self.x - self.enemy.x)^2 + (self.y - self.enemy.y)^2

    if self.animation.changing then

        -- checks for enemies in a circle arround the character
        for i=positions[position]['start'], positions[position]['end'] do
            local x = self.x + self.width / 2 + (math.cos(math.rad(i)) * range * positions[position]['direction'] * self.direction)
            local y = self.y + self.height / 2 + (math.sin(math.rad(i)) * range * positions[position]['direction'] * self.direction)
            self:hit(x, y, range)
        end
    end
end

function Player:hit(x, y, range, damage, isProjectile)

    local projectile = isProjectile or false
    local dx = not projectile and self.x - self.enemy.x or self.projectiles[projectile].x - self.enemy.x
    local dy = not projectile and self.y - self.enemy.y or self.projectiles[projectile].y - self.enemy.y
    local damage = damage or self.damage
    if (self:enemyAt(x, y) or range^2 > dx^2 + dy^2) and self.enemy.state ~= 'hurt' and self.enemy.health > 0 then
        self.enemy.state = 'hurt'
        self.enemy.health = self.enemy.health - (damage - damage * self.enemy.armor / 100)
        self.enemy.x = math.min(self.map.mapWidth - self.width - 10, math.max(0, math.floor(self.enemy.x - self.direction * range / 4)))
        self.specialPoints = math.min(self.specialPoints + 5, 100)
        self.enemy.specialPoints = math.min(self.enemy.specialPoints + 10, 100)
        self.enemy.lifebar:updateDimensionsAndColors()
        self.lifebar:updateDimensionsAndColors()


        return true

    end
end


function Player:position(dt)
    self.width = self.currentFrame:getWidth()
    self.height = self.currentFrame:getHeight()
    self.x = math.floor(math.max(self.map.camX, math.min(self.map.camX + VIRTUAL_WIDTH - self.width, self.x)))
    if not self.inAir then
        self.y = self.map.floor - self.height
    end
    -- Offsets
    self.xOffset = self.currentFrame:getWidth() / 2
    self.yOffset = self.currentFrame:getHeight() / 2
end


function Player:land()
    if self.y < self.map.floor - self.height then
        self.state = 'jumping'
    else
        self.y = self.map.floor - self.height
        self.dy = 0
        self.inAir = false
        self.state = 'idle'
    end
end


function Player:updateAllProjectiles(dt)
    -- Projectiles
    if self.numberOfProjectiles > 0 then
        for i=1, self.numberOfProjectiles do
            self.projectiles[i]:update(dt)
        end
    end
end


function Player:renderAllProjectiles(dt)
    -- Projectiles
    if self.numberOfProjectiles > 0 then
        for i=1, self.numberOfProjectiles do
            self.projectiles[i]:render()
        end
    end
end
--\\________________________________________________________________________//--



function Player:playSounds()
    if self.animation.currentFrame == 1 then
        if not self.soundPlayed[self.state] then
            if self.sounds[self.state] then
                self.sounds[self.state]:play()
            end
            self.soundPlayed[self.state] = true
        end
    end
    for k, v in pairs(self.behaviors) do
        if k ~= self.state then
            self.soundPlayed[k] = false
        end
    end
end
