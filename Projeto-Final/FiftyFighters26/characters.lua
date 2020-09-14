--======================= The Characters Table ===============================--

Characters = {

    ['Athena'] = {
        ['armor'] = 90,
        ['damage'] = 15,
        ['range'] = 60,
        ['animations'] = {
            ['idle'] = {0, 7},
            ['walking'] = {8, 19},
            ['jumping'] = {30, 35},
            ['attacking'] = {125, 134},
            ['duck'] = {250, 252},
            ['dying'] = {614, 619},
            ['waiting'] = {93, 95},
            ['hurt'] = {660, 661},
            ['winning'] = {484, 498}
        },
        ['passive'] = function(dt, self)
            if self.state == 'jumping' then
                self:detectDamage('around', 70)
            end
        end,
--        ['special'] = function(dt, self)
--            self.x = math.floor(self.x - 2 * self.speed * self.direction * dt)
--            self:detectDamage('around')
--            if self.animation.currentFrame == #self.animation.frames and --self.animation.timer >= self.animation.interval then
--                self.state = 'idle'
--
--            end
--        end,
        ['cooldown'] = 5

    },
    ['Bonne'] = {
        ['armor'] = 30,
        ['damage'] = 20,
        ['range'] = 30,
        ['animations'] = {
            ['idle'] = {0, 15},
            ['walking'] = {16, 31},
            ['jumping'] = {42, 50},
            ['attacking'] = {115, 119},
            ['duck'] = {51, 59},
            ['dying'] = {602, 607},
            ['waiting'] = {625, 628},
            ['hurt'] = {646, 647},
            ['winning'] = {518, 522}
        },
        ['passive'] = function(dt, self)
            if self.health < 20 then
                self.damage = 40
            end
        end,
--        ['special'] = function(dt, self)
--            if self.animation.currentFrame == #self.animation.frames and --self.animation.timer >= self.animation.interval then
--                Projectile(self, 200, 35, 0, -self.height / 4)
--                self.state = 'idle'
--            end
--        end,
        ['cooldown'] = 2

    }





}
