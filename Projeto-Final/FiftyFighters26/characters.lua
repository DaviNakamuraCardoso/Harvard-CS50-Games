--============================= The Characters Table =================================--

Characters = {

    ['Athena'] = {
        ['armor'] = 40,
        ['damage'] = 8,
        ['punch_range'] = 50,
        ['kick_range'] = 70,
        ['sex'] = 'female',
        ['shootTrigger'] = 8,
        ['animations'] = {
        --//_______________________ Idle and Dance _________________________\\--

            ['idle'] = {{0, 7}},


        --//__________________________ Movement ____________________________\\--

            ['walking'] = {{8, 19}},
            ['running'] = {{69, 75}},
            ['jumping'] = {{30, 35}},
            ['duck'] = {{49, 52}, {554, 555}},

        --//__________________________ Damage ______________________________\\--

            -- Punch
            ['punch'] = {{125, 134}},
            ['duck_punch'] = {{145, 147}},
            ['air_punch'] = {{135, 139}},

            -- Kick
            ['kick'] = {{179, 189}},
            ['duck_kick'] = {{193, 204}},
            ['air_kick'] = {{191, 193}},

            -- Hurt
            ['fall'] = {{624, 630}},
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
            dash(dt, self)
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
                            velocity = 200,
                            incline = i,
                            size = 10
                        }
                    end
                end
            elseif self.animation.currentFrame > 47 and self.animation.currentFrame < 60 then
                self:detectDamage('front')
                self.x = math.floor(self.x + 3 * self.speed * dt * -self.direction)
                self.y = math.floor(self.y + 1 * self.speed * dt)
            else
                self.numberOfProjectiles = 0
                self.projectiles = {}
                self.dy = 0
                self.animation.currentFrame = 0
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
        ['shootTrigger'] = 14,
        ['animations'] = {

        --//_______________________ Idle and Dance _________________________\\--
            ['idle'] = {{0, 15}},

        --//__________________________ Movement ____________________________\\--

            ['walking'] = {{16, 31}},
            ['running'] = {{69, 78}}, 
            ['jumping'] = {{42, 50}},
            ['duck'] = {{51, 59}},

        --//__________________________ Damage ______________________________\\--

            -- Punch
            ['punch'] = {{115, 119}},
            ['duck_punch'] = {{232, 242}, {190, 197}},
            ['air_punch'] = {{315, 323}},

            -- Kick
            ['kick'] = {{123, 135}},
            ['duck_kick'] = {{219, 226}},
            ['air_kick']  = {{532, 539}, {213, 217}},

            -- Hurt
            ['hurt'] = {{646, 647}},
            ['fall'] = {{602, 607}},

        --//________________________ End of Game ___________________________\\--

            ['dying'] = {{602, 607}},
            ['waiting'] = {{625, 628}},
            ['winning'] = {{561, 563}, {518, 522}},

        --//_________________________ Specials _____________________________\\--

            ['special_1'] = {{360, 376}},
            ['special_2'] = {{412, 446}},

        --//________________________ Projectiles ____________________________\\--

            ['shoot'] = {{376, 391}},
            ['projectile_1_exploded'] = {{341, 359}},
            ['projectile_1_destroyed'] = {{999, 1000}},
            ['projectile_1_fly'] = {{244, 255}},

            ['projectile_2_exploded'] = {{448, 469}},
            ['projectile_2_destroyed'] = {{999, 1000}},
            ['projectile_2_spawn'] = {{391, 398}}

        },
        ['passive'] = function(dt, self)
            if self.health < 20 then
                self.damage = 15
            end
        end,
        ['shoot'] = function(self)
            Projectile{player = self, type = 'fly', number = 1, relativeX = -self.width-20, velocity = 200, damage = 30}
        end,

        ['special_1'] = function(dt, self)
            dash(dt, self, 200, 6, 12)
        end,
        ['special_2'] = function(dt, self)
            if (self.animation.currentFrame >= 7 and self.animation.currentFrame <= 19) and self.animation.changing then
                Projectile{
                    player = self,
                    type = 'spawn',
                    number = 2,
                    range = (self.animation.currentFrame - 7) * 30,
                    damage = 10
                }
                self:detectDamage('front')
            elseif self.animation.ending then
                self.state = 'idle'
            end


        end,
        ['cooldown'] = 2

    }





}


function dash(dt, self, speed, startAnimation, finalAnimation)
    local speed = speed or self.speed
    local startAnimation = startAnimation or 0
    local finalAnimation = finalAnimation or #self.animation.frames
    if self.animation.currentFrame >= startAnimation and self.animation.currentFrame< finalAnimation then
        self.x = math.floor(self.x - 2 * speed * self.direction * dt)
    end
    self:detectDamage('around')
    if self.animation.ending then
        self.state = 'jumping'
    end
end
