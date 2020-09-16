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

        --//_________________________ Specials _____________________________\\--

            ['special_1'] = {{309, 322}},
            ['special_2'] = {{405, 466}},

        --//________________________ Projectiles ____________________________\\--

            ['shoot'] = {{207, 216}},
            ['projectile_1_fly'] = {{217, 222}},
            ['projectile_1_exploded'] = {{223, 234}},
            ['projectile_1_destroyed'] = {{999, 1000}},

            ['projectile_2_fly'] = {{501, 507}},
            ['projectile_2_exploded'] = {{508, 525}},
            ['projectile_2_destroyed'] = {{999, 1000}}
        },
        ['passive'] = function(dt, self)
            if self.health >= 50 then
                self.damage = 12
            else
                self.damage = 8
            end
        end,
        ['shoot'] = function(player)
            Projectile{player = player, type = 'fly', number = 1, velocity = 400}
        end,

        ['special_1'] = function(dt, self)
            self.x = math.floor(self.x - 2 * self.speed * self.direction * dt)
            self:detectDamage('around')
            if self.animation.ending then
                self.state = 'jumping'

            end
        end,
        ['special_2']  = function(dt, self)
            self.inAir = true
            if self.animation.currentFrame <= 7 then
                self.y = math.floor(self.y - 270 * dt)
            elseif self.animation.currentFrame > 7 and self.animation.currentFrame <= 47 then
                if self.animation.currentFrame == 22 and self.animation.changing then
                    for i=0, 360, 12 do
                        Projectile{
                            player = self,
                            type = 'fly',
                            number = 2,
                            velocity = 100,
                            incline = i
                        }
                    end
                end
            elseif self.animation.currentFrame > 47 and self.animation.currentFrame < 60 then

                self:detectDamage('front')
                self.x = math.floor(self.x + 3 * self.speed * dt)
                self.y = math.floor(self.y + 1 * self.speed * dt)
            else
                self.dy = 0
                self.state = 'jumping'
            end
        end,


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
            ['air_punch'] = {{315, 323}},

            -- Kick
            ['kick'] = {{123, 135}},
            ['duck_kick'] = {{219, 226}},
            ['air_kick']  = {{532, 539}},
            ['hurt'] = {{646, 647}},

        --//________________________ End of Game ___________________________\\--

            ['dying'] = {{602, 607}},
            ['waiting'] = {{625, 628}},
            ['winning'] = {{518, 522}},

        --//_________________________ Specials _____________________________\\--

            ['special_1'] = {{376, 390}},
            ['special_2'] = {{333, 334}},

        --//________________________ Projectiles ____________________________\\--

            ['shoot'] = {{412, 446}},
            ['projectile_1_exploded'] = {{341, 359}},
            ['projectile_1_destroyed'] = {{999, 1000}},
            ['projectile_1_spawn'] = {{391, 400}},

            ['projectile_2_exploded'] = {{448, 469}},
            ['projectile_2_destroyed'] = {{999, 1000}},
            ['projectile_2_fly'] = {{366, 372}}

        },
        ['passive'] = function(dt, self)
            if self.health < 20 then
                self.damage = 15
            end
        end,
        ['shoot'] = function(self)
            Projectile{player = self, type = 'spawn', number = 1, relativeY = -self.height, range = 200, ending = 9, damage = 30}
        end,

        ['special_1'] = function(dt, self)
            if self.animation.currentFrame == #self.animation.frames and self.animation.timer >= self.animation.interval then
                Projectile{
                    player = self,
                    type = 'fly',
                    number = 2,
                    velocity = 200,
                    damage = 20,
                    relativeX = -self.width
                }
                self.state = 'idle'
            end
        end,
        ['special_2'] = function(dt, self)

        end,
        ['cooldown'] = 2

    }





}
