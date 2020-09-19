--============================= The Characters Table =================================--

Characters = {

    ['Athena'] = {

        --//________________________ Attributtes ___________________________\\--

        ['armor'] = 40,
        ['damage'] = 8,
        ['punch_range'] = 50,
        ['kick_range'] = 70,
        ['sex'] = 'female',
        ['shootTrigger'] = 8,

        ['animations'] = {
        --//_______________________ Idle and Dance _________________________\\--

            ['idle'] = {{0, 7}},
            ['dancing'] = {{595, 601}, {578, 586}, {561, 572}, {586, 591}},

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
                    self.y = self.map.floor - 150 - self.height
                    for i=0, 360, 30 do
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
                self.x = math.floor(self.x + 2 * self.speed * dt * -self.direction)
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
            ['dancing'] = {{574, 582}, {518, 522}, {564, 569}, {570, 573}, {583, 589}},

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
            ['winning'] = {{561, 563}},

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
            if (self.animation.currentFrame >= 7 and self.animation.currentFrame <= 18) and self.animation.changing and self.animation.currentFrame % 2 == 0 then
                Projectile{
                    player = self,
                    type = 'spawn',
                    number = 2,
                    range = (self.animation.currentFrame - 7) * 30,
                    damage = 10
                }
                self:detectDamage('front')
            elseif self.animation.ending then
                self.animation.currentFrame = 0
                self.state = 'idle'
            end


        end,
        ['cooldown'] = 2

    },
    ['Adam'] = {

        --//________________________ Attributtes ___________________________\\--

        ['armor'] = 60,
        ['damage'] = 7,
        ['punch_range'] = 40,
        ['kick_range'] = 60,
        ['sex'] = 'male',
        ['shootTrigger'] = 5,

        ['animations'] = {
        --//_______________________ Idle and Dance _________________________\\--

            ['idle'] = {{0, 4}},
            ['dancing'] = {{87, 91}},

        --//__________________________ Movement ____________________________\\--

            ['walking'] = {{5, 13}},
            ['running'] = {{46, 56}},
            ['jumping'] = {{16, 33}},
            ['duck'] = {{62, 64}},

        --//__________________________ Damage ______________________________\\--

            -- Punch
            ['punch'] = {{69, 73}, {122, 127}, {211, 215}},
            ['duck_punch'] = {{101, 104}},
            ['air_punch'] = {{99, 100}},

            -- Kick
            ['kick'] = {{74, 83}, {105, 114}, {127, 134}, {139, 143}, {155, 164}},
            ['duck_kick'] = {{118, 121}, {166, 170}},
            ['air_kick'] = {{115, 117}},

            -- Hurt
            ['fall'] = {{523, 528}},
            ['hurt'] = {{559, 560}},

        --//________________________ End of Game ___________________________\\--


            ['dying'] = {{534, 538}},
            ['waiting'] = {{550, 552}},
            ['winning'] = {{553, 556}},

        --//_________________________ Specials _____________________________\\--

            ['special_1'] = {{218, 221}},
            ['special_2'] = {{498, 500}},

        --//________________________ Projectiles ____________________________\\--

            ['shoot'] = {{175, 181}},
            ['projectile_1_fly'] = {{182, 189}},
            ['projectile_1_exploded'] = {{198, 207}},
            ['projectile_1_destroyed'] = {{999, 1000}},

            ['projectile_2_fly'] = {{281, 305}, {381, 392}},
            ['projectile_2_exploded'] = {{414, 417}},
            ['projectile_2_destroyed'] = {{999, 1000}}

        },
        ['passive'] = function(dt, self)
            if self.health <= 50 then
                self.health = math.floor(self.health + 10 * dt)
                self.lifebar:updateDimensionsAndColors()
            end
        end,
        ['shoot'] = function(player)
            Projectile{player = player, type = 'fly', number = 1, velocity = 400}
        end,

        ['special_1'] = function(dt, self)
            dash(dt, self)
        end,
        ['special_2']  = function(dt, self)
            if self.animation.ending then
                Projectile{
                    player = self,
                    type = 'fly',
                    number = 2,
                    damage = 70,
                    velocity = 200,
                    relativeY = -self.width/3-3
                }
                self.state = 'idle'
            end
        end,


        ['cooldown'] = 5

    },
    ['Ai'] = {

        --//________________________ Attributtes ___________________________\\--

        ['armor'] = 30,
        ['damage'] = 10,
        ['punch_range'] = 45,
        ['kick_range'] = 55,
        ['sex'] = 'male',
        ['shootTrigger'] = 3,

        ['animations'] = {
        --//_______________________ Idle and Dance _________________________\\--

            ['idle'] = {{0, 7}},
            ['dancing'] = {{141, 143}, {470, 474}, {540, 550}, {551, 561}, {561, 566}},

        --//__________________________ Movement ____________________________\\--

            ['walking'] = {{8, 23}},
            ['running'] = {{111, 116}},
            ['jumping'] = {{29, 31}},
            ['duck'] = {{36, 46}},

        --//__________________________ Damage ______________________________\\--

            -- Punch
            ['punch'] = {{69, 73}, {122, 127}, {211, 215}},
            ['duck_punch'] = {{131, 135}, {245, 249}},
            ['air_punch'] = {{99, 100}},

            -- Kick
            ['kick'] = {{135, 138}, {190, 195}},
            ['duck_kick'] = {{199, 203}},
            ['air_kick'] = {{115, 117}},

            -- Hurt
            ['fall'] = {{526, 530}},
            ['hurt'] = {{559, 560}},

        --//________________________ End of Game ___________________________\\--


            ['dying'] = {{562, 566}},
            ['waiting'] = {{608, 612}},
            ['winning'] = {{553, 556}},

        --//_________________________ Specials _____________________________\\--

            ['special_1'] = {{212, 219}},
            ['special_2'] = {{498, 500}},

        --//________________________ Projectiles ____________________________\\--

            ['shoot'] = {{101, 104}, {463, 466}, {483, 491}},
            ['projectile_1_fly'] = {{466, 470}},
            ['projectile_1_exploded'] = {{198, 207}},
            ['projectile_1_destroyed'] = {{999, 1000}},

            ['projectile_2_spawn'] = {{338, 339}},
            ['projectile_2_exploded'] = {{999, 1000}},
            ['projectile_2_destroyed'] = {{999, 1000}},

            ['projectile_3_fly'] = {{354, 355}},
            ['projectile_3_exploded'] = {{}},
            ['projectile_3_destroyed'] = {{999, 1000}}

        },
        ['passive'] = function(dt, self)
            if self.health <= 50 then
                self.health = math.floor(self.health + 10 * dt)
                self.lifebar:updateDimensionsAndColors()
            end
        end,
        ['shoot'] = function(player)
            Projectile{player = player, type = 'fly', number = 1, velocity = 400}
        end,

        ['special_1'] = function(dt, self)
            dash(dt, self)
        end,
        ['special_2']  = function(dt, self)
            if self.animation.currentFrame > 4 and self.animation.currentFrame < 8 then
                self.y = math.floor(self.y + 400 * dt)
            elseif self.animation.currentFrame > 8 and self.animation.changing and not self.animation.ending then
                self.x = math.floor(self.x + self.velocity /2 * dt * self.direction)
                Projectile{
                    player = self,
                    type = 'fly',
                    number = 2,
                    incline = 270,
                    velocity = 400
                }
            else
                self.projectiles = {}
                self.numberOfProjectiles = 0
                self.state = 'jumping'
            end

        end,


        ['cooldown'] = 5

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
