--============================= The Characters Table =================================--

Characters = {

    ['Athena'] = {
        ['armor'] = 40,
        ['damage'] = 8,
        ['punch_range'] = 50,
        ['kick_range'] = 70,
        ['sex'] = 'female',
        ['shootTrigger'] = 9,
        ['animations'] = {
        --//_______________________ Idle and Dance _________________________\\--

            ['idle'] = {{0, 7}},


        --//__________________________ Movement ____________________________\\--

            ['walking'] = {{8, 19}},
            ['jumping'] = {{30, 35}},
            ['duck'] = {{49, 52}},

        --//__________________________ Damage ______________________________\\--

            -- Punch
            ['punch'] = {{125, 134}},
            ['duck_punch'] = {{145, 147}},
            ['air_punch'] = {{135, 139}},

            -- Kick
            ['kick'] = {{179, 189}},
            ['duck_kick'] = {{193, 204}},
            ['air_kick'] = {{191, 193}},
            ['hurt'] = {{660, 661}},

        --//________________________ End of Game ___________________________\\--


            ['dying'] = {{614, 619}},
            ['waiting'] = {{93, 95}},
            ['winning'] = {{539, 551}},

        --//________________________ Projectiles ____________________________\\--

            ['shoot'] = {{207, 216}},
            ['projectileFly'] = {{217, 222}},
            ['projectileExploded'] = {{223, 234}},
            ['projectileDestroyed'] = {{999, 1000}}
        },
        ['passive'] = function(dt, self)
            if self.health >= 50 then
                self.damage = 12
            else
                self.damage = 8
            end
        end,
        ['shoot'] = function(player)
            Projectile{player = player, type = 'fly', velocity = 400}
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
        ['damage'] = 5,
        ['punch_range'] = 30,
        ['kick_range'] = 90,
        ['sex'] = 'female',
        ['shootTrigger'] = 9,
        ['animations'] = {

        --//_______________________ Idle and Dance _________________________\\--
            ['idle'] = {{0, 15}},

        --//__________________________ Movement ____________________________\\--

            ['walking'] = {{16, 31}},
            ['jumping'] = {{42, 50}},
            ['duck'] = {{51, 59}},

        --//__________________________ Damage ______________________________\\--

            -- Punch
            ['punch'] = {{115, 119}},
            ['duck_punch'] = {{232, 242}},
            ['air_punch'] = {{532, 539}},

            -- Kick
            ['kick'] = {{123, 135}},
            ['duck_kick'] = {{219, 226}},
            ['air_kick']  = {{315, 323}},
            ['hurt'] = {{646, 647}},

        --//________________________ End of Game ___________________________\\--

            ['dying'] = {{602, 607}},
            ['waiting'] = {{625, 628}},
            ['winning'] = {{518, 522}},

        --//________________________ Projectiles ____________________________\\--

            ['shoot'] = {{412, 446}},
            ['projectileExploded'] = {{341, 359}},
            ['projectileDestroyed'] = {{999, 1000}},
            ['projectileSpawn'] = {{391, 400}}
        },
        ['passive'] = function(dt, self)
            if self.health < 20 then
                self.damage = 15
            end
        end,
        ['shoot'] = function(self)
            Projectile{player = self, type = 'spawn', relativeY = -self.height, range = 200, ending = 9, damage = 30}
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
