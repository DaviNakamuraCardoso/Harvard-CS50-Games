--============================= The Characters Table =================================--

Characters = {

    ['Athena-Asamiya'] = {

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
            ['start'] = {{582, 586}},
        --//__________________________ Movement ____________________________\\--

            ['walking'] = {{8, 19}},
            ['running'] = {{69, 75}},
            ['jumping'] = {{30, 35}},
            ['duck'] = {{49, 52}, {554, 555}},

        --//___________________________ Damage _____________________________\\--

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
        ['shoot'] = function(self)
            Projectile{
                player = self,
                type = 'fly',
                number = 1,
                velocity = 400
            }
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

    ['Blue-Mary'] = {

        --//________________________ Attributtes ___________________________\\--

        ['armor'] = 30,
        ['damage'] = 10,
        ['punch_range'] = 20,
        ['kick_range'] = 40,
        ['sex'] = 'female',
        ['shootTrigger'] = 3,

        ['animations'] = {
        --//_______________________ Idle and Dance _________________________\\--

            ['idle'] = {{0, 6}},
            ['dancing'] = {{142, 144}, {527, 531}, {532, 541}, {543, 546}},
            ['start'] = {{468, 478}},
        --//__________________________ Movement ____________________________\\--

            ['walking'] = {{23, 32}},
            ['running'] = {{99, 112}},
            ['jumping'] = {{39, 52}},
            ['duck'] = {{64, 75}},

        --//__________________________ Damage ______________________________\\--

            -- Punch
            ['punch'] = {{131, 139}, {147, 152}, {184, 200}},
            ['duck_punch'] = {{156, 159}},
            ['air_punch'] = {{203, 205}},

            -- Kick
            ['kick'] = {{165, 170}, {212, 218}},
            ['duck_kick'] = {{181, 183}, {219, 223}, {230, 239}},
            ['air_kick'] = {{171, 174}, {175, 180}, {224, 229}},

            -- Hurt
            ['fall'] = {{575, 578}},
            ['hurt'] = {{549, 553}},

        --//________________________ End of Game ___________________________\\--


            ['dying'] = {{561, 565}},
            ['waiting'] = {{114, 116}, {400, 402}, {1489, 1490, 1491}},
            ['winning'] = {{505, 512}},

        --//_________________________ Specials _____________________________\\--

            ['special_1'] = {{392, 399}},
            ['special_2'] = {{450, 459}},
        --//________________________ Projectiles ____________________________\\--

            ['shoot'] = {{431, 441}},
            ['projectile_1_spawn'] = {{442, 449}},
            ['projectile_1_exploded'] = {{467, 478}},
            ['projectile_1_destroyed'] = {{999, 1000}},

            ['projectile_2_fly'] = {{461, 463, 464, 465, 466}},
            ['projectile_2_exploded'] = {{493, 496}},
            ['projectile_2_destroyed'] = {{999, 1000}},


        },
        ['passive'] = function(dt, self)
            if not self.passiveUpdated then
                self.damage = self.damage + self.enemy.damage / 5
                self.enemy.damage = self.enemy.damage - self.enemy.damage / 5
                self.passiveUpdated = true
            end
        end,
        ['shoot'] = function(self)
            Projectile{
              player = self,
              type = 'spawn',
              number = 1,
              range = 200
            }
        end,

        ['special_1'] = function(dt, self)
            if self.animation.ending then
                self.inAit = false
                self.state = 'idle'
            end
            dash(dt, self, {
                finalAnimation = 3,
                velocity = 300,
                incline = 90
            })
            dash(dt, self, {
                startAnimation = 4,
                velocity = 300,
                incline = 270
            })
        end,
        ['special_2']  = function(dt, self)
            if self.animation.ending then
                self.state = 'idle'
                Projectile{
                    player = self,
                    number = 2,
                    type = 'fly',
                    velocity = 200,
                    damage = 30
                }
            end
        end,


        ['cooldown'] = 5

    },

    ['Bonne-Jenet'] = {
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
            ['start'] = {{548, 559}},
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
            dash(dt, self, {
                velocity = 200,
                startAnimation = 6,
                finalAnimation = 12
            })
        end,
        ['special_2'] = function(dt, self)
            if self.animation.currentFrame >= 7 and self.animation.currentFrame <= 18 and self.animation.changing and self.animation.currentFrame % 2 == 0 then
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
    ['Adam-Bernstein'] = {

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
            ['start'] = {{1457, 1460}},

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
            ['winning'] = {{553, 555}},

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
        ['shoot'] = function(self)
            Projectile{player = self, type = 'fly', number = 1, velocity = 400}
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
        ['sex'] = 'female',
        ['shootTrigger'] = 7,

        ['animations'] = {
        --//_______________________ Idle and Dance _________________________\\--

            ['idle'] = {{0, 7}},
            ['dancing'] = {{141, 143}, {470, 474}, {540, 550}, {551, 561}, {561, 566}, {77, 80}},
            ['start'] = {{573, 574, 575, 576, 577, 578, 579, 580, 581, 582, 583, 584, 1588, 1589, 1590, 1591, 1592, 1593, 599, 600}},

        --//__________________________ Movement ____________________________\\--

            ['walking'] = {{8, 23}},
            ['running'] = {{111, 116}},
            ['jumping'] = {{26, 31}},
            ['duck'] = {{36, 46}},

        --//__________________________ Damage ______________________________\\--

            -- Punch
            ['punch'] = {{235, 239}, {1263, 1264, 1265, 268, 269, 270}},
            ['duck_punch'] = {{131, 135}, {245, 249}},
            ['air_punch'] = {{99, 100}},

            -- Kick
            ['kick'] = {{136, 138}, {191, 195}},
            ['duck_kick'] = {{200, 203}},
            ['air_kick'] = {{115, 117}},

            -- Hurt
            ['fall'] = {{526, 530}},
            ['hurt'] = {{559, 560}},

        --//________________________ End of Game ___________________________\\--


            ['dying'] = {{562, 566}},
            ['waiting'] = {{608, 612}},
            ['winning'] = {{553, 556}, {142, 143}, {279, 283}},

        --//_________________________ Specials _____________________________\\--

            ['special_1'] = {{1051, 1052, 1053, 59, 60, 61, 213, 214, 215, 216, 217, 218}},
            ['special_2'] = {{306, 307, 308, 309, 310, 311, 312, 313, 314, 316, 317, 1509, 1510, 1511, 515, 516, 518, 519, 520, 521, 2518, 523, 524, 525, 615, 616}},
--    --//________________________ Projectiles ____________________________\\--

            ['shoot'] = {{220, 221, 1222, 1223, 1224, 1225, 1226, 1227, 1228}},
            ['projectile_1_fly'] = {{1258, 1260}},
            ['projectile_1_exploded'] = {{999, 1000}},
            ['projectile_1_destroyed'] = {{999, 1000}},

            ['projectile_2_spawn'] = {{529, 537}},
            ['projectile_2_exploded'] = {{999, 1000}},
            ['projectile_2_destroyed'] = {{999, 1000}},

            ['projectile_3_spawn'] = {{538, 545}},
            ['projectile_3_exploded'] = {{999, 1000}},
            ['projectile_3_destroyed'] = {{999, 1000}},

        },
        ['passive'] = function(dt, self)
            if self.enemy.numberOfProjectiles >= 1 then
                local projectile = self.enemy.projectiles[1]
                if projectile.state == 'fly' or projectile.state == 'spawn' then
                    self.state = 'special_1'
                    if (projectile.x - self.x)^2 + (projectile.y - self.y)^2 < 10000 then
                        projectile.x = projectile.x - self.direction * 100
                        projectile.direction = -projectile.direction
                    end
                    self.animation.currentFrame = math.min(self.animation.currentFrame, 4)
                else
                    self.animations['special_1'].currentFrame = 1
                    self.enemy.projectiles = {}
                    self.enemy.numberOfProjectiles = 0
                end
            end
        end,
        ['shoot'] = function(self)
            Projectile{
                player = self,
                number = 1,
                type = 'fly',
                velocity = 500
            }
        end,

        ['special_1'] = function(dt, self)
            if self.animation.currentFrame < 6 then
                self.armor = 100
            elseif self.animation.ending then
                self.state = 'idle'
            end
            dash(dt, self, {
                startAnimation = 6
            })
        end,
        ['special_2']  = function(dt, self)
            self.animation.interval = 0.2
            if self.animation.ending then
                self.state = 'idle'
                self.projectiles = {}
                self.numberOfProjectiles = 0
            elseif self.animation.currentFrame == 8 and self.animation.changing then
                self.x = self.enemy.x - self.direction * 70
                Projectile{
                    player = self,
                    type = 'spawn',
                    number = 2,
                    range = 0,
                    relativeY = -self.height/2 - 100
                }
            elseif self.animation.currentFrame == 8 and self.animation.changing then
                Projectile{
                    player = self,
                    type = 'spawn',
                    number = 3,
                    infinity = true,
                    relativeY = -self.height/2 - 100

                }
            end

        end,


        ['cooldown'] = 5

    },
    ['Akari-Ichijo'] = {

        --//________________________ Attributtes ___________________________\\--

        ['armor'] = 15,
        ['damage'] = 10,
        ['punch_range'] = 70,
        ['kick_range'] = 50,
        ['sex'] = 'female',
        ['shootTrigger'] = 4,

        ['animations'] = {
        --//_______________________ Idle and Dance _________________________\\--

            ['idle'] = {{0, 11}},
            ['dancing'] = {{249, 252}, {717, 725}},
            ['start'] = {{408, 418}},

        --//__________________________ Movement ____________________________\\--

            ['walking'] = {{12, 23}},
            ['running'] = {{57, 65}},
            ['jumping'] = {{26, 33}},
            ['duck'] = {{51, 56}},

        --//__________________________ Damage ______________________________\\--

            -- Punch
            ['punch'] = {{109, 116}, {150, 1152, 1153, 1154, 157}, {158, 168}, {253, 258}},
            ['duck_punch'] = {{130, 136}},
            ['air_punch'] = {{124, 128}, {169, 173}},

            -- Kick
            ['kick'] = {{138, 141}, {192, 194}},
            ['duck_kick'] = {{145, 149}, {205, 214}},
            ['air_kick'] = {{142, 144}},

            -- Hurt
            ['fall'] = {{753, 756}},
            ['hurt'] = {{727, 731}},

        --//________________________ End of Game ___________________________\\--


            ['dying'] = {{740, 745}},
            ['waiting'] = {{609, 613}, {692, 697}},
            ['winning'] = {{175, 189}, {593, 596}},

        --//_________________________ Specials _____________________________\\--

            ['special_1'] = {{292, 307}},
            ['special_2'] = {{403, 418}},
        --//________________________ Projectiles ____________________________\\--

            ['shoot'] = {{1086, 1090}},
            ['projectile_1_fly'] = {{272, 281}},
            ['projectile_1_exploded'] = {{282, 290}},
            ['projectile_1_destroyed'] = {{999, 1000}},

            ['projectile_1_spawn'] = {{419, 428}},
            ['projectile_1_exploded'] = {{309, 343}},
            ['projectile_1_destroyed'] = {{999, 1000}},


        },
        ['passive'] = function(dt, self)
            if self.numberOfProjectiles >= 1 then
                for _, projectile in pairs(self.projectiles) do
                    if projectile.state == 'exploded' then
                        self.health = math.min(100, self.health + 10 * dt)
                        self.lifebar:updateDimensionsAndColors()
                    end
                end
            end

        end,
        ['shoot'] = function(self)
            Projectile{
              player = self,
              type = 'fly',
              number = 1,
              velocity = 400
            }
        end,

        ['special_1'] = function(dt, self)
            if self.animation.ending then
                self.state = 'idle'
                Projectile{
                    player = self,
                    number = 1,
                    type = 'spawn',
                    range = self.direction * (self.x - self.enemy.x)
                }
            end
        end,
        ['special_2']  = function(dt, self)
            if self.animation.ending then
                self.state = 'idle'
                self.inAir = false
            elseif self.animation.currentFrame == 6 then
                self.y = self.enemy.y - 200
                self.x = self.enemy.x - 300
            end
            dash(dt, self, {
                startAnimation = 6,
                finalAnimation = 13,
                velocity = 200,
                incline = 270
            })
        end,


        ['cooldown'] = 5

    },


    ['Clark'] = {

        --//________________________ Attributtes ___________________________\\--

        ['armor'] = 50,
        ['damage'] = 15,
        ['punch_range'] = 20,
        ['kick_range'] = 30,
        ['sex'] = 'male',
        ['shootTrigger'] = 3,

        ['animations'] = {
        --//_______________________ Idle and Dance _________________________\\--

            ['idle'] = {{0, 10}},
            ['dancing'] = {{361, 366}},
            ['start'] = {{467, 479}},

        --//__________________________ Movement ____________________________\\--

            ['walking'] = {{15, 21}},
            ['running'] = {{51, 60}},
            ['jumping'] = {{23, 33}},
            ['duck'] = {{130, 134}},

        --//__________________________ Damage ______________________________\\--

    --        -- Punch
            ['punch'] = {{100, 103}},
            ['duck_punch'] = {{95, 98}},
            ['air_punch'] = {{130, 134}},

    --        -- Kick
            ['kick'] = {{77, 87}},
            ['duck_kick'] = {{155, 159}},
            ['air_kick'] = {{136, 144}},

    --        -- Hurt
            ['fall'] = {{414, 415}},
            ['hurt'] = {{470, 472}},

        --//________________________ End of Game ___________________________\\--


            ['dying'] = {{419, 424}},
            ['waiting'] = {{449, 453}},
            ['winning'] = {{395, 403}},

    --    --//_________________________ Specials _____________________________\\--

            ['special_1'] = {{348, 359}},
            ['special_2'] = {{264, 278}},

    --    --//________________________ Projectiles ____________________________\\--

            ['shoot'] = {{264, 276}},


        },
        ['passive'] = function(dt, self)
	   		if self.state == 'duck' then
				self:detectDamage('front')
            elseif self.state == 'winning' then
                self.direction = -1

            end
		end,
        ['shoot'] = function(self)
		    self:detectDamage('around')
        end,

        ['special_1'] = function(dt, self)
		    dash(dt, self, {self.speed, 7, 10})
        end,
        ['special_2']  = function(dt, self)
            self:detectDamage('back')
            if self.animation.ending then
                self.state = 'idle'
            end
        end,


        ['cooldown'] = 3,

    },
    ['Elizabeth-Blanctorche'] = {

        --//________________________ Attributtes ___________________________\\--

        ['armor'] = 20,
        ['damage'] = 15,
        ['punch_range'] = 20,
        ['kick_range'] = 20,
        ['sex'] = 'female',
        ['shootTrigger'] = 7,

        ['animations'] = {
        --//_______________________ Idle and Dance _________________________\\--

            ['idle'] = {{0, 11}},
            ['dancing'] = {{579, 595}, {611, 627}, {628, 634}, {635, 645}},
            ['start'] = {{668, 673}},

        --//__________________________ Movement ____________________________\\--

            ['walking'] = {{20, 27}},
            ['running'] = {{75, 80}},
            ['jumping'] = {{37, 42}},
            ['duck'] = {{46, 56}},

        --//__________________________ Damage ______________________________\\--

            -- Punch
            ['punch'] = {{125, 133}, {205, 213}, {218, 226}},
            ['duck_punch'] = {{168, 172}, {245, 251}},
            ['air_punch'] = {{130, 134}, {236, 241}},

            -- Kick
            ['kick'] = {{133, 143}, {255, 268}},
            ['duck_kick'] = {{155, 159}, {272, 280}},
            ['air_kick'] = {{189, 195}},

            -- Hurt
            ['fall'] = {{692, 696}},
            ['hurt'] = {{735, 736}},

        --//________________________ End of Game ___________________________\\--


            ['dying'] = {{686, 691}},
            ['waiting'] = {{713, 716}},
            ['winning'] = {{597, 610}},

        --//_________________________ Specials _____________________________\\--

            ['special_1'] = {{101, 108}},
            ['special_2'] = {{281, 426}},

        --//________________________ Projectiles ____________________________\\--

            ['shoot'] = {{145, 152}, {283, 295}},

            ['projectile_1_fly'] = {{428, 428, 428}},
            ['projectile_1_exploded'] = {{433, 438}},
            ['projectile_1_destroyed'] = {{999, 1000}},

            ['projectile_2_fly'] = {{428, 432}},
            ['projectile_2_exploded'] = {{465, 472}},
            ['projectile_2_destroyed'] = {{999, 1000}}



        },
        ['passive'] = function(dt, self)
	   		if self.state == 'punch' or self.state == 'duck_punch' then
                if self.animation.ending then
                    Projectile{
                        player = self,
                        type = 'fly',
                        number = 1,
                        velocity = 400,
                        damage = 3

                    }
                end
            end
		end,
        ['shoot'] = function(self)
            Projectile{
                player = self,
                number = 1,
                type = 'fly',
                velocity = self.speed
            }
        end,

        ['special_1'] = function(dt, self)
            dash(dt, self, {
                velocity = 50,
                startAnimation = 3,
                finalAnimation = 10,
                incline = 180
            })
            if self.animation.ending then
                self.state = 'jumping'
            end
        end,
        ['special_2']  = function(dt, self)
            local shootFrames = {
                [12] = true,
                [21] = true,
                [37] = true,
                [46] = true,
                [64] = true,
                [76] = true,
                [95] = true,
                [101] = true,
                [139] = true
            }
            if self.animation.changing then
                if self.animation.ending then
                    self.state = 'idle'
                elseif self.animation.currentFrame == 120 then
                    self.health = self.health + 20
                    self.lifebar:updateDimensionsAndColors()
                elseif shootFrames[self.animation.currentFrame] then
                    Projectile{
                        player = self,
                        number = 2,
                        type = 'fly',
                        velocity = 2 * self.speed
                    }
                end
            end
        end,


        ['cooldown'] = 3,

    },
    ['Ex-Kyo'] = {

    --    --//________________________ Attributtes ___________________________\\--

        ['armor'] = 25,
        ['damage'] = 12,
        ['punch_range'] = 25,
        ['kick_range'] = 45,
        ['sex'] = 'male',
        ['shootTrigger'] = 3,

        ['animations'] = {
        --//_______________________ Idle and Dance _________________________\\--

            ['idle'] = {{0, 9}},
            ['dancing'] = {{601, 617}},
            ['start'] = {{601, 617}},

        --//__________________________ Movement ____________________________\\--

            ['walking'] = {{10, 13}},
            ['running'] = {{54, 58}},
            ['jumping'] = {{22, 31}},
            ['duck'] = {{38, 40}},

        --//__________________________ Damage ______________________________\\--

            -- Punch
            ['punch'] = {{80, 83}, {85, 89}, {113, 120}, {125, 127}, {229, 246}},
            ['duck_punch'] = {{100, 101}},
            ['air_punch'] = {{62, 63}, {121, 122}},

            -- Kick
            ['kick'] = {{102, 106}, {128, 137}, {163, 172}},
            ['duck_kick'] = {{109, 111}, {150, 154}, {156, 162}},
            ['air_kick'] = {{139, 142}},

            -- Hurt
            ['fall'] = {{706, 709}},
            ['hurt'] = {{733, 735}},

        --//________________________ End of Game ___________________________\\--


            ['dying'] = {{692, 697}},
            ['waiting'] = {{715, 717}},
            ['winning'] = {{598, 600}},

        --//_________________________ Specials _____________________________\\--

            ['special_1'] = {{360, 361, 362, 363, 364, 365, 366, 372, 374, 378, 386, 387, 388, 389}},
            ['special_2'] = {{463, 473}},
        --//________________________ Projectiles ____________________________\\--

            ['shoot'] = {{185, 192}, {272, 285}},
            ['projectile_1_spawn'] = {{563, 569}},
            ['projectile_1_exploded'] = {{199, 202}},
            ['projectile_1_destroyed'] = {{999, 1000}},

            ['projectile_2_spawn'] = {{367, 368, 369, 370, 371, 373, 375, 376, 377, 379, 380, 382, 383, 384, 385}},
            ['projectile_2_exploded'] = {{390, 395}},
            ['projectile_2_destroyed'] = {{999, 1000}},

            ['projectile_3_spawn'] = {{445, 452}},
            ['projectile_3_exploded'] = {{459, 462}},
            ['projectile_3_destroyed'] = {{999, 1000}}

        },
        ['shoot'] = function(self)
            Projectile{
                player = self,
                type = 'spawn',
                range = 50,
                number = 1
            }
        end,
         ['passive'] = function(dt, self)
            self.enemy.armor = Characters[self.enemy.name]['armor'] / 2
            self.armor = 30 + Characters[self.enemy.name]['armor'] / 2
        end,

        ['special_1'] = function(dt, self)
            if self.animation.currentFrame == 6 and self.animation.changing then
                specialProjectile = Projectile{
                    player = self,
                    type = 'spawn',
                    number = 2,
                    range = 0
                }
            elseif self.animation.currentFrame == 14 and self.animation.changing then
                specialProjectile.x = self.enemy.x
            elseif self.animation.ending then
                self.state = 'idle'
            end
        end,
        ['special_2']  = function(dt, self)
            if self.animation.ending then
                self.state = 'idle'
            elseif self.animation.currentFrame == 1 then
                Projectile{
                    player = self,
                    type = 'spawn',
                    number = 3,
                    range = 0,
                    relativeY = 0


                }
            elseif self.animation.currentFrame > 5 and self.animation.changing then
                self:detectDamage('front')
            end
        end,


        ['cooldown'] = 5

    },

    ['Fuuma'] = {

        --//________________________ Attributtes ___________________________\\--

        ['armor'] = 40,
        ['damage'] = 7,
        ['punch_range'] = 20,
        ['kick_range'] = 40,
        ['sex'] = 'male',
        ['shootTrigger'] = 2,

        ['animations'] = {
        --//_______________________ Idle and Dance _________________________\\--

            ['idle'] = {{0, 5}},
            ['dancing'] = {{666, 671}, {674, 690}},
            ['start'] = {{674, 679}},

        --//__________________________ Movement ____________________________\\--

            ['walking'] = {{6, 17}},
            ['running'] = {{53, 61}},
            ['jumping'] = {{19, 26}},
            ['duck'] = {{47, 52}},

        --//__________________________ Damage ______________________________\\--

            -- Punch
            ['punch'] = {{79, 90}, {114, 133}},
            ['duck_punch'] = {{94, 96}},
            ['air_punch'] = {{91, 93}},

            -- Kick
            ['kick'] = {{101, 105}, {133, 146}},
            ['duck_kick'] = {{154, 163}},
            ['air_kick'] = {{109, 110}, {185, 186}},

            -- Hurt
            ['fall'] = {{193, 196}},
            ['hurt'] = {{694, 698}},

        --//________________________ End of Game ___________________________\\--


            ['dying'] = {{710, 715}},
            ['waiting'] = {{703, 705}},
            ['winning'] = {{685, 689}},

        --//_________________________ Specials _____________________________\\--

            ['special_1'] = {{208, 219}, {317, 325}},
            ['special_2'] = {{501, 502, 503, 504, 505, 506, 507, 508, 509, 510, 511, 512, 513, 514, 515, 516, 517, 570, 571, 572, 573, 574, 575, 576, 577, 578, 579, 580, 581, 582, 583, 584, 585, 586, 587, 588, 589, 590, 591}},
        --//________________________ Projectiles ____________________________\\--

            ['shoot'] = {{70, 72}},
            ['projectile_1_fly'] = {{285, 288}},
            ['projectile_1_exploded'] = {{327, 342}},
            ['projectile_1_destroyed'] = {{999, 1000}},

             ['projectile_2_spawn'] = {{220, 225}},
             ['projectile_2_exploded'] = {{226, 258}},
             ['projectile_2_destroyed'] = {{999, 1000}}


        },
        ['passive'] = function(dt, self)
            self.enemy.damage = 4 * Characters[self.enemy.name]['damage'] / 5
            self.damage = 7 + 4 * Characters[self.enemy.name]['damage'] / 5
        end,
        ['shoot'] = function(self)
            Projectile{
              player = self,
              type = 'fly',
              number = 1,
              velocity = 400
            }
        end,

        ['special_1'] = function(dt, self)
            if self.animation.ending then
                Projectile{
                    player = self,
                    type = 'spawn',
                    number = 2,
                    range = self.direction * (self.x - self.enemy.x)
                }
                self.state = 'idle'
            end
        end,
        ['special_2']  = function(dt, self)

            self.inAir = true
            if self.animation.ending then
                self.inAir = false
                self.state = 'idle'
                self.animation.currentFrame = 1
            elseif self.animation.currentFrame <= 9 and self.animation.currentFrame >= 0 then
                self.inAir = true
                self.y = math.floor(self.y - 1.5 * self.speed * dt)
            elseif self.animation.currentFrame <= 11 and self.animation.currentFrame > 5 then
                self.inAir = true
                self.x = math.floor(self.x - 1/2 * self.direction * self.speed * dt)
            elseif self.animation.currentFrame <= 17 then
                self.inAir = true
                self:detectDamage('front')
                self.x = math.floor(self.x - self.direction * self.speed * dt)
                self.y = math.floor(self.y + 1.5 * self.speed * dt)
            elseif self.animation.currentFrame > 17 then
                self.inAir = true
                self:detectDamage('around')
            end



        end,


        ['cooldown'] = 5

    },
    ['Gato-Futaba'] = {

        --//________________________ Attributtes ___________________________\\--

        ['armor'] = 20,
        ['damage'] = 8,
        ['punch_range'] = 20,
        ['kick_range'] = 30,
        ['sex'] = 'male',
        ['shootTrigger'] = 3,

        ['animations'] = {
        --//_______________________ Idle and Dance _________________________\\--

            ['idle'] = {{0, 10}},
            ['dancing'] = {{366, 376}},
            ['start'] = {{319, 335}},

        --//__________________________ Movement ____________________________\\--

            ['walking'] = {{12, 19}},
            ['running'] = {{45, 50}},
            ['jumping'] = {{22, 34}},
            ['duck'] = {{35, 38}},

        --//___________________________ Damage ______________________________\\--

            -- Punch
            ['punch'] = {{91, 95}},
            ['duck_punch'] = {{101, 103}, {140, 147}},
            ['air_punch'] = {{115, 117}},

            -- Kick
            ['kick'] = {{104, 114}, {148, 158}},
            ['duck_kick'] = {{119, 121}, {163, 170}},
            ['air_kick'] = {{84, 86}},

            -- Hurt
            ['fall'] = {{430, 434}},
            ['hurt'] = {{455, 456}},

    --    --//________________________ End of Game ___________________________\\--


            ['dying'] = {{418, 421}},
            ['waiting'] = {{439, 441}},
            ['winning'] = {{383, 394}},

        --//_________________________ Specials _____________________________\\--

            ['special_1'] = {{260, 266}},
            ['special_2'] = {{286, 287, 288, 289, 355, 356, 357, 358, 359, 230, 231, 232, 233, 289, 290, 291, 292}},
--    --//________________________ Projectiles ____________________________\\--

            ['shoot'] = {{122, 125}},

            ['projectile_1_spawn'] = {{243, 245, 247, 249}},
            ['projectile_1_exploded'] = {{301, 317}},
            ['projectile_1_destroyed'] = {{999, 1000}},

            ['projectile_2_spawn'] = {{318, 328}},
            ['projectile_2_exploded'] = {{329, 334}},
            ['projectile_2_destroyed'] = {{999, 1000}},


        },
        ['passive'] = function(dt, self)
            if self.enemy.state == 'hurt' then
                self.enemy.heath = math.random(4) == 1 and self.enemy.health - 100 * dt or self.enemy.health
            end
        end,
        ['shoot'] = function(self)
            Projectile{
              player = self,
              type = 'spawn',
              number = 1,
              velocity = 400
            }
        end,

        ['special_1'] = function(dt, self)
            if self.animation.ending then
                for i=-1, 1, 2 do
                    Projectile{
                        player = self,
                        type = 'spawn',
                        number = 1,
                        range = i * 100
                    }
                end
                self.state = 'idle'
            end
        end,
        ['special_2']  = function(dt, self)
            if self.animation.ending then
                Projectile{
                    player = self,
                    type = 'spawn',
                    number = 2,
                    range = self.direction * (self.x - self.enemy.x),
                    relativeY = self.enemy.y - self.y
                }
                self.state = 'jumping'
            elseif self.animation.currentFrame <= 4 then
                self.x = math.floor(self.x - self.direction * self.speed * dt)
            elseif self.animation.currentFrame == 5 then
                self.y = math.floor(self.y - 1000 * dt)
                self.inAir = true
            elseif self.animation.currentFrame > 5 then
                self.inAir = true
            end
        end,


        ['cooldown'] = 5

    },

    ['Geese-Howard'] = {

        --//________________________ Attributtes ___________________________\\--

        ['armor'] = 20,
        ['damage'] = 13,
        ['punch_range'] = 30,
        ['kick_range'] = 50,
        ['sex'] = 'male',
        ['shootTrigger'] = 2,

        ['animations'] = {
        --//_______________________ Idle and Dance _________________________\\--

            ['idle'] = {{0, 4}},
            ['dancing'] = {{537, 539}},
            ['start'] = {{1554, 1560}},

        --//__________________________ Movement ____________________________\\--

            ['walking'] = {{5, 12}},
            ['running'] = {{39, 44}},
            ['jumping'] = {{21, 27}},
            ['duck'] = {{34, 38}},

        --//__________________________ Damage ______________________________\\--

            -- Punch
            ['punch'] = {{87, 90}},
            ['duck_punch'] = {{99, 101}},
            ['air_punch'] = {{121, 123}},

            -- Kick
            ['kick'] = {{132, 136}},
            ['duck_kick'] = {{112, 114}},
            ['air_kick'] = {{47, 48}},

            -- Hurt
            ['fall'] = {{593, 597}},
            ['hurt'] = {{632, 633}},

        --//________________________ End of Game ___________________________\\--


            ['dying'] = {{577, 582}},
            ['waiting'] = {{611, 613}},
            ['winning'] = {{544, 546}},

        --//_________________________ Specials _____________________________\\--

            ['special_1'] = {{309, 322}},
            ['special_2'] = {{346, 356}},
        --//________________________ Projectiles ____________________________\\--

            ['shoot'] = {{476, 488}},
            ['projectile_1_spawn'] = {{277, 287}},
            ['projectile_1_exploded'] = {{288, 290}},
            ['projectile_1_destroyed'] = {{999, 1000}},

            ['projectile_2_fly'] = {{449, 455}},
            ['projectile_2_exploded'] = {{443, 448}},
            ['projectile_2_destroyed'] = {{999, 1000}},

            ['projectile_3_spawn'] = {{459, 473}},
            ['projectile_3_exploded'] = {{288, 290}},
            ['projectile_3_destroyed'] = {{999, 1000}}
        },
        ['passive'] = function(dt, self)
            self.armor = math.floor(self.armor + 20 * dt)
        end,
        ['shoot'] = function(self)
            Projectile{
              player = self,
              type = 'spawn',
              number = 1,
              range = 400
            }
        end,

        ['special_1'] = function(dt, self)
            if self.animation.ending then
                Projectile{
                    player = self,
                    type = 'fly',
                    number = 2,
                    velocity = -400,
                    direction = -self.direction
                }
                self.state = 'idle'
            end
        end,
        ['special_2']  = function(dt, self)
            if self.animation.ending then
                for i=-5, 5, 2 do
                    Projectile{
                        player = self,
                        type = 'spawn',
                        number = 3,
                        range = i * 100,
                        direction = i > 0 and 1 or -1

                    }
                end
                self.state = 'idle'
            end
        end,


        ['cooldown'] = 5

    },

    ['Hanzo'] = {

        --//________________________ Attributtes ___________________________\\--

        ['armor'] = 30,
        ['damage'] = 7,
        ['punch_range'] = 20,
        ['kick_range'] = 30,
        ['sex'] = 'male',
        ['shootTrigger'] = 3,

        ['animations'] = {
        --//_______________________ Idle and Dance _________________________\\--

            ['idle'] = {{0, 5}},
            ['dancing'] = {{532, 534}, {541, 546}},
            ['start'] = {{1511, 1516}},

        --//__________________________ Movement ____________________________\\--

            ['walking'] = {{6, 12}},
            ['running'] = {{55, 63}},
            ['jumping'] = {{18, 38}},
            ['duck'] = {{118, 137}},

        --//__________________________ Damage ______________________________\\--

            -- Punch
            ['punch'] = {{80, 87}, {118, 137}},
            ['duck_punch'] = {{98, 101}},
            ['air_punch'] = {{95, 97}},

            -- Kick
            ['kick'] = {{140, 147}, {148, 154}},
            ['duck_kick'] = {{158, 167}},
            ['air_kick'] = {{111, 114}},

            -- Hurt
            ['fall'] = {{574, 577}},
            ['hurt'] = {{551, 555}},

        --//________________________ End of Game ___________________________\\--


            ['dying'] = {{560, 564}},
            ['waiting'] = {{66, 70}},
            ['winning'] = {{297, 301}},

        --//_________________________ Specials _____________________________\\--

            ['special_1'] = {{46, 49}},
            ['special_2'] = {{536, 546}},

        --//________________________ Projectiles ____________________________\\--

            ['shoot'] = {{219, 230}},
            ['projectile_1_fly'] = {{237, 242}},
            ['projectile_1_exploded'] = {{243, 251}},
            ['projectile_1_destroyed'] = {{999, 1000}},

            ['projectile_2_spawn'] = {{442, 447}},
            ['projectile_2_exploded'] = {{355, 428}},
            ['projectile_2_destroyed'] = {{999, 1000}}


        },
        ['passive'] = function(dt, self)
            self.specialPoints = math.min(100, self.specialPoints + 2 * dt)
            if self.numberOfProjectiles == 1 then
                if self.projectiles[1].state == 'exploded' then
                    self.enemy.armor = 0
                else
                    self.enemy.armor = Characters[self.enemy.name]['armor']
                end
            end
        end,
        ['shoot'] = function(self)
            Projectile{
              player = self,
              type = 'fly',
              number = 1,
              velocity = 400
            }
        end,

        ['special_1'] = function(dt, self)
            self.armor = 100
            if self.animation.ending then
                self.armor = 20
                self.state = 'idle'
            end
        end,
        ['special_2']  = function(dt, self)
            if self.animation.ending then
                self.projectiles = {}
                self.numberOfProjectiles = 0
                local projectile = Projectile{
                    player = self,
                    type = 'spawn',
                    number = 2,
                    range = 300
                }
                self.state = 'idle'
            end
        end,


       ['cooldown'] = 5

   },

    ['Haohmaru'] = {

        --//________________________ Attributtes ___________________________\\--

        ['armor'] = 40,
        ['damage'] = 14,
        ['punch_range'] = 30,
        ['kick_range'] = 10,
        ['sex'] = 'male',
        ['shootTrigger'] = 4,

        ['animations'] = {
        --//_______________________ Idle and Dance _________________________\\--

            ['idle'] = {{0, 11}},
            ['dancing'] = {{273, 280}, {482, 496}},
            ['start'] = {{451, 496}},

        --//__________________________ Movement ____________________________\\--

            ['walking'] = {{12, 25}},
            ['running'] = {{91, 98}},
            ['jumping'] = {{40, 48}},
            ['duck'] = {{68, 73}},

        --//__________________________ Damage ______________________________\\--

            -- Punch
            ['punch'] = {{362, 370}},
            ['duck_punch'] = {{154, 156}},
            ['air_punch'] = {{151, 153}},

            -- Kick
            ['kick'] = {{253, 265}},
            ['duck_kick'] = {{266, 268}},
            ['air_kick'] = {{}},

            -- Hurt
            ['fall'] = {{550, 553}},
            ['hurt'] = {{554, 556}},

    --    --//________________________ End of Game ___________________________\\--


            ['dying'] = {{534, 539}},
            ['waiting'] = {{542, 543}},
            ['winning'] = {{324, 327}},

        --//_________________________ Specials _____________________________\\--

            ['special_1'] = {{385, 394}},
            ['special_2'] = {{540, 550}},
        --//________________________ Projectiles ____________________________\\--

            ['shoot'] = {{282, 286}},
            ['projectile_1_spawn'] = {{287, 291}},
            ['projectile_1_exploded'] = {{344, 349}},
            ['projectile_1_destroyed'] = {{999, 1000}},

            ['projectile_2_spawn'] = {{395, 398}},
            ['projectile_2_exploded'] = {{400, 403}},
            ['projectile_2_destroyed'] = {{999, 1000}},

            ['projectile_3_fly'] = {{428, 438}},
            ['projectile_3_exploded'] = {{415, 424}},
            ['projectile_3_destroyed'] = {{999, 1000}}


        },
        ['passive'] = function(dt, self)
            if self.state == 'shoot' or self.state == 'special_1' or self.state == 'special_2' then
                if self.animation.ending then
                    self.damage = math.min(30, self.damage + 0.5)
                end
            end
        end,
        ['shoot'] = function(self)
            Projectile{
              player = self,
              type = 'spawn',
              number = 1,
              velocity = 400
            }
        end,

        ['special_1'] = function(dt, self)
            if self.animation.ending then
                Projectile{
                    player = self,
                    type = 'spawn',
                    number = 2,
                    range = self.direction * (self.x - self.enemy.x)

                }
                self.state = 'idle'
            end
        end,
        ['special_2']  = function(dt, self)
            if self.animation.ending then
                for i=-2, 2 do
                    Projectile{
                        player = self,
                        type = 'fly',
                        number = 3,
                        velocity = 300,
                        incline = 60,
                        relativeX = i * 50,
                        relativeY = -300
                    }
                end
                self.state = 'idle'
            end
        end,


        ['cooldown'] = 5

    },

    ['Hotaru-Futaba'] = {

        --//________________________ Attributtes ___________________________\\--

        ['armor'] = 10,
        ['damage'] = 11,
        ['punch_range'] = 15,
        ['kick_range'] = 50,
        ['sex'] = 'female',
        ['shootTrigger'] = 4,

        ['animations'] = {
        --//_______________________ Idle and Dance _________________________\\--

            ['idle'] = {{0, 9}},
            ['dancing'] = {{108, 112}},
            ['start'] = {{1489, 1495}},

        --//__________________________ Movement ____________________________\\--

            ['walking'] = {{10, 17}},
            ['running'] = {{45, 53}},
            ['jumping'] = {{29, 35}},
            ['duck'] = {{312, 321}},

        --//__________________________ Damage ______________________________\\--

            -- Punch
            ['punch'] = {{116, 121}},
            ['duck_punch'] = {{125, 127}, {158, 170}},
            ['air_punch'] = {{153, 157}},

            -- Kick
            ['kick'] = {{93, 105}, {128, 133}, {133, 138}, {171, 176}},
            ['duck_kick'] = {{141, 145}, {191, 200}, {339, 345}},
            ['air_kick'] = {{187, 190}, {244, 251}},

    --        -- Hurt
            ['fall'] = {{555, 558}},
            ['hurt'] = {{584, 585}},

    --    --//________________________ End of Game ___________________________\\--


            ['dying'] = {{539, 553}},
            ['waiting'] = {{562, 569}},
            ['winning'] = {{515, 522}},

    --    --//_________________________ Specials _____________________________\\--

            ['special_1'] = {{54, 73}},
            ['special_2'] = {{379, 431}},
--    --//________________________ Projectiles ____________________________\\--

            ['shoot'] = {{84, 92}, {146, 151}},
            ['projectile_1_fly'] = {{433, 439}},
            ['projectile_1_exploded'] = {{441, 449}},
            ['projectile_1_destroyed'] = {{999, 1000}},


        },
        ['passive'] = function(dt, self)
            self.damage = (115 - self.health)  / 4
        end,
        ['shoot'] = function(self)
            Projectile{
              player = self,
              type = 'fly',
              number = 1,
              velocity = 400
            }
        end,

        ['special_1'] = function(dt, self)
            dash(dt, self, {
                velocity = 200,
                startAnimation = 2,
                finalAnimation = 6,
                damage = 20
            })
            dash(dt, self, {
                velocity = 200,
                startAnimation = 7,
                finalAnimation = 12,
                damage = 20,
                incline = 180
            })

        end,
        ['special_2']  = function(dt, self)
            dash(dt, self, {
                velocity = 130,
                startAnimation = 7,
                finalAnimation = 12,
                damage = 10,
                incline = 180
            })
            dash(dt, self, {
                velocity = 100,
                startAnimation = 13,
                finalAnimation = 23,
                damage = 10,
                incline = 90
            })
            dash(dt, self, {
                velocity = 200,
                startAnimation = 24,
                finalAnimation = 39,
                damage = 20,
                incline = 315
            })
            if self.animation.ending then
                self.inAir = false
                self.state = 'idle'
            end

        end,


        ['cooldown'] = 5

    },

    ['Iori-Yagami'] = {

        --//________________________ Attributtes ___________________________\\--

        ['armor'] = 20,
        ['damage'] = 10,
        ['punch_range'] = 20,
        ['kick_range'] = 30,
        ['sex'] = 'male',
        ['shootTrigger'] = 3,

        ['animations'] = {
        --//_______________________ Idle and Dance _________________________\\--

            ['idle'] = {{0, 8}},
            ['dancing'] = {{111, 113}, {541, 550}, {552, 559}},
            ['start'] = {{423, 443}},

        --//__________________________ Movement ____________________________\\--

            ['walking'] = {{9, 20}},
            ['running'] = {{53, 61}},
            ['jumping'] = {{29, 34}},
            ['duck'] = {{36, 41}},

        --//__________________________ Damage ______________________________\\--

            -- Punch
            ['punch'] = {{94, 102}, {117, 123}},
            ['duck_punch'] = {{126, 130}, {190, 195}},
            ['air_punch'] = {{230, 234}},

            -- Kick
            ['kick'] = {{135, 139}, {216, 229}},
            ['duck_kick'] = {{141, 144}},
            ['air_kick'] = {{184, 189}},

            -- Hurt
            ['fall'] = {{595, 598}},
            ['hurt'] = {{633, 635}},

        --//________________________ End of Game ___________________________\\--

            ['dying'] = {{581, 586}},
            ['waiting'] = {{614, 616}},
            ['winning'] = {{447, 453}},

        --//_________________________ Specials _____________________________\\--

            ['special_1'] = {{239, 246}},
            ['special_2'] = {{319, 320, 321, 322, 360, 361, 362, 363, 364, 365}},
        --//________________________ Projectiles ____________________________\\--

            ['shoot'] = {{145, 153}},
            ['projectile_1_fly'] = {{367, 379}},
            ['projectile_1_exploded'] = {{423, 441}},
            ['projectile_1_destroyed'] = {{999, 1000}},

            ['projectile_2_spawn'] = {{247, 253}},
            ['projectile_2_exploded'] = {{247, 253}},
            ['projectile_2_destroyed'] = {{999, 1000}},


        },
        ['passive'] = function(dt, self)
            if self.health < 30 then
                self.enemy.armor = 10
            end
        end,
        ['shoot'] = function(self)
            Projectile{
              player = self,
              type = 'fly',
              number = 1,
              velocity = 400
            }
        end,

        ['special_1'] = function(dt, self)
            if self.animation.ending then
                Projectile{
                    player = self,
                    type = 'spawn',
                    number = 2,
                    range = 200
                }
                self.state = 'idle'
            end
        end,
        ['special_2']  = function(dt, self)
            if self.animation.ending then
                self.state = 'idle'
            end
            dash(dt, self, {
                velocity = 300,
                startAnimation = 2,
                finalAnimation = 4,
                incline = 90
            })
            dash(dt, self, {
                velocity = 200,
                startAnimation = 5,
                finalAnimation = 9,
                incline = 315
            })
        end,


        ['cooldown'] = 5

    },

    ['K'] = {

        --//________________________ Attributtes ___________________________\\--

        ['armor'] = 35,
        ['damage'] = 9,
        ['punch_range'] = 15,
        ['kick_range'] = 20,
        ['sex'] = 'male',
        ['shootTrigger'] = 3,

        ['animations'] = {
        --//_______________________ Idle and Dance _________________________\\--

            ['idle'] = {{7, 12}},
            ['dancing'] = {{672, 684}, {136, 139}},
            ['start'] = {{578, 577, 576, 575, 574, 573}},

        --//__________________________ Movement ____________________________\\--

            ['walking'] = {{13, 24}},
            ['running'] = {{70, 77}},
            ['jumping'] = {{37, 43}},
            ['duck'] = {{50, 55}},

        --//__________________________ Damage ______________________________\\--

            -- Punch
            ['punch'] = {{145, 149}, {190, 200}},
            ['duck_punch'] = {{154, 158}},
            ['air_punch'] = {{200, 205}},

            -- Kick
            ['kick'] = {{609, 622}, {114, 126}, {127, 134}, {159, 164}, {165, 171}, {214, 234}},
            ['duck_kick'] = {{180, 183}, {242, 251}},
            ['air_kick'] = {{585, 591}, {172, 180}, {235, 241}, {305, 311}, {375, 381}},

            -- Hurt
            ['fall'] = {{747, 750}},
            ['hurt'] = {{790, 792}},

        --//________________________ End of Game ___________________________\\--


            ['dying'] = {{730, 736}},
            ['waiting'] = {{770, 774}},
            ['winning'] = {{642, 652}},

        --//_________________________ Specials _____________________________\\--

            ['special_1'] = {{360, 374}},
            ['special_2'] = {{427, 453}},
        --//________________________ Projectiles ____________________________\\--

            ['shoot'] = {{271, 279}},
            ['projectile_1_spawn'] = {{281, 285}},
            ['projectile_1_exploded'] = {{285, 292}},
            ['projectile_1_destroyed'] = {{999, 1000}},


        },
        ['passive'] = function(dt, self)
            if self.state == 'hurt' then
                self.enemy.health = self.enemy.health - 5 * dt
                self.enemy.lifebar:updateDimensionsAndColors()
            elseif self.state == 'walking' then
                self.y = self.map.floor - self.height + 10
            end
        end,
        ['shoot'] = function(self)
            Projectile{
              player = self,
              type = 'spawn',
              number = 1,
              range = 300
            }
        end,

        ['special_1'] = function(dt, self)
            dash(dt, self, {
                velocity = 100,
                startAnimation = 5,
                finalAnimation = 8,
                damage = 30,
                incline = 90
            })
            dash(dt, self, {
                velocity = -100,
                startAnimation = 9,
                damage = 10,
                incline = 90,
            })
            if self.animation.ending then
                self.state = 'jumping'
            end
        end,
        ['special_2']  = function(dt, self)
            dash(dt, self, {
                velocity = 200,
                startAnimation = 1,
                finalAnimation = 7,
                damage = 20,
                incline = 45
            })
            dash(dt, self, {
                velocity = 300,
                startAnimation = 12,
                finalAnimation = 14,
                damage = 30
            })
            dash(dt, self, {
                velocity = 50,
                startAnimation = 13,
                finalAnimation = 22,
                damage = 40,
                incline = 315
            })
            dash(dt, self, {
                velocity = 100,
                startAnimation = 23,
                damage = 0,
                incline = 270
            })
        end,


        ['cooldown'] = 5

    },
    ['Kaede'] = {

        --//________________________ Attributtes ___________________________\\--

        ['armor'] = 12,
        ['damage'] = 12,
        ['punch_range'] = 30,
        ['kick_range'] = 20,
        ['sex'] = 'male',
        ['shootTrigger'] = 4,

        ['animations'] = {
        --//_______________________ Idle and Dance _________________________\\--

            ['idle'] = {{0, 7}},
            ['dancing'] = {{552, 558}},
            ['start'] = {{551, 558}},

        --//__________________________ Movement ____________________________\\--

            ['walking'] = {{8, 26}},
            ['running'] = {{74, 79}},
            ['jumping'] = {{29, 36}},
            ['duck'] = {{47, 54}},

        --//__________________________ Damage ______________________________\\--

            -- Punch
            ['punch'] = {{107, 108, 109, 110, 112, 114, 116, 118, 120, 121}},
            ['duck_punch'] = {{147, 150}},
            ['air_punch'] = {{138, 139, 141, 145, 146}},

            -- Kick
            ['kick'] = {{151, 156}},
            ['duck_kick'] = {{229, 243}},
            ['air_kick'] = {{157, 160}},

            -- Hurt
            ['fall'] = {{603, 606}},
            ['hurt'] = {{617, 618}},

        --//________________________ End of Game ___________________________\\--


            ['dying'] = {{588, 592}},
            ['waiting'] = {{561, 562}},
            ['winning'] = {{537, 550}},

    --    --//_________________________ Specials _____________________________\\--

            ['special_1'] = {{397, 401}},
            ['special_2'] = {{166, 167, 168, 169, 171, 173, 175, 177, 178, 179, 180, 181, 182, 183, 184, 185, 186, 188, 190, 192, 194}},
    --   --//________________________ Projectiles ____________________________\\--

            ['shoot'] = {{551, 560}},
            ['projectile_1_fly'] = {{365, 375}},
            ['projectile_1_exploded'] = {{373, 379}},
            ['projectile_1_destroyed'] = {{999, 1000}},

            ['projectile_2_spawn'] = {{338, 342}},
            ['projectile_2_exploded'] = {{355, 360}},
            ['projectile_2_destroyed'] = {{999, 1000}},


        },
        ['passive'] = function(dt, self)
            if self.health < 40 then
                self.range = 40
                self.damage = 15
            end
        end,
        ['shoot'] = function(self)
            Projectile{
              player = self,
              type = 'fly',
              number = 1,
              velocity = 500,
              incline = 315,
              relativeY = -300
            }
        end,

        ['special_1'] = function(dt, self)
            if self.animation.ending then
                self.health = self.health + 5
                self.lifebar:updateDimensionsAndColors()
                self.state = 'idle'
            end
        end,
        ['special_2']  = function(dt, self)
            local attacks = {
                [6] = true,
                [11] = true,
                [17] = true
            }
            if self.animation.ending then
                self.state = 'idle'
            elseif attacks[self.animation.currentFrame] and self.animation.changing then
                Projectile{
                    player = self,
                    number = 2,
                    type = 'spawn',
                    damage = 40,
                    range = 70
                }
            end
            self:detectDamage('around')

        end,


        ['cooldown'] = 5

    },
    ['Kasumi-Todoh'] = {

        --//________________________ Attributtes ___________________________\\--

        ['armor'] = 20,
        ['damage'] = 10,
        ['punch_range'] = 40,
        ['kick_range'] = 50,
        ['sex'] = 'female',
        ['shootTrigger'] = 3,

        ['animations'] = {
        --//_______________________ Idle and Dance _________________________\\--

            ['idle'] = {{4, 7}},
            ['dancing'] = {{344, 355}},
            ['start'] = {{336, 360, 362, 364, 366, 368, 370, 372, 374, 376, 378, 380, 384}},

        --//__________________________ Movement ____________________________\\--

            ['walking'] = {{8, 12}},
            ['running'] = {{44, 49}},
            ['jumping'] = {{15, 24}},
            ['duck'] = {{55, 61}},

        --//__________________________ Damage ______________________________\\--

            -- Punch
            ['punch'] = {{79, 82}, {119, 124}, {210, 218}},
            ['duck_punch'] = {{97, 99}},
            ['air_punch'] = {{130, 133}},

            -- Kick
            ['kick'] = {{100, 106}},
            ['duck_kick'] = {{154, 160}, {116, 118}},
            ['air_kick'] = {{161, 166}, {112, 115}},

            -- Hurt
            ['fall'] = {{425, 429}},
            ['hurt'] = {{457, 459}},
        --//________________________ End of Game ___________________________\\--


            ['dying'] = {{411, 416}},
            ['waiting'] = {{65, 67}},
            ['winning'] = {{386, 389}},

    --    --//_________________________ Specials _____________________________\\--

            ['special_1'] = {{257, 258, 259, 260, 262, 266, 273, 277}},
            ['special_2'] = {{336, 360, 362, 364, 366, 368, 370, 372, 374, 376, 378, 380, 384}},
--    --//________________________ Projectiles ____________________________\\--

            ['shoot'] = {{157, 164}},
            ['projectile_1_spawn'] = {{180, 190}},
            ['projectile_1_exploded'] = {{267, 272}},
            ['projectile_1_destroyed'] = {{999, 1000}},

            ['projectile_2_spawn'] = {{261, 263, 264, 265, 267, 268, 269, 270, 271, 272, 274, 275}},
            ['projectile_2_exploded'] = {{240, 243}},
            ['projectile_2_destroyed'] = {{999, 1000}},

            ['projectile_3_fly'] = {{776, 777}},
            ['projectile_3_exploded'] = {{881, 882}},
            ['projectile_3_destroyed'] = {{999, 1000}},


    },
        ['passive'] = function(dt, self)
            if self.state == 'duck' then
                dash(dt, self, {
                    velocity = 100,
                    damage = 10,
                    startAnimation = 2,
                    finalAnimation = 4
                })
            end


        end,
        ['shoot'] = function(self)
            Projectile{
              player = self,
              type = 'spawn',
              number = 1,
              range = 200
            }
        end,

        ['special_1'] = function(dt, self)
            if self.animation.ending then
                self.state = 'idle'
            elseif self.animation.currentFrame == 1 and self.animation.changing then
                Projectile{
                    type = 'spawn',
                    player = self,
                    number = 2,
                    range = 0,
                    relativeY = self.height / 2,
                    damage = 20
                }
            end
        end,
        ['special_2']  = function(dt, self)
            if self.animation.currentFrame == 2 and self.animation.changing then
                for i=-3, 3 do
                    Projectile{
                        player = self,
                        type = 'fly',
                        number = 3,
                        relativeY = -200,
                        relativeX = i*40,
                        damage = 20,
                        incline = 300,
                        velocity = 500
                    }
                end
            elseif self.animation.ending then
                self.state = 'idle'
            end
        end,


        ['cooldown'] = 5

    },

    ['Kim'] = {

        --//________________________ Attributtes ___________________________\\--

        ['armor'] = 30,
        ['damage'] = 12,
        ['punch_range'] = 20,
        ['kick_range'] = 50,
        ['sex'] = 'male',
        ['shootTrigger'] = 1,

        ['animations'] = {
        --//_______________________ Idle and Dance _________________________\\--

            ['idle'] = {{0, 9}},
            ['dancing'] = {{359, 362}},
            ['start'] = {{413,419}},
        --//__________________________ Movement ____________________________\\--

            ['walking'] = {{11, 16}},
            ['running'] = {{48, 53}},
            ['jumping'] = {{24, 28}},
            ['duck'] = {{45, 47}},

        --//__________________________ Damage ______________________________\\--

            -- Punch
            ['punch'] = {{320, 326}, {255, 275}},
            ['duck_punch'] = {{111, 112}},
            ['air_punch'] = {{313, 318}},

            -- Kick
            ['kick'] = {{76, 83}, {84, 94}, {113, 121}},
            ['duck_kick'] = {{179, 185}},
            ['air_kick'] = {{238, 240}},

            -- Hurt
            ['fall'] = {{477, 450}},
            ['hurt'] = {{475, 477}},

    --    --//________________________ End of Game ___________________________\\--


            ['dying'] = {{434, 439}},
            ['waiting'] = {{63, 65}},
            ['winning'] = {{376, 419}, {345, 353}, {363, 372}},

        --//_________________________ Specials _____________________________\\--

            ['special_1'] = {{96, 100}},
            ['special_2'] = {{204, 235}},
        --//________________________ Projectiles ____________________________\\--

            ['shoot'] = {{24, 40}}


        },
        ['passive'] = function(dt, self)
            if not self.passiveUpdated then
                self.enemy.range = Characters[self.enemy.name]['punch_range'] / 1.5
                self.passiveUpdated = true
            end
        end,
        ['shoot'] = function(self)
            dash(dt, self, {
                velocity = 100,
                startAnimation = 5,
                finalAnimation = 8
            })
            dash(dt, self, {
                velocity = 100,
                startAnimation = 9,
                finalAnimation = 13,
                incline = 180
            })
        end,

        ['special_1']  = function(dt, self)
            if self.animation.ending then
                self.state = 'idle'
            else
                self.enemy.state = 'hurt'
                self.enemy.health = self.enemy.health - 10 * dt
                self.health = math.min(100, self.health + 5 * dt)
                self.lifebar:updateDimensionsAndColors()
                self.enemy.lifebar:updateDimensionsAndColors()
            end
        end,

        ['special_2'] = function(dt, self)
            dash(dt, self, {
                velocity = 100,
                damage = 20,
                startAnimation = 3,
                finalAnimation = 10,
                incline = 180
            })
            dash(dt, self, {
                velocity = 100,
                damage = 25,
                startAnimation = 6,
                finalAnimation = 18
            })
            self:detectDamage('front')
            if self.animation.ending then
                self.state = 'idle'
            end
        end,

        ['cooldown'] = 5

    },
    ['Kisarah-Westfield'] = {

        --//________________________ Attributtes ___________________________\\--

        ['armor'] = 15,
        ['damage'] = 15,
        ['punch_range'] = 30,
        ['kick_range'] = 40,
        ['sex'] = 'female',
        ['shootTrigger'] = 3,

        ['animations'] = {
        --//_______________________ Idle and Dance _________________________\\--

            ['idle'] = {{0, 6}},
            ['dancing'] = {{575, 584}, {636, 645}, {646, 660}, {665, 683}, {7, 30}},
            ['start'] = {{665, 684}},

        --//__________________________ Movement ____________________________\\--

            ['walking'] = {{35, 42}},
            ['running'] = {{108, 115}},
            ['jumping'] = {{51, 63}, {63, 72}, {73, 83}},
            ['duck'] = {{85, 90}},

        --//__________________________ Damage ______________________________\\--

            -- Punch
            ['punch'] = {{134, 146}, {158, 167}, {208, 219}, {219, 233}},
            ['duck_punch'] = {{171, 176}, {239, 254}, {296, 341}, {345, 382}},
            ['air_punch'] = {{168, 170}},

            -- Kick
            ['kick'] = {{177, 185}, {186, 196}, {256, 264}, {265, 281}},
            ['duck_kick'] = {{200, 207}, {288, 295}},
            ['air_kick'] = {{197, 199}, {282, 285}},

            -- Hurt
            ['fall'] = {{729, 732}},
            ['hurt'] = {{704, 707}},

        --//________________________ End of Game ___________________________\\--


            ['dying'] = {{713, 718}},
            ['waiting'] = {{698, 702}},
            ['winning'] = {{534, 536}, {662, 664}},

        --//_________________________ Specials _____________________________\\--

            ['special_1'] = {{580, 581, 582, 583, 584, 585, 588, 595, 597, 598, 601, 602, 603, 605, 607, 609, 611, 613, 615, 616, 617, 618}},
            ['special_2'] = {{489, 557}},
        --//________________________ Projectiles ____________________________\\--

            ['shoot'] = {{451, 463}, {464, 484}},
            ['projectile_1_fly'] = {{619, 626}},
            ['projectile_1_exploded'] = {{627, 635}},
            ['projectile_1_destroyed'] = {{999, 1000}},

            ['projectile_2_spawn'] = {{559, 561}},
            ['projectile_2_exploded'] = {{560, 574}},
            ['projectile_2_destroyed'] = {{999, 1000}},

            ['projectile_3_spawn'] = {{589, 590, 591, 592, 593, 594, 596, 597, 599, 604, 606, 608, 610, 612, 614}},
            ['projectile_3_exploded'] = {{999, 1000}},
            ['projectile_3_destroyed'] = {{999, 1000}}



        },
        ['passive'] = function(dt, self)
            if self.enemy.sex == 'male' then
                self.enemy.damage = Characters[self.enemy.name]['damage'] / 1.5
            else
                self.damage = 20
            end
        end,
        ['shoot'] = function(self)
            Projectile{
              player = self,
              type = 'fly',
              number = 1,
              velocity = 400
            }
        end,

        ['special_1'] = function(dt, self)
            if self.animation.ending then
                Projectile{
                    player = self,
                    type = 'fly',
                    number = 1,
                    velocity = 300
                }
                self.state = 'idle'
            elseif self.animation.currentFrame == 3 and self.animation.changing then
                Projectile{
                    type = 'spawn',
                    player = self,
                    number = 3,
                    range = -55,
                    relativeY = -self.height/2 - 10
                }
            elseif self.animation.currentFrame == 12 and self.animation.changing then
                self.health = math.min(100, self.health + 7)
                self.lifebar:updateDimensionsAndColors()
            end
        end,
        ['special_2']  = function(dt, self)
            self:detectDamage('around', 70)
            dash(dt, self, {
                startAnimation = 51,
                finalAnimation = 54,
                velocity = 100,
                incline = 90

            })
            dash(dt, self, {
                startAnimation = 68,
                finalAnimation = 71,
                velocity = 100,
                incline = 270
            })
            if self.animation.ending then
                Projectile{
                    player = self,
                    type = 'spawn',
                    range = self.direction * (self.x - self.enemy.x),
                    number = 2
                }
                self.state = 'jumping'
            end
        end,


        ['cooldown'] = 5

    },


    ['Kula-Diamond'] = {

        --//________________________ Attributtes ___________________________\\--

        ['armor'] = 30,
        ['damage'] = 10,
        ['punch_range'] = 30,
        ['kick_range'] = 50,
        ['sex'] = 'female',
        ['shootTrigger'] = 9,

        ['animations'] = {
        --//_______________________ Idle and Dance _________________________\\--

            ['idle'] = {{0, 5}},
            ['dancing'] = {{102, 125}, {143, 147}},
            ['start'] = {{566, 567, 568, 569, 570, 571, 572, 573, 574, 575, 576, 577}},

        --//__________________________ Movement ____________________________\\--

            ['walking'] = {{16, 27}},
            ['running'] = {{80, 90}},
            ['jumping'] = {{35, 46}},
            ['duck'] = {{49, 56}},

        --//__________________________ Damage ______________________________\\--

            -- Punch
            ['punch'] = {{91, 96}, {150, 154}, {215, 219}},
            ['duck_punch'] = {{264, 270}},
            ['air_punch'] = {{258, 263}},

            -- Kick
            ['kick'] = {{174, 184}, {135, 141}, {185, 193}},
            ['duck_kick'] = {{199, 202}},
            ['air_kick'] = {{192, 198}},

            -- Hurt
            ['fall'] = {{703, 706}},
            ['hurt'] = {{746, 748}},

        --//________________________ End of Game ___________________________\\--


            ['dying'] = {{685, 690}},
            ['waiting'] = {{727, 729}},
            ['winning'] = {{528, 540}, {541, 545}},

    --    --//_________________________ Specials _____________________________\\--

            ['special_1'] = {{341, 350}},
            ['special_2'] = {{300, 301, 302, 303, 304, 305, 306, 234, 235, 236, 237, 238, 239, 240, 162, 163, 164, 166, 168, 445, 446, 449, 450, 451, 455, 456, 457, 458, 371, 372, 373, 374, 375, 376, 377, 378, 379, 380, 381, 382, 383}},
--    --//________________________ Projectiles ____________________________\\--

            ['shoot'] = {{351, 361}},
            ['projectile_1_spawn'] = {{362, 370}},
            ['projectile_1_exploded'] = {{362, 370}},
            ['projectile_1_destroyed'] = {{999, 1000}},

            ['projectile_2_spawn'] = {{65, 65, 65}},
            ['projectile_2_exploded'] = {{69, 70, 71}},
            ['projectile_2_destroyed'] = {{999, 1000}},

            ['projectile_3_fly'] = {{337, 340}},
            ['projectile_3_exploded'] = {{321, 323}},
            ['projectile_3_destroyed'] = {{999, 1000}},

            ['projectile_4_fly'] = {{165, 167, 169}},
            ['projectile_4_exploded'] = {{321, 323}},
            ['projectile_4_destroyed'] = {{999, 1000}},

            ['projectile_5_spawn'] = {{447, 448, 452, 453, 454}},
            ['projectile_5_exploded'] = {{999, 1000}},
            ['projectile_5_destroyed'] = {{999, 1000}}




        },
        ['passive'] = function(dt, self)
            if self.state == 'hurt' and self.animation.ending then
                for _, projectile in pairs(self.projectiles) do
                    projectile.state = 'exploded'
                end
                self.projectiles = {}
                self.numberOfProjectiles = 0

            elseif self.state == 'shoot' and self.animation.ending then
                Projectile{
                    player = self,
                    number = 2,
                    type = 'spawn',
                    range = 10,
                    infinity = true,
                    explodeAtEnemy = false,
                    relativeY = -70
                }
            end
            if self.numberOfProjectiles >= 1 then
                if self.projectiles[self.numberOfProjectiles].state == 'spawn' then
                    self.armor = 100
                else
                    self.armor = 30
                end
            else
                self.armor = 30
            end
        end,
        ['shoot'] = function(self)
            Projectile{
              player = self,
              type = 'spawn',
              number = 1,
              range = self.direction * (self.x - self.enemy.x)
            }
        end,

        ['special_1'] = function(dt, self)
            if self.animation.ending then
                self.state = 'duck'
            elseif self.animation.currentFrame == 1 and self.animation.changing then
                Projectile{
                    player = self,
                    type = 'fly',
                    number = 3,
                    velocity = 300
                }
            end
            dash(dt, self, {
                startAnimation = 2,
                damage = 15,
                velocity = self.speed * 3
            })
        end,
        ['special_2']  = function(dt, self)
            dash(dt, self, {
                startAnimation = 1,
                finalAnimation = 7,
                incline = 90,
                velocity = 40
            })
            dash(dt ,self, {
                startAnimation = 9,
                finalAnimation = 15,
                incline = 300,
                damage = 20,
                velocity = 100
            })
            if self.animation.ending then
                self.state = 'jumping'
                self.armor = 30
            elseif self.animation.currentFrame == 15 and self.animation.changing then
                self.inAir = false
                self.y = self.map.floor - self.height
                for i=-3, 3 do
                    Projectile{
                        player = self,
                        type = 'fly',
                        number = 4,
                        incline = 320,
                        velocity = 300,
                        relativeY = -300,
                        relativeY = 40 * i
                    }
                end
            elseif self.animation.currentFrame == 20 and self.animation.changing then
                Projectile{
                    player = self,
                    type = 'spawn',
                    number = 5,
                    range = 0
                }
                self.armor = 100
            elseif self.animation.currentFrame == 33 and self.animation.changing then
                self.health = self.health + 10
                self.lifebar:updateDimensionsAndColors()
            end


        end,


        ['cooldown'] = 5

    },

    ['Magaki'] = {

        --//________________________ Attributtes ___________________________\\--

        ['armor'] = 40,
        ['damage'] = 12,
        ['punch_range'] = 40,
        ['kick_range'] = 50,
        ['sex'] = 'male',
        ['shootTrigger'] = 6,

        ['animations'] = {
        --//_______________________ Idle and Dance _________________________\\--

            ['idle'] = {{0, 6}},
            ['dancing'] = {{94, 100}},
            ['start'] = {{1542, 1543, 1544, 1545, 1546, 1547, 1553, 1554, 1555, 1556, 1557, 1558, 1559, 1560, 1561, 1562, 1563, 1564, 1565, 1566, 1567}},

        --//__________________________ Movement ____________________________\\--

            ['walking'] = {{8, 17}},
            ['running'] = {{50, 55}},
            ['jumping'] = {{25, 32}},
            ['duck'] = {{63, 66}},

        --//__________________________ Damage ______________________________\\--

            -- Punch
            ['punch'] = {{85, 91}, {101, 105}, {107, 114}},
            ['duck_punch'] = {{192, 194}},
            ['air_punch'] = {{117, 121}},

            -- Kick
            ['kick'] = {{77, 84}},
            ['duck_kick'] = {{127, 133}},
            ['air_kick'] = {{183, 187}},

            -- Hurt
            ['fall'] = {{747, 750}},
            ['hurt'] = {{779, 781}},

        --//________________________ End of Game ___________________________\\--


            ['dying'] = {{732, 737}},
            ['waiting'] = {{759, 761}},
            ['winning'] = {{599, 664}},

        --//_________________________ Specials _____________________________\\--

            ['special_1'] = {{56, 62}},
            ['special_2'] = {{344, 345, 347, 349, 351, 353, 355, 356, 375, 376, 377, 378, 363, 365}},
        --//________________________ Projectiles ____________________________\\--

            ['shoot'] = {{243, 245, 247, 249, 251, 253, 255, 257, 259, 261, 263, 265, 267, 269, 270, 272, 274}},
            ['projectile_1_fly'] = {{280, 282, 284, 286, 288, 290}},
            ['projectile_1_exploded'] = {{308, 313}},
            ['projectile_1_destroyed'] = {{999, 1000}},


        },
        ['passive'] = function(dt, self)
            if self.enemy.state == 'hurt' then
                self.health = math.min(100, self.health + 5 * dt)
                self.lifebar:updateDimensionsAndColors()
            end
        end,
        ['shoot'] = function(self)
            Projectile{
              player = self,
              type = 'fly',
              number = 1,
              velocity = 400
            }
        end,

        ['special_1'] = function(dt, self)
            if self.animation.ending then
                self.state = 'idle'
            end

            self.enemy.state = 'hurt'
            self.enemy.health = self.enemy.health - 10 * dt
            self.health = math.min(100, self.health + 10 * dt)
            self.lifebar:updateDimensionsAndColors()
            self.enemy.lifebar:updateDimensionsAndColors()
        end,
        ['special_2']  = function(dt, self)
            if self.animation.ending then
                self.state = 'idle'
            elseif self.animation.currentFrame == 8 and self.animation.changing then
                self.x = self.x + 200
            end
        end,


        ['cooldown'] = 5

    },

    ['Maxima'] = {

        --//________________________ Attributtes ___________________________\\--

        ['armor'] = 80,
        ['damage'] = 5,
        ['punch_range'] = 20,
        ['kick_range'] = 30,
        ['sex'] = 'male',
        ['shootTrigger'] = 8,

        ['animations'] = {
        --//_______________________ Idle and Dance _________________________\\--

            ['idle'] = {{0, 4}},
            ['dancing'] = {{419, 426}, {424, 443}, {457, 466}},
            ['start'] = {{419, 426}},

        --//__________________________ Movement ____________________________\\--

            ['walking'] = {{6, 13}},
            ['running'] = {{40, 45}},
            ['jumping'] = {{21, 24}},
            ['duck'] = {{36, 39}},

        --//__________________________ Damage ______________________________\\--

            -- Punch
            ['punch'] = {{122, 130}, {68, 87}, {164, 166}, {174, 180}},
            ['duck_punch'] = {{104, 107}, {134, 141}},
            ['air_punch'] = {{99, 102}},

            -- Kick
            ['kick'] = {{108, 112}},
            ['duck_kick'] = {{117, 121}, {152, 159}},
            ['air_kick'] = {{147, 149}, {160, 163}},

            -- Hurt
            ['fall'] = {{493, 495}},
            ['hurt'] = {{527, 529}},

        --//________________________ End of Game ___________________________\\--


            ['dying'] = {{482, 486}},
            ['waiting'] = {{508, 510}},
            ['winning'] = {{282, 285}, {89, 94}, {444, 448}},

        --//_________________________ Specials _____________________________\\--

            ['special_1'] = {{46, 56}},
            ['special_2'] = {{246, 247, 248, 249, 250, 251, 252, 253, 254, 255, 256, 257, 258, 259, 260, 262, 263, 264, 265, 266, 267, 268}},
        --//________________________ Projectiles ____________________________\\--

            ['shoot'] = {{286, 295}},
            ['projectile_1_fly'] = {{392, 394}},
            ['projectile_1_exploded'] = {{355, 361}},
            ['projectile_1_destroyed'] = {{999, 1000}},


        },
        ['passive'] = function(dt, self)
            if self.health <= 30 and self.enemy.health > self.health then
                tmp = self.health
                self.health = self.enemy.health
                self.enemy.health = tmp
                self.lifebar:updateDimensionsAndColors()
                self.enemy.lifebar:updateDimensionsAndColors()
            end

        end,
        ['shoot'] = function(self)
            Projectile{
              player = self,
              type = 'fly',
              number = 1,
              velocity = 400,
              relativeX = -self.direction * self.width / 2
            }
        end,

        ['special_1'] = function(dt, self)
            if self.animation.ending then
                self.state = 'idle'
            end
            dash(dt, self, {
                startAnimation = 6,
                finalAnimation = 8,
                damage = 20,
                velocity = 2 * self.speed
            })
        end,
        ['special_2']  = function(dt, self)
            if self.animation.ending then
                self.state = 'idle'
            end
            dash(dt, self, {
                startAnimation = 8,
                finalAnimation = 15,
                damage = 50,
                velocity = 300
            })
        end,


        ['cooldown'] = 5

    },

    ['Mai-Shiranui'] = {

        --//________________________ Attributtes ___________________________\\--

        ['armor'] = 13,
        ['damage'] = 14,
        ['punch_range'] = 30,
        ['kick_range'] = 50,
        ['sex'] = 'female',
        ['shootTrigger'] = 3,

        ['animations'] = {
        --//_______________________ Idle and Dance _________________________\\--

            ['idle'] = {{0, 11}},
            ['dancing'] = {{191, 196}, {467, 477}, {489, 494}},
            ['start'] = {{495, 517}},

        --//__________________________ Movement ____________________________\\--

            ['walking'] = {{12, 17}},
            ['running'] = {{49, 56}},
            ['jumping'] = {{25, 32}},
            ['duck'] = {{33, 37}},

        --//__________________________ Damage ______________________________\\--

            -- Punch
            ['punch'] = {{102, 111}},
            ['duck_punch'] = {{117, 126}},
            ['air_punch'] = {{112, 116}},

    --        -- Kick
            ['kick'] = {{127, 134}, {161, 173}},
            ['duck_kick'] = {{70, 73}, {141, 143}, {180, 190}},
            ['air_kick'] = {{135, 139}, {176, 179}},

    --        -- Hurt
            ['fall'] = {{545, 548}},
            ['hurt'] = {{518, 521}},

    --    --//________________________ End of Game ___________________________\\--


            ['dying'] = {{531, 536}},
            ['waiting'] = {{539, 541}},
            ['winning'] = {{451, 466}, {479, 488}},

        --//_________________________ Specials _____________________________\\--

            ['special_1'] = {{255, 303}},
            ['special_2'] = {{326, 327, 328, 329, 330, 331, 332, 333, 334, 335, 336, 337, 338, 340, 341, 342, 343, 344, 345, 346, 347, 348, 351, 352, 353, 354, 355, 356, 357, 358, 359, 360, 361, 362, 363, 364, 365, 366, 367, 368, 369, 370, 371, 372, 373, 322, 323, 324, 325}},
        --//________________________ Projectiles ____________________________\\--

            ['shoot'] = {{240, 252}},
            ['projectile_1_fly'] = {{394, 399}},
            ['projectile_1_exploded'] = {{410, 423}},
            ['projectile_1_destroyed'] = {{999, 1000}},


        },
        ['passive'] = function(dt, self)
            if not self.passiveUpdated then
                if self.enemy.sex == 'male' then
                    self.enemy.damage = self.enemy.damage - self.enemy.damage / 5
                else
                    self.armor = self.armor + 15
                end
                self.passiveUpdated = true
            end
        end,
        ['shoot'] = function(self)
            Projectile{
              player = self,
              type = 'fly',
              number = 1,
              velocity = 400
            }
        end,

        ['special_1'] = function(dt, self)
            if self.animation.ending then
                self.inAir = false
                self.state = 'idle'
            elseif self.animation.currentFrame == 8 then
                self.inAir = false
            end
            dash(dt, self, {
                finalAnimation = 3,
                incline = 45,
                velocity = 300
            })
            dash(dt, self, {
                startAnimation = 4,
                finalAnimation = 7,
                incline = 315,
                velocity = 200
            })
            dash(dt, self, {
                startAnimation = 13,
                finalAnimation = 15,
                incline = 270,
                velocity = 100
            })
            dash(dt, self, {
                startAnimation = 37,
                finalAnimation = 39,
                incline = 90
            })
            dash(dt, self, {
                startAnimation = 40,
                finalAnimation = 43,
                incline = 270
            })
        end,
        ['special_2']  = function(dt, self)
            if (self.animation.currentFrame > 51 and self.y > self.map.floor) or self.animation.ending then
                self.inAir = false
                self.state = 'idle'
                self.animation.currentFrame = 1

            elseif self.animation.currentFrame == 29 and self.animation.changing then
                self.inAir = false
            end
            dash(dt, self, {
                finalAnimation = 12,
                incline = 90,
                velocity = 100
            })
            dash(dt, self, {
                startAnimation = 13,
                finalAnimation = 14,
                incline = 315
            })
            dash(dt, self, {
                startAnimation = 22,
                finalAnimation = 23,
                incline = 345
            })
            dash(dt, self, {
                startAnimation = 26,
                finalAnimation = 28,
                incline = 270
            })
            dash(dt, self, {
                startAnimation = 41,
                finalAnimation = 43,
                incline = 135
            })
            dash(dt, self, {
                startAnimation = 44,
                finalAnimation = 49
            })
            dash(dt, self, {
                startAnimation = 50,
                velocity = 50,
                incline = 270
            })


        end,


        ['cooldown'] = 5

    },

    ['Malin'] = {

        --//________________________ Attributtes ___________________________\\--

        ['armor'] = 15,
        ['damage'] = 10,
        ['punch_range'] = 20,
        ['kick_range'] = 40,
        ['sex'] = 'female',
        ['shootTrigger'] = 3,

        ['animations'] = {
        --//_______________________ Idle and Dance _________________________\\--

            ['idle'] = {{3, 7}},
            ['dancing'] = {{57, 62}, {134, 138}, {531, 544}, {545, 554}},
            ['start'] = {{1352, 1357}},
        --//__________________________ Movement ____________________________\\--

            ['walking'] = {{17, 24}},
            ['running'] = {{71, 77}},
            ['jumping'] = {{32, 40}},
            ['duck'] = {{454, 455}},

        --//__________________________ Damage ______________________________\\--

            -- Punch
            ['punch'] = {{140, 150}, {1486, 1494}},
            ['duck_punch'] = {{158, 164}},
            ['air_punch'] = {{151, 157}},

            -- Kick
            ['kick'] = {{424, 431}, {106, 114}, {165, 168}},
            ['duck_kick'] = {{174, 178}},
            ['air_kick'] = {{243, 251}},

            -- Hurt
            ['fall'] = {{616, 619}},
            ['hurt'] = {{652, 654}},

        --//________________________ End of Game ___________________________\\--


            ['dying'] = {{601, 606}},
            ['waiting'] = {{86, 91}},
            ['winning'] = {{520, 530}, {564, 588}},

        --//_________________________ Specials _____________________________\\--

            ['special_1'] = {{268, 269, 270, 271, 272, 273, 274, 275, 276, 278, 279, 301, 302, 303, 304, 305, 307, 309, 311, 313, 314, 315, 456, 457, 458, 459, 460, 462, 464, 466, 468, 470, 472, 474, 476, 478}},
            ['special_2'] = {{380, 384, 385, 387, 389, 391, 392, 393, 395, 397, 399, 401, 403, 405, 407, 409, 411}},
        --//________________________ Projectiles ____________________________\\--

            ['shoot'] = {{115, 116, 118, 120, 122, 124, 126, 128, 130, 132, 134}},
            ['projectile_1_fly'] = {{123, 125, 127}},
            ['projectile_1_exploded'] = {{999, 1000}},
            ['projectile_1_destroyed'] = {{999, 1000}},

        },
        ['passive'] = function(dt, self)
            self.enemy.specialPoints = self.enemy.specialPoints - 2 * dt
        end,
        ['shoot'] = function(self)
            Projectile{
              player = self,
              type = 'fly',
              number = 1,
              velocity = 400
            }
        end,

        ['special_1'] = function(dt, self)
            self:detectDamage('front', 150)
            dash(dt, self, {
                startAnimation = 12,
                finalAnimation = 14,
                incline = 45
            })
            dash(dt, self, {
                startAnimation = 15,
                finalAnimation = 17,
                incline = 270
            })
            dash(dt, self, {
                startAnimation = 21,
                finalAnimation = 28,
                incline = 135
            })
            dash(dt, self, {
                startAnimation = 32,
                incline = 270
            })
            if self.animation.ending then
                self.inAir = false
                self.state = 'idle'
            end
        end,
        ['special_2']  = function(dt, self)
            dash(dt, self, {
                startAnimation = 2,
                finalAnimation = 7
            })
            dash(dt, self, {
                startAnimation = 8,
                finalAnimation = 15,
                incline = 90
            })
            dash(dt, self, {
                startAnimation = 16,
                finalAnimation = 17,
                incline = 45
            })

            if self.animation.ending then
                self.inAir = false
                self.state = 'idle'

            end


        end,


        ['cooldown'] = 5

    },
    ['Mizuchi'] = {

        --//________________________ Attributtes ___________________________\\--

        ['armor'] = 40,
        ['damage'] = 8,
        ['punch_range'] = 20,
        ['kick_range'] = 30,
        ['sex'] = 'male',
        ['shootTrigger'] = 3,

        ['animations'] = {
        --//_______________________ Idle and Dance _________________________\\--

            ['idle'] = {{0, 9}},
            ['dancing'] = {{14, 17}},
            ['start'] = {{309, 316}},

        --//__________________________ Movement ____________________________\\--

            ['walking'] = {{10, 13}},
            ['running'] = {{441, 443, 445, 447, 449, 451, 453, 455, 457, 459}},
            ['jumping'] = {{113, 116}},
            ['duck'] = {{27, 34}},

        --//__________________________ Damage ______________________________\\--

            -- Punch
            ['punch'] = {{264, 271}},
            ['duck_punch'] = {{125, 138}, {162, 166}},
            ['air_punch'] = {{122, 124}},

            -- Kick
            ['kick'] = {{139, 151}, {152, 159}},
            ['duck_kick'] = {{109, 112}, {162, 172}},
            ['air_kick'] = {{107, 108}},

            -- Hurt
            ['fall'] = {{509, 512}},
            ['hurt'] = {{482, 485}},

        --//________________________ End of Game ___________________________\\--


            ['dying'] = {{461, 465}},
            ['waiting'] = {{466, 469}},
            ['winning'] = {{1444, 1451}},

        --//_________________________ Specials _____________________________\\--

            ['special_1'] = {{476, 481}},
            ['special_2'] = {{173, 230}},
        --//________________________ Projectiles ____________________________\\--

            ['shoot'] = {{74, 79}},
            ['projectile_1_fly'] = {{359, 362}},
            ['projectile_1_exploded'] = {{317, 327}},
            ['projectile_1_destroyed'] = {{999, 1000}},

            ['projectile_2_spawn'] = {{275, 281}},
            ['projectile_2_exploded'] = {{297, 308}},
            ['projectile_2_destroyed'] = {{999, 1000}},


        },
        ['passive'] = function(dt, self)
            if self.health < self.enemy.health then
                self.damage = 15
            else
                self.damage = 8
            end
        end,
        ['shoot'] = function(self)
            Projectile{
              player = self,
              type = 'fly',
              number = 1,
              velocity = 400
            }
        end,

        ['special_1'] = function(dt, self)
            self.health = math.min(100, self.health + dt * 3)
            self.lifebar:updateDimensionsAndColors()
            if self.animation.ending then
                self.state = 'idle'
            end
        end,
        ['special_2']  = function(dt, self)
            if self.animation.ending then
                self.state = 'idle'
            elseif self.animation.currentFrame == 12 and self.animation.changing then
                for i=-1, 1, 2 do
                    Projectile{
                        player = self,
                        number = 2,
                        type = 'spawn',
                        infinity = true,
                        relativeX =-i*100,
                        relativeY = -self.height/2+30,
                        direction = i
                    }
                end
            else
                self.enemy.state = 'hurt'
                self.enemy.health = self.enemy.health - 10 * dt
                self.enemy.lifebar:updateDimensionsAndColors()
            end
        end,


        ['cooldown'] = 5

    },

    ['Momoko'] = {

        --//________________________ Attributtes ___________________________\\--

        ['armor'] = 12,
        ['damage'] = 15,
        ['punch_range'] = 20,
        ['kick_range'] = 50,
        ['sex'] = 'female',
        ['shootTrigger'] = 17,

        ['animations'] = {
        --//_______________________ Idle and Dance _________________________\\--

            ['idle'] = {{0, 14}},
            ['dancing'] = {{147, 152}, {154, 159}, {740, 746}, {1747, 1765}},
            ['special_dance'] = {{1713, 1721}},
            ['start'] = {{1747, 1768}},

        --//__________________________ Movement ____________________________\\--

            ['walking'] = {{15, 28}},
            ['running'] = {{99, 104}},
            ['jumping'] = {{37, 46}, {47, 56}},
            ['duck'] = {{59, 76}},

        --//__________________________ Damage ______________________________\\--

            -- Punch
            ['punch'] = {{218, 226}, {226, 237}, {268, 282}, {428, 443}},
            ['duck_punch'] = {{169, 173}, {589, 597}},
            ['air_punch'] = {{164, 168}, {238, 247}},

            -- Kick
            ['kick'] = {{174, 180}, {188, 194}, {196, 204}},
            ['duck_kick'] = {{215, 217}, {248, 256}, {561, 574}},
            ['air_kick'] = {{211, 214}, {259, 267}},

            -- Hurt
            ['fall'] = {{909, 912}},
            ['hurt'] = {{939, 941}},

        --//________________________ End of Game ___________________________\\--


            ['dying'] = {{896, 901}},
            ['waiting'] = {{922, 923}},
            ['winning'] = {{678, 697}},

        --//_________________________ Specials _____________________________\\--

            ['special_1'] = {{282, 328}},
            ['special_2'] = {{1819, 1834}, {1618, 1636}},
        --//________________________ Projectiles ____________________________\\--

            ['shoot'] = {{470, 492}},
            ['projectile_1_fly'] = {{497, 504}},
            ['projectile_1_exploded'] = {{999, 1000}},
            ['projectile_1_destroyed'] = {{999, 1000}},


        },
        ['passive'] = function(dt, self)
            if self.enemy.name == 'Athena-Asamiya' then
                self.animations['waiting'].animationsTable = generateAnimation(self, {1713, 1720})
                self.animations['waiting'].frames = self.animations['waiting'].animationsTable.frames
                self.animations['waiting'].quads = self.animations['waiting'].animationsTable.quads
                self.enemy.animations['waiting'].animationsTable = generateAnimation(self.enemy, {999, 1000})
                self.enemy.animations['waiting'].frames = self.enemy.animations['waiting'].animationsTable.frames
                self.enemy.animations['waiting'].quads = self.enemy.animations['waiting'].animationsTable.quads


                if self.state == 'winning' or self.enemy.state == 'winning' then
                    self.enemy.state = 'waiting'
                    self.state = 'waiting'
                    self.enemy.x = self.x
                end

            end
            if self.state == 'dancing' or self.state == 'idle' then
                self.specialPoints = math.min(100, self.specialPoints + 5 * dt)

            end
        end,
        ['shoot'] = function(self)
            Projectile{
              player = self,
              type = 'fly',
              number = 1,
              velocity = 300,
              relativeX = 0,
              relativeY = -self.height / 2 + 10
            }
        end,

        ['special_1'] = function(dt, self)
            dash(dt, self, {
                startAnimation = 4,
                finalAnimation = 6,
                velocity = 70
            })
            dash(dt, self, {
                startAnimation = 15,
                finalAnimation = 18,
                velocity = 50,
                incline  = 90
            })
            dash(dt, self, {
                startAnimation = 20,
                finalAnimation = 22,
                velocity = 60,
                incline = 135
            })
            dash(dt, self, {
                startAnimation = 23,
                finalAnimation = 27,
                incline = 280
            })
            if self.animation.ending then
                self.inAir = false
                self.state = 'idle'
            end
        end,
        ['special_2']  = function(dt, self)
            if self.animation.ending then
                self.health = math.min(100, self.health + 20)
                self.armor = self.armor + 10
                self.lifebar:updateDimensionsAndColors()
                self.state = 'idle'
            end
        end,


        ['cooldown'] = 5

    },

    ['Moriya-Minakata'] = {

        --//________________________ Attributtes ___________________________\\--

        ['armor'] = 30,
        ['damage'] = 10,
        ['punch_range'] = 20,
        ['kick_range'] = 30,
        ['sex'] = 'male',
        ['shootTrigger'] = 4,

        ['animations'] = {
        --//_______________________ Idle and Dance _________________________\\--

            ['idle'] = {{0, 20}},
            ['dancing'] = {{285, 290}},
            ['start'] = {{588,602}},

        --//__________________________ Movement ____________________________\\--

            ['walking'] = {{79, 85}},
            ['running'] = {{79, 85}},
            ['jumping'] = {{24, 38}},
            ['duck'] = {{40, 43}},

        --//__________________________ Damage ______________________________\\--

            -- Punch
            ['punch'] = {{132, 133, 1135, 1136, 1137, 143, 144}, {145, 146, 147, 148, 149, 150, 151, 152, 153, 156, 159, 160}, {1205, 1207}, {274, 283}, {252, 253, 254, 255, 256, 257, 1259}},
            ['duck_punch'] = {{172, 180}, {230, 231, 232, 1234, 1235, 1236, 241, 242}},
            ['air_punch'] = {{162, 164}, {219, 220, 1222, 1223, 1224, 229}},

            -- Kick
            ['kick'] = {{181, 192}},
            ['duck_kick'] = {{197, 201}, {246, 251}},
            ['air_kick'] = {{192, 196}, {243, 245}},

            -- Hurt
            ['fall'] = {{662, 665}},
            ['hurt'] = {{679, 680}},

        --//________________________ End of Game ___________________________\\--


            ['dying'] = {{648, 652}},
            ['waiting'] = {{617, 618}},
            ['winning'] = {{588, 609}},

        --//_________________________ Specials _____________________________\\--

            ['special_1'] = {{291, 302}},
            ['special_2'] = {{416, 434}},
        --//________________________ Projectiles ____________________________\\--

            ['shoot'] = {{274, 282}},
            ['projectile_1_spawn'] = {{455, 463}},
            ['projectile_1_exploded'] = {{470, 476}},
            ['projectile_1_destroyed'] = {{999, 1000}},


        },
        ['passive'] = function(dt, self)
            if not self.passiveUpdated then
                self.passiveUpdated = true
                self.speed = 2 * self.speed
            end
        end,
        ['shoot'] = function(self)
            Projectile{
              player = self,
              type = 'spawn',
              number = 1,
              range = 150
            }
        end,

        ['special_1'] = function(dt, self)
            self.enemy.state = 'hurt'
            self.enemy.x = self.enemy.x + self.direction * dt * 200
            if self.animation.ending then
                self.state = 'idle'
            end
        end,
        ['special_2']  = function(dt, self)
            self.damage = 20
            self:detectDamage('around')
            if self.animation.ending then
                self.state = 'idle'
            end
        end,


        ['cooldown'] = 5

    },

    ['Mr-Big'] = {

        --//________________________ Attributtes ___________________________\\--

        ['armor'] = 40,
        ['damage'] = 10,
        ['punch_range'] = 15,
        ['kick_range'] = 40,
        ['sex'] = 'male',
        ['shootTrigger'] = 10,

        ['animations'] = {
        --//_______________________ Idle and Dance _________________________\\--

            ['idle'] = {{0, 3}},
            ['dancing'] = {{355, 357}},
            ['start'] = {{2361, 2364}},

        --//__________________________ Movement ____________________________\\--

            ['walking'] = {{5, 11}},
            ['running'] = {{33, 38}},
            ['jumping'] = {{12, 17}},
            ['duck'] = {{132, 134}},

        --//__________________________ Damage ______________________________\\--

            -- Punch
            ['punch'] = {{61, 70}, {71, 75}, {103, 108}, {110, 123}},
            ['duck_punch'] = {{127, 134}},
            ['air_punch'] = {{89, 92}, {124, 126}},

            -- Kick
            ['kick'] = {{95, 99}},
            ['duck_kick'] = {{100, 102}, {148, 157}},
            ['air_kick'] = {{172, 174}},

            -- Hurt
            ['fall'] = {{403, 406}},
            ['hurt'] = {{437, 438}},

        --//________________________ End of Game ___________________________\\--


            ['dying'] = {{392, 396}},
            ['waiting'] = {{419, 420}},
            ['winning'] = {{297, 302}},

        --//_________________________ Specials _____________________________\\--

            ['special_1'] = {{374, 375, 376, 377, 378, 379, 380, 381, 2361, 2361, 2361,2362, 2362, 2362, 2363}},
            ['special_2'] = {{224, 270}},
        --//________________________ Projectiles ____________________________\\--

            ['shoot'] = {{175, 188}},
            ['projectile_1_spawn'] = {{212, 223}},
            ['projectile_1_exploded'] = {{220, 223}},
            ['projectile_1_destroyed'] = {{999, 1000}},

            ['projectile_4_fly'] = {{335, 342}},
            ['projectile_4_exploded'] = {{999, 999}},
            ['projectile_4_destroyed'] = {{999, 1000}},

            ['projectile_2_fly'] = {{343, 351}},
            ['projectile_2_exploded'] = {{999, 999}},
            ['projectile_2_destroyed'] = {{999, 1000}},


        },
        ['passive'] = function(dt, self)
            if not self.passiveUpdated then
                self.specialPoints = 20
                self.passiveUpdated = true
            end
        end,
        ['shoot'] = function(self)
            Projectile{
              player = self,
              type = 'spawn',
              number = 1,
              range = 100
            }
        end,

        ['special_1'] = function(dt, self)

            if self.animation.ending then
                self.specialPoints = self.specialPoints + 20
                self.state = 'idle'
            elseif self.animation.currentFrame == 2 and self.animation.changing then
                self.projectiles = {}
                self.numberOfProjectiles = 0
                for i=-1, 1, 2 do
                    Projectile{
                        player = self,
                        number = i+3,
                        direction = -i * -self.direction,
                        type = 'fly',
                        relativeX = -self.direction * i*200,
                        infinity = true,
                        velocity = -70,
                        damage = 0

                    }
                end
            elseif self.animation.currentFrame == 7 and self.animation.changing then
                if self.projectiles[1].x >= self.x or self.projectiles[2].x <= self.x + self.width then
                    self.projectiles = {}
                    self.numberOfProjectiles = 0
                    self.animation.currentFrame = 8
                else

                    self.animation.currentFrame = 3
                end

            end
        end,
        ['special_2']  = function(dt, self)
            dash(dt, self, {
                startAnimation = 4,
                finalAnimation = 11,
                velocity = 50
            })
            dash(dt, self, {
                startAnimation = 37,
                finalAnimation = 40,
                velocity = self.speed
            })
            dash(dt, self, {
                startAnimation = 43,
                velocity = 50,
                incline = 90
            })
            self:detectDamage('front')
            if self.animation.ending then
                self.state = 'jumping'
                self.specialPoints = 20

            end
        end,


       ['cooldown'] = 5

   },

    ['Mudman'] = {

        --//________________________ Attributtes ___________________________\\--

        ['armor'] = 30,
        ['damage'] = 10,
        ['punch_range'] = 20,
        ['kick_range'] = 40,
        ['sex'] = 'male',
        ['shootTrigger'] = 5,

        ['animations'] = {
        --//_______________________ Idle and Dance _________________________\\--

            ['idle'] = {{0, 3}},
            ['dancing'] = {{593, 602}},
            ['start'] = {{556, 587}},

        --//__________________________ Movement ____________________________\\--

            ['walking'] = {{35, 40}},
            ['running'] = {{360, 375}},
            ['jumping'] = {{12, 22}},
            ['duck'] = {{6, 11}},

        --//__________________________ Damage ______________________________\\--

            -- Punch
            ['punch'] = {{75, 87}},
            ['duck_punch'] = {{93, 97}},
            ['air_punch'] = {{69, 73}},

            -- Kick
            ['kick'] = {{98, 102}},
            ['duck_kick'] = {{104, 111}, {203, 208}},
            ['air_kick'] = {{185, 191}},

            -- Hurt
            ['fall'] = {{633, 636}},
            ['hurt'] = {{64, 67}},

        --//________________________ End of Game ___________________________\\--


            ['dying'] = {{619, 624}},
            ['waiting'] = {{49, 51}},
            ['winning'] = {{249, 254}},

        --//_________________________ Specials _____________________________\\--

            ['special_1'] = {{1397, 1402}},
            ['special_2'] = {{1467, 1479}},
        --//________________________ Projectiles ____________________________\\--

            ['shoot'] = {{112, 123}},
            ['projectile_1_fly'] = {{268, 278}},
            ['projectile_1_exploded'] = {{280, 295}},
            ['projectile_1_destroyed'] = {{999, 1000}},

            ['projectile_2_spawn'] = {{411, 442}},
            ['projectile_2_exploded'] = {{442, 460}},
            ['projectile_2_destroyed'] = {{999, 1000}},

            ['projectile_3_spawn'] = {{502, 509}},
            ['projectile_3_exploded'] = {{510, 522}},
            ['projectile_3_destroyed'] = {{999, 1000}},


        },
        ['passive'] = function(dt, self)
            if self.state == 'hurt' then
                self.enemy.animation.currentFrame = 1
                self.enemy.state = 'hurt'
            end
        end,
        ['shoot'] = function(self)
            Projectile{
              player = self,
              type = 'fly',
              number = 1,
              velocity = 400
            }
        end,

        ['special_1'] = function(dt, self)
            if self.animation.ending then
                self.state = 'idle'
                Projectile{
                    player = self,
                    number = 2,
                    type = 'spawn',
                    explode = false



                }
            end

        end,
        ['special_2']  = function(dt, self)
            if self.animation.ending then
                self.state = 'idle'

            elseif self.animation.currentFrame == 2 and self.animation.changing then
                projectile = Projectile{
                    player = self,
                    type = 'spawn',
                    number = 3,
                    range = self.direction * (self.x - self.enemy.x),
                    relativeY = self.enemy.height - 300,
                    explode = false,
                    damage = 50,
                    infinity = true

                }
                projectile.explodeAtEnemy = false

            end
        end,


        ['cooldown'] = 5

    },

    ['Oswald'] = {

        --//________________________ Attributtes ___________________________\\--

        ['armor'] = 20,
        ['damage'] = 10,
        ['punch_range'] = 20,
        ['kick_range'] = 40,
        ['sex'] = 'male',
        ['shootTrigger'] = 2,
        ['projectile'] = false,

        ['animations'] = {
        --//_______________________ Idle and Dance _________________________\\--

            ['idle'] = {{0, 32}},
            ['dancing'] = {{125, 133}, {654, 670}, {671, 682}, {734, 753}},
            ['start'] = {{734, 751}},

        --//__________________________ Movement ____________________________\\--

            ['walking'] = {{33, 62}},
            ['running'] = {{431, 437}},
            ['jumping'] = {{78, 85}},
            ['duck'] = {{94, 96}, {110, 114}, {116, 121}},

        --//__________________________ Damage ______________________________\\--

            -- Punch
            ['punch'] = {{216, 217, 218, 220, 221, 222, 223}, {224, 225, 227, 229, 230, 231, 232, 233}},
            ['duck_punch'] = {{184, 185, 187, 188}, {194, 196, 197}, {244, 247}},
            ['air_punch'] = {{235, 236, 237, 238, 240, 241, 242, 243}},

            -- Kick
            ['kick'] = {{201, 205}},
            ['duck_kick'] = {{211, 215}},
            ['air_kick'] = {{206, 209}},

            -- Hurt
            ['fall'] = {{793, 796}},
            ['hurt'] = {{829, 831}},

        --//________________________ End of Game ___________________________\\--


            ['dying'] = {{777, 782}},
            ['waiting'] = {{811, 813}},
            ['winning'] = {{308, 318}, {710, 730}},

        --//_________________________ Specials _____________________________\\--

            ['special_1'] = {{508, 516}},
            ['special_2'] = {{575, 586}},
        --//________________________ Projectiles ____________________________\\--

            ['shoot'] = {{326, 329}},
            ['projectile_1_fly'] = {{320, 324}},
            ['projectile_1_exploded'] = {{383, 384}},
            ['projectile_1_destroyed'] = {{999, 1000}},

            ['projectile_2_spawn'] = {{588, 594}},
            ['projectile_2_exploded'] = {{595, 601}},
            ['projectile_2_destroyed'] = {{999, 1000}},



        },
        ['passive'] = function(dt, self)
            self.enemy.specialPoints = math.max(0, self.enemy.specialPoints - dt)
            if Characters[self.name]['projectile'] then
                if self.x > projectile.x and self.x < projectile.x + projectile.size * 2 then
                    self.armor = 100
                else
                    self.armor = 30
                end
            end

        end,
        ['shoot'] = function(self)
            Projectile{
              player = self,
              type = 'fly',
              number = 1,
              velocity = 400
            }
        end,

        ['special_1'] = function(dt, self)
            if self.animation.ending then
                self.state = 'idle'
                self.enemy.lifebar:updateDimensionsAndColors()
            elseif self.animation.currentFrame >= 6 then
                self.enemy.x = self.enemy.x + self.direction * 200 * dt
                self.enemy.state = 'hurt'
                self.enemy.health = self.enemy.health - 10 * dt
            end

        end,
        ['special_2']  = function(dt, self)
            if self.animation.ending then
                self.state = 'idle'
            elseif self.animation.currentFrame == 8 and self.animation.changing then
                local projectile = Projectile{
                    player = self,
                    number = 2,
                    type = 'spawn',
                    infinity = true,
                    range = self.direction * 10,
                    relativeY = -self.height / 2 - 20
                }
                projectile.explodeAtEnemy = false
            end
        end,


        ['cooldown'] = 5

    },

    ['Ralf-Jones'] = {

        --//________________________ Attributtes ___________________________\\--

        ['armor'] = 40,
        ['damage'] = 7,
        ['punch_range'] = 20,
        ['kick_range'] = 30,
        ['sex'] = 'male',
        ['shootTrigger'] = 1,

        ['animations'] = {
        --//_______________________ Idle and Dance _________________________\\--

            ['idle'] = {{1, 3}},
            ['dancing'] = {{322, 332}},
            ['start'] = {{413, 415}},

        --//__________________________ Movement ____________________________\\--

            ['walking'] = {{18, 25}},
            ['running'] = {{53, 62}},
            ['jumping'] = {{26, 36}},
            ['duck'] = {{142, 145}},

        --//__________________________ Damage ______________________________\\--

            -- Punch
            ['punch'] = {{85, 92}},
            ['duck_punch'] = {{115, 117}},
            ['air_punch'] = {{135, 139}},

            -- Kick
            ['kick'] = {{118, 122}, {152, 156}},
            ['duck_kick'] = {{124, 127}, {163, 167}},
            ['air_kick'] = {{168, 170}},

            -- Hurt
            ['fall'] = {{381, 384}},
            ['hurt'] = {{419, 421}},

        --//________________________ End of Game ___________________________\\--


            ['dying'] = {{365, 370}},
            ['waiting'] = {{397, 401}},
            ['winning'] = {{346, 351}},

        --//_________________________ Specials _____________________________\\--

            ['special_1'] = {{199, 207}},
            ['special_2'] = {{270, 285}},
        --//________________________ Projectiles ____________________________\\--

            ['shoot'] = {{224, 245}},


        },
        ['passive'] = function(dt, self)
            if self.state == 'jumping' then
                self:detectDamage('around')
            end
        end,
        ['shoot'] = function(self)
            self.damage = 20
            self:detectDamage('front')
        end,

        ['special_1'] = function(dt, self)
            dash(dt, self, {
                startAnimation = 2,
                finalAnimation = 5,
                incline = 90,

            })
            dash(dt, self, {
                startAnimation = 6,
                finalAnimation = 8,
                incline = 310
            })
            if self.animation.ending then
                self.state = 'fall'
            end
        end,
        ['special_2']  = function(dt, self)
            dash(dt, self, {
                startAnimation = 11,
                finalAnimation = 18,
                damage = 100
            })
        end,


        ['cooldown'] = 5

    },
    ['Shen-Woo'] = {

        --//________________________ Attributtes ___________________________\\--

        ['armor'] = 20,
        ['damage'] = 10,
        ['punch_range'] = 20,
        ['kick_range'] = 30,
        ['sex'] = 'male',
        ['shootTrigger'] = 3,

        ['animations'] = {
        --//_______________________ Idle and Dance _________________________\\--

            ['idle'] = {{0, 17}},
            ['dancing'] = {{441, 455}, {456, 466}, {467, 479}, {482, 500}},
            ['start'] = {{419, 440}},

        --//__________________________ Movement ____________________________\\--

            ['walking'] = {{18, 26}},
            ['running'] = {{62, 69}},
            ['jumping'] = {{36, 42}},
            ['duck'] = {{46, 47}},

        --//__________________________ Damage ______________________________\\--

            -- Punch
            ['punch'] = {{101, 104}, {109, 115}},
            ['duck_punch'] = {{139, 142}},
            ['air_punch'] = {{132, 137}, {185, 190}},

            -- Kick
            ['kick'] = {{143, 154}, {209, 222}},
            ['duck_kick'] = {{160, 163}, {230, 235}},
            ['air_kick'] = {{155, 159}},

            -- Hurt
            ['fall'] = {{553, 556}},
            ['hurt'] = {{528, 531}},

        --//________________________ End of Game ___________________________\\--


            ['dying'] = {{541, 546}},
            ['waiting'] = {{87, 90}},
            ['winning'] = {{165, 169}, {505, 518}},

        --//_________________________ Specials _____________________________\\--

            ['special_1'] = {{173, 184}},
            ['special_2'] = {{403, 429}},
        --//________________________ Projectiles ____________________________\\--

            ['shoot'] = {{243, 255}},
            ['projectile_1_fly'] = {{330, 333}},
            ['projectile_1_exploded'] = {{336, 345}},
            ['projectile_1_destroyed'] = {{999, 1000}},


        },
        ['passive'] = function(dt, self)
            if self.state == 'hurt' then
                self.damage = self.damage + 2 * dt
            end

        end,
        ['shoot'] = function(self)
            Projectile{
              player = self,
              type = 'fly',
              number = 1,
              velocity = 400
            }
        end,

        ['special_1'] = function(dt, self)
            self:detectDamage('front', 30)
            if self.animation.ending then
                self.state = 'idle'
            end
        end,
        ['special_2']  = function(dt, self)
            if self.animation.ending then
                self.state = 'idle'
            elseif self.animation.currentFrame > 6 then
                self:detectDamage('around', 200)
            end
        end,


        ['cooldown'] = 5

    },
    ['Shermie'] = {

        --//________________________ Attributtes ___________________________\\--

        ['armor'] = 20,
        ['damage'] = 12,
        ['punch_range'] = 30,
        ['kick_range'] = 50,
        ['sex'] = 'female',
        ['shootTrigger'] = 4,

        ['animations'] = {
        --//_______________________ Idle and Dance _________________________\\--

            ['idle'] = {{0, 41}},
            ['dancing'] = {{534, 545}, {546, 554}, {614, 649}},
            ['start'] = {{597, 607}},

        --//__________________________ Movement ____________________________\\--

            ['walking'] = {{42, 65}},
            ['running'] = {{100, 106}},
            ['jumping'] = {{66, 79}},
            ['duck'] = {{531, 533}},

        --//__________________________ Damage ______________________________\\--

            -- Punch
            ['punch'] = {{146, 151}},
            ['duck_punch'] = {{159, 164}},
            ['air_punch'] = {{152, 157}},

            -- Kick
            ['kick'] = {{135, 145}, {220, 228}},
            ['duck_kick'] = {{178, 184}, {230, 232}},
            ['air_kick'] = {{174, 177}, {238, 240}},

            -- Hurt
            ['fall'] = {{674, 677}},
            ['hurt'] = {{650, 653}},

        --//________________________ End of Game ___________________________\\--


            ['dying'] = {{663, 666}},
            ['waiting'] = {{593, 596}},
            ['winning'] = {{549, 587}},

        --//_________________________ Specials _____________________________\\--

            ['special_1'] = {{284, 285, 286, 287, 288, 289, 292, 293, 295, 297, 299, 301, 302, 303, 304}},
            ['special_2'] = {{364, 365, 366, 367, 368, 389, 390, 412, 413, 414, 415, 416, 417, 418, 419, 420, 421, 422, 424, 426, 428, 430, 432, 434, 436, 437, 438, 439, 440, 441, 442, 443, 444, 445, 446, 447, 448, 449, 450}},
        --//________________________ Projectiles ____________________________\\--

            ['shoot'] = {{185, 206}},
            ['projectile_1_fly'] = {{517, 519, 521, 522, 524, 525}},
            ['projectile_1_exploded'] = {{279, 283}},
            ['projectile_1_destroyed'] = {{999, 1000}},


        },
        ['passive'] = function(dt, self)
            if self.specialPoints >= 50 then
                self.damage = 16
            else
                self.damage = 12
            end
        end,
        ['shoot'] = function(self)
            Projectile{
              player = self,
              type = 'fly',
              number = 1,
              velocity = 400
            }
        end,

        ['special_1'] = function(dt, self)
            if self.animation.ending then
                self.state = 'idle'
            elseif self.animation.currentFrame == 6 and self.animation.changing then
                self.health = math.min(100, self.health + 10)
                self.enemy.health = self.enemy.health - 10
                self.enemy.state = 'hurt'
                self.lifebar:updateDimensionsAndColors()
                self.enemy.lifebar:updateDimensionsAndColors()
            end

        end,
        ['special_2']  = function(dt, self)
            dash(dt, self, {
                finalAnimation = 9,
                incline = 135
            })
            dash(dt, self, {
                startAnimation = 10,
                finalAnimation = 19,
                incline = 270,
                velocity = 50
            })
            dash(dt, self, {
                startAnimation = 30,
                finalAnimation = 37,
                incline = 180
            })
            if self.animation.ending then
                self.state = 'idle'
            elseif self.animation.currentFrame == 38 then
                self.inAir = false
                self.y = self.map.floor - self.currentFrame:getHeight()
            end
        end,


        ['cooldown'] = 5

    },

    ['Shiki'] = {

        --//________________________ Attributtes ___________________________\\--

        ['armor'] = 15,
        ['damage'] = 15,
        ['punch_range'] = 30,
        ['kick_range'] = 50,
        ['sex'] = 'female',
        ['shootTrigger'] = 4,

        ['animations'] = {
        --//_______________________ Idle and Dance _________________________\\--

            ['idle'] = {{0, 17}},
            ['dancing'] = {{475, 483}, {492, 498}},
            ['start'] = {{492, 498}},

        --//__________________________ Movement ____________________________\\--

            ['walking'] = {{18, 41}},
            ['running'] = {{98, 105}},
            ['jumping'] = {{42, 54}},
            ['duck'] = {{69, 71}},

    --    --//__________________________ Damage ______________________________\\--

            -- Punch
            ['punch'] = {{147, 154}, {154, 161}, {161, 173}, {196, 205}},
            ['duck_punch'] = {{180, 188}, {212, 221}},
            ['air_punch'] = {{174, 179}, {206, 211}},

            -- Kick
            ['kick'] = {{270, 284}, {285, 299}},
            ['duck_kick'] = {{306, 314}},
            ['air_kick'] = {{300, 305}},

            -- Hurt
            ['fall'] = {{526, 529}},
            ['hurt'] = {{499, 507}},

        --//________________________ End of Game ___________________________\\--


            ['dying'] = {{512, 517}},
            ['waiting'] = {{127, 129}},
            ['winning'] = {{463, 474}},

        --//_________________________ Specials _____________________________\\--

            ['special_1'] = {{222, 270}},
            ['special_2'] = {{315, 376}},
        --//________________________ Projectiles ____________________________\\--

            ['shoot'] = {{381, 423}},
            ['projectile_1_fly'] = {{377, 380}},
            ['projectile_1_exploded'] = {{440, 457}},
            ['projectile_1_destroyed'] = {{999, 1000}},


        },
        ['passive'] = function(dt, self)
            if self.enemy.state == 'hurt' then
                self.enemy.x = self.enemy.x - self.direction * dt
            end
        end,
        ['shoot'] = function(self)
            for i=-2, 2 do
                 Projectile{
                    player = self,
                    type = 'fly',
                    number = 1,
                    velocity = 400,
                    relativeY = -self.height/4 + i*20
                }
            end
        end,

        ['special_1'] = function(dt, self)
            dash(dt, self, {
                startAnimation = 26,
                finalAnimation = 28,
                incline = 90
            })
            dash(dt, self, {
                startAnimation = 34,
                finalAnimation = 39

            })
            self:detectDamage('around', 70)
            if self.animation.ending then
                self.state = 'jumping'
            end
        end,
        ['special_2']  = function(dt, self)
            dash(dt, self, {
                startAnimation = 24,
                finalAnimation = 31,
                velocity = 75,
                incline = 90
            })
            dash(dt, self, {
                startAnimation = 32,
                finalAnimation = 34
            })
            dash(dt, self, {
                startAnimation = 43,
                finalAnimation = 48,
                incline = 270
            })
            if self.animation.ending then
                self.state = 'idle'
            elseif self.animation.currentFrame == 49 then
                self.inAir = false
            end
            self:detectDamage('around', 100)
        end,


        ['cooldown'] = 5

    },

    ['Shion'] = {

        --//________________________ Attributtes ___________________________\\--

        ['armor'] = 15,
        ['damage'] = 8,
        ['punch_range'] = 80,
        ['kick_range'] = 50,
        ['sex'] = 'female',
        ['shootTrigger'] = 14,
        ['spear'] = false,

        ['animations'] = {
        --//_______________________ Idle and Dance _________________________\\--

            ['idle'] = {{0, 7}, {543, 546}},
            ['dancing'] = {{343, 371}, {714, 723}},
            ['start'] = {{785, 787}, {785, 787}},

        --//__________________________ Movement ____________________________\\--

            ['walking'] = {{8, 15}, {547, 554}},
            ['running'] = {{79, 84}, {562, 567}},
            ['jumping'] = {{31, 36}, {527, 535}},
            ['duck'] = {{65, 67}, {537, 540}},

        --//__________________________ Damage ______________________________\\--

            -- Punch
            ['punch'] = {{204, 216}, {597, 629}},
            ['duck_punch'] = {{187, 192}, {555, 558}},
            ['air_punch'] = {{335, 338}, {569, 575}},

            -- Kick
            ['kick'] = {{194, 203}, {684, 698}},
            ['duck_kick'] = {{159, 163}, {242, 248}},
            ['air_kick'] = {{155, 157}, {595, 599}},

            -- Hurt
            ['fall'] = {{755, 758}, {634, 641}},
            ['hurt'] = {{740, 743}, {785, 787}},

        --//________________________ End of Game ___________________________\\--


            ['dying'] = {{745, 749}, {745, 749}},
            ['waiting'] = {{771, 775}, {727, 730}},
            ['winning'] = {{232, 240}, {731, 733}},

        --//_________________________ Specials _____________________________\\--

            ['special_1'] = {{292, 301}, {580, 589}},
            ['special_2'] = {{407, 421}, {374, 397}},
        --//________________________ Projectiles ____________________________\\--

            ['shoot'] = {{124, 138}, {640, 655}},
            ['projectile_1_fly'] = {{496, 498}},
            ['projectile_1_exploded'] = {{499, 500}},
            ['projectile_1_destroyed'] = {{999, 1000}},


        },
        ['passive'] = function(dt, self)
            self.shuffle = false
            self.specialPoints = 100
            for state, animation in pairs(self.animations)  do
                if Characters['Shion']['spear'] then
                    animation.animationsTable = animation.animations[2]
                    animation.frames = animation.animationsTable.frames
                    animation.quads = animation.animationsTable.quads
                else
                    animation.animationsTable = animation.animations[1]
                    animation.frames = animation.animationsTable.frames
                    animation.quads = animation.animationsTable.quads
                end

            end



        end,
        ['shoot'] = function(self)
           Projectile{
              player = self,
              type = 'fly',
              number = 1,
              velocity = 400
            }
        end,

        ['special_1'] = function(dt, self)
            if self.animation.ending then
                self.state = 'idle'
            end
            dash(dt, self, {
                startAnimation = 2,
                finalAnimation = 7,
                incline = 180
            })
        end,
        ['special_2']  = function(dt, self)
            if self.animation.ending then
                if Characters['Shion']['spear'] then
                    Characters['Shion']['spear'] = false
                    self.damage = 15
                    self.range = 50
                else
                    Characters['Shion']['spear'] = true
                    self.damage = 10
                    self.range = 100
                end
                self.state = 'idle'
                for k, animation in pairs(self.animations) do
                    animation.currentFrame = 1
                end

            end
        end,


        ['cooldown'] = 5

    },

    ['Tung-Fu-Rue'] = {

        --//________________________ Attributtes ___________________________\\--

        ['armor'] = 20,
        ['damage'] = 25,
        ['punch_range'] = 15,
        ['kick_range'] = 20,
        ['sex'] = 'male',
        ['shootTrigger'] = 4,

        ['animations'] = {
        --//_______________________ Idle and Dance _________________________\\--

            ['idle'] = {{0, 5}},
            ['dancing'] = {{139, 144}, {493, 501}, {506, 525}, {526, 539}},
            ['start'] = {{506, 526}},

        --//__________________________ Movement ____________________________\\--

            ['walking'] = {{13, 19}},
            ['running'] = {{79, 84}},
            ['jumping'] = {{43, 52}},
            ['duck'] = {{1056, 1059}},

        --//__________________________ Damage ______________________________\\--

            -- Punch
            ['punch'] = {{128, 136}, {146, 153}},
            ['duck_punch'] = {{158, 159}, {192, 199}},
            ['air_punch'] = {{154, 157}, {185, 191}},

            -- Kick
            ['kick'] = {{160, 169}, {200, 207}},
            ['duck_kick'] = {{177, 183}, {230, 238}},
            ['air_kick'] = {{170, 176}, {220, 225}},

            -- Hurt
            ['fall'] = {{570, 574}},
            ['hurt'] = {{549, 553}},

        --//________________________ End of Game ___________________________\\--


            ['dying'] = {{554, 559}},
            ['waiting'] = {{588, 591}},
            ['winning'] = {{487, 492}},

        --//_________________________ Specials _____________________________\\--

            ['special_1'] = {{344, 355}},
            ['special_2'] = {{372, 437}},
        --//________________________ Projectiles ____________________________\\--

            ['shoot'] = {{1240, 1244}},
            ['projectile_1_fly'] = {{250, 251}},
            ['projectile_1_exploded'] = {{264, 269}},
            ['projectile_1_destroyed'] = {{999, 1000}},

            ['projectile_2_spawn'] = {{356, 370}},
            ['projectile_2_exploded'] = {{264, 269}},
            ['projectile_2_destroyed'] = {{999, 1000}},

            ['projectile_3_spawn'] = {{356, 370}},
            ['projectile_3_exploded'] = {{439, 443}},
            ['projectile_3_destroyed'] = {{999, 1000}},


        },
        ['passive'] = function(dt, self)
            if self.state == 'punch' then
                self.specialPoints = self.specialPoints + dt
            end
        end,
        ['shoot'] = function(self)
            Projectile{
              player = self,
              type = 'fly',
              number = 1,
              velocity = 400
            }
        end,

        ['special_1'] = function(dt, self)
            if self.animation.ending then
                self.state = 'idle'
            elseif self.animation.currentFrame == 4 and self.animation.changing then
                Projectile{
                    player = self,
                    type = 'spawn',
                    number = 2,
                    range = 100
                }
            end
        end,
        ['special_2']  = function(dt, self)
            if self.animation.ending then
                self.state = 'idle'
            elseif self.animation.currentFrame == 58 and self.animation.changing then
                Projectile{
                    player = self,
                    type = 'spawn',
                    number= 3,
                    range = self.direction * (self.x - self.enemy.x),
                    damage = 40

                }
            end
        end,


        ['cooldown'] = 5

    },

    ['Vanessa'] = {

        --//________________________ Attributtes ___________________________\\--

        ['armor'] = 20,
        ['damage'] = 12,
        ['punch_range'] = 20,
        ['kick_range'] = 50,
        ['sex'] = 'female',
        ['shootTrigger'] = 3,

        ['animations'] = {
        --//_______________________ Idle and Dance _________________________\\--

            ['idle'] = {{0, 21}},
            ['dancing'] = {{519, 536}, {546, 552}, {556, 569}, {570, 585}, {603, 611}},
            ['start'] = {{556, 574}},

        --//__________________________ Movement ____________________________\\--

            ['walking'] = {{22, 29}},
            ['running'] = {{73, 78}},
            ['jumping'] = {{38, 49}},
            ['duck'] = {{53, 62}},

        --//__________________________ Damage ______________________________\\--

            -- Punch
            ['punch'] = {{107, 122}, {142, 147}, {157, 166}, {174, 179}, {185, 193}},
            ['duck_punch'] = {{152, 156}, {170, 173}, {235, 244}},
            ['air_punch'] = {{148, 150}, {194, 199}, {229, 233}},

            -- Kick
            ['kick'] = {{123, 131}},
            ['duck_kick'] = {{201, 211}},
            ['air_kick'] = {{248, 251}},

            -- Hurt
            ['fall'] = {{640, 643}},
            ['hurt'] = {{612, 615}},

        --//________________________ End of Game ___________________________\\--


            ['dying'] = {{625, 630}},
            ['waiting'] = {{656, 660}},
            ['winning'] = {{133, 136}, {505, 518}, {537, 544}},

        --//_________________________ Specials _____________________________\\--

            ['special_1'] = {{252, 287}},
            ['special_2'] = {{318, 336}},
        --//________________________ Projectiles ____________________________\\--

            ['shoot'] = {{445, 460}},
            ['projectile_1_fly'] = {{488, 492}},
            ['projectile_1_exploded'] = {{480, 484}},
            ['projectile_1_destroyed'] = {{999, 1000}},


        },
        ['passive'] = function(dt, self)
            if self.state == 'duck' then
                self.specialPoints = self.specialPoints + dt
            end
        end,
        ['shoot'] = function(self)
            Projectile{
              player = self,
              type = 'fly',
              number = 1,
              velocity = 400
            }
        end,

        ['special_1'] = function(dt, self)
            if self.animation.ending then
                self.state = 'idle'
            elseif self.animation.currentFrame == 5 and self.animation.changing then
                self.inAir = false
                self.y = self.map.floor - self.height
            end
            dash(dt, self, {
                startAnimation = 2,
                finalAnimation = 5
            })
            self:detectDamage('around', 40)
        end,
        ['special_2']  = function(dt, self)
            if self.animation.ending then
                self.state = 'idle'
            end
            dash(dt, self, {
                startAnimation = 4,
                finalAnimation = 6
            })
            self:detectDamage('around', 50)
        end,


        ['cooldown'] = 5

    },

    ['Whip'] = {

        --//________________________ Attributtes ___________________________\\--

        ['armor'] = 40,
        ['damage'] = 13,
        ['punch_range'] = 50,
        ['kick_range'] = 40,
        ['sex'] = 'female',
        ['shootTrigger'] = 12,

        ['animations'] = {
        --//_______________________ Idle and Dance _________________________\\--

            ['idle'] = {{0, 24}},
            ['dancing'] = {{413, 421}, {706, 724}, {725, 735}, {741, 768}},
            ['start'] = {{741, 776}},

        --//__________________________ Movement ____________________________\\--

            ['walking'] = {{25, 30}},
            ['running'] = {{111, 118}},
            ['jumping'] = {{55, 62}, {63, 68}, {69, 78}},
            ['duck'] = {{80, 89}},

        --//__________________________ Damage ______________________________\\--

            -- Punch
            ['punch'] = {{167, 180}, {234, 252}},
            ['duck_punch'] = {{199, 211}},
            ['air_punch'] = {{182, 192}, {193, 198}, {255, 258}, {266, 278}},

            -- Kick
            ['kick'] = {{212, 221}},
            ['duck_kick'] = {{226, 233}},
            ['air_kick'] = {{222, 225}},

            -- Hurt
            ['fall'] = {{810, 813}},
            ['hurt'] = {{783, 786}},

        --//________________________ End of Game ___________________________\\--


            ['dying'] = {{805, 807}},
            ['waiting'] = {{131, 133}},
            ['winning'] = {{769, 776}, {391, 393}},

        --//_________________________ Specials _____________________________\\--

            ['special_1'] = {{395, 397, 399, 408, 408, 408, 408, 409, 409, 409}},
            ['special_2'] = {{584, 621}},
        --//________________________ Projectiles ____________________________\\--

            ['shoot'] = {{504, 521}},
            ['projectile_1_spawn'] = {{536, 548}},
            ['projectile_1_exploded'] = {{536, 548}},
            ['projectile_1_destroyed'] = {{999, 1000}},

            ['projectile_2_spawn'] = {{396, 398, 400, 401, 402, 403, 404, 405, 406, 407}},
            ['projectile_2_exploded'] = {{536, 548}},
            ['projectile_2_destroyed'] = {{999, 1000}},

            ['projectile_3_spawn'] = {{396, 398, 400, 401, 402, 403, 404, 405, 406, 407}},
            ['projectile_3_exploded'] = {{622, 629}},
            ['projectile_3_destroyed'] = {{999, 1000}},


        },
        ['passive'] = function(dt, self)
            if self.enemy.state == 'hurt' then
                if self.timer <= 5 then
                    self.timer = self.timer + dt
                    self.enemy.health = self.enemy.health - 5 * dt
                    self.enemy.lifebar:updateDimensionsAndColors()
                end
            end
        end,
        ['shoot'] = function(self)
            local projectile = Projectile{
              player = self,
              type = 'spawn',
              number = 1,
              range = 150,
              relativeY = self.height / 2 - 50
            }
            projectile.explodeAtEnemy = false
        end,

        ['special_1'] = function(dt, self)
            if self.animation.currentFrame == 1 and self.animation.changing then
                Projectile{
                    player = self,
                    number = 2,
                    type = 'spawn',
                    infinity = true
                }
            elseif self.animation.ending then
                self.state = 'idle'
                self.projectiles = {}
                self.numberOfProjectiles = 0
            end
            dash(dt, self, {
                startAnimation = 2,
                velocity = 100
            })

        end,
        ['special_2']  = function(dt, self)
            if self.animation.ending then
                Projectile{
                    type = 'spawn',
                    player = self,
                    number = 3,
                    range = self.direction * (self.x - self.enemy.x)
                }
                self.state = 'idle'
            end
            self.x = self.x + math.floor(dt * 50)
            self:detectDamage('around', 200)
        end,


        ['cooldown'] = 5

    },

    ['Yuki'] = {

        --//________________________ Attributtes ___________________________\\--

        ['armor'] = 20,
        ['damage'] = 8,
        ['punch_range'] = 20,
        ['kick_range'] = 30,
        ['sex'] = 'male',
        ['shootTrigger'] = 3,
		['powered'] = false,

        ['animations'] = {
        --//_______________________ Idle and Dance _________________________\\--

            ['idle'] = {{1001, 1008}, {1815, 1817}},
            ['dancing'] = {{961, 968}, {1815, 1817}},
            ['start'] = {{1920, 1921, 1922, 1923, 1924, 1925, 1926, 1927, 1928, 1929, 939, 940, 941, 942, 943, 944, 945}, {1920, 1921, 1922, 1923, 1924, 1925, 1926, 1927, 1928, 1929, 939, 940, 941, 942, 943, 944, 945}},

        --//__________________________ Movement ____________________________\\--

            ['walking'] = {{1009, 1018}, {1818, 1823}},
            ['running'] = {{132, 146}, {1818, 1823}},
            ['jumping'] = {{54, 58}, {1824, 1827}},
            ['duck'] = {{1083, 1085}, {1815, 1817}},

        --//__________________________ Damage ______________________________\\--

            -- Punch
            ['punch'] = {{1202, 1208}, {1828, 1829}},
            ['duck_punch'] = {{1245, 1246}, {1831, 1831, 1831}},
            ['air_punch'] = {{1236, 1237}, {1824, 1827}},

            -- Kick
            ['kick'] = {{1262, 1267}, {1828, 1830}},
            ['duck_kick'] = {{1268, 1270}, {1831, 1831, 1831}},
            ['air_kick'] = {{507, 518}, {1824, 1827}},

            -- Hurt
            ['fall'] = {{991, 994}, {991, 994}},
            ['hurt'] = {{969, 972}, {1815, 1817}},

        --//________________________ End of Game ___________________________\\--


            ['dying'] = {{977, 981}, {977, 981}},
            ['waiting'] = {{903, 910}, {903, 910}},
            ['winning'] = {{945, 950}, {945, 950}},

        --//_________________________ Specials _____________________________\\--

            ['special_1'] = {{763, 780}, {1815, 1817}},
            ['special_2'] = {{801,813}, {853, 855}},
        --//________________________ Projectiles ____________________________\\--

            ['shoot'] = {{1287, 1291}, {1648, 1648, 1648}},
            ['projectile_1_fly'] = {{581, 613}},
            ['projectile_1_exploded'] = {{560, 576}},
            ['projectile_1_destroyed'] = {{576, 576, 576}},


        },
        ['passive'] = function(dt, self)
	        self.shuffle = false
            for state, animation in pairs(self.animations)  do
                if Characters[self.name]['powered'] then
                    animation.animationsTable = animation.animations[2]
                    animation.frames = animation.animationsTable.frames
                    animation.quads = animation.animationsTable.quads
                else
                    animation.animationsTable = animation.animations[1]
                    animation.frames = animation.animationsTable.frames
                    animation.quads = animation.animationsTable.quads
                end
	    end
		if Characters[self.name]['powered'] then
            self.specialPoints = self.specialPoints + 5 * dt
	    	if self.state == 'hurt' or self.state == 'shoot' or self.state == 'special_1' then
				self.state = 'idle'

			elseif self.state == 'winning' or self.state == 'dying' or self.state == 'shoot' then
				Characters[self.name]['powereded'] = false

			end
			if self.specialPoints >= 100 then
				self.state = 'special_2'
			end
        else
            self.armor = 20
		end




        end,
        ['shoot'] = function(self)
            Projectile{
              player = self,
              type = 'fly',
              number = 1,
              velocity = 400
            }
        end,

        ['special_1'] = function(dt, self)
   			if self.animation.ending then
				self.state = 'idle'
				self.health = math.min(100, self.health + 10)
				self.lifebar:updateDimensionsAndColors()
			end
       	end,
        ['special_2']  = function(dt, self)
			if self.animation.ending then
				self.state = 'idle'
				if Characters[self.name]['powered'] then
					Characters[self.name]['powered'] = false
					self.damage = 12
					self.armor = 20
					self.jumpSpeed =  -400
				else
					Characters[self.name]['powered'] = true
					self.damage = 8
					self.armor = 100
					self.jumpSpeed = -500
				end
                for _, animation in pairs(self.animations) do
                    animation.currentFrame = 1
                end
			end
		end,


        ['cooldown'] = 5

    },
    ['Yuri-Sakazaki'] = {

        --//________________________ Attributtes ___________________________\\--

        ['armor'] = 30,
        ['damage'] = 10,
        ['punch_range'] = 20,
        ['kick_range'] = 40,
        ['sex'] = 'female',
        ['shootTrigger'] = 8,

        ['animations'] = {
        --//_______________________ Idle and Dance _________________________\\--

            ['idle'] = {{0, 5}},
            ['dancing'] = {{400, 405}, {406, 411}, {420, 424}, {508, 522}},
            ['start'] = {{382, 399}},

        --//__________________________ Movement ____________________________\\--

            ['walking'] = {{6, 18}},
            ['running'] = {{46, 56}},
            ['jumping'] = {{19, 26}},
            ['duck'] = {{42, 45}},

        --//__________________________ Damage ______________________________\\--

            -- Punch
            ['punch'] = {{78, 85}, {98, 104}, {125, 134}},
            ['duck_punch'] = {{109, 111}},
            ['air_punch'] = {{105, 108}, {138, 141}},

            -- Kick
            ['kick'] = {{112, 116}, {117, 121}, {150, 162}},
            ['duck_kick'] = {{122, 124}, {168, 175}, {177, 183}},
            ['air_kick'] = {{163, 167}},

            -- Hurt
            ['fall'] = {{461, 464}},
            ['hurt'] = {{433, 436}},

        --//________________________ End of Game ___________________________\\--


            ['dying'] = {{445, 450}, {502, 507}},
            ['waiting'] = {{490, 492}},
            ['winning'] = {{390, 399}, {425, 432}},

        --//_________________________ Specials _____________________________\\--

            ['special_1'] = {{349, 371}},
            ['special_2'] = {{176, 257}},
        --//________________________ Projectiles ____________________________\\--

            ['shoot'] = {{257, 267}, {292, 308}},
            ['projectile_1_fly'] = {{280, 283}},
            ['projectile_1_exploded'] = {{284, 291}},
            ['projectile_1_destroyed'] = {{999, 1000}},


        },
        ['passive'] = function(dt, self)
            if not self.passiveUpdated then
                self.passiveUpdated = true
                if self.enemy.sex == 'male' then
                    self.armor = 40
                else
                    self.damage = 12.5
                end
            end
        end,
    ['shoot'] = function(self)
            Projectile{
              player = self,
              type = 'fly',
              number = 1,
              velocity = 400
            }
        end,

        ['special_1'] = function(dt, self)
            if self.animation.ending then
                self.state = 'idle'
            end
            dash(dt, self, {
                startAnimation = 3,
                finalAnimation = 6,
                incline = 90
            })
            dash(dt, self, {
                startAnimation = 16,
                finalAnimation = 21,
                incline = 270
            })
            self:detectDamage('down')
        end,
        ['special_2']  = function(dt, self)
            self.damage = 30
            self:detectDamage('front')
            if self.animation.ending then
                self.state = 'idle'
            end
        end,


        ['cooldown'] = 5

    },
    --['Character'] = {

    --    --//________________________ Attributtes ___________________________\\--

    --    ['armor'] = ,
    --    ['damage'] = ,
    --    ['punch_range'] = ,
    --    ['kick_range'] = ,
    --    ['sex'] = 'sex',
    --    ['shootTrigger'] = ,

    --    ['animations'] = {
    --    --//_______________________ Idle and Dance _________________________\\--

    --        ['idle'] = {{}},
    --        ['dancing'] = {{}},

    --    --//__________________________ Movement ____________________________\\--

    --        ['walking'] = {{}},
    --        ['running'] = {{}},
    --        ['jumping'] = {{}},
    --        ['duck'] = {{}},

    --    --//__________________________ Damage ______________________________\\--

    --        -- Punch
    --        ['punch'] = {{}},
    --        ['duck_punch'] = {{}},
    --        ['air_punch'] = {{}},

    --        -- Kick
    --        ['kick'] = {{}},
    --        ['duck_kick'] = {{}},
    --        ['air_kick'] = {{}},

    --        -- Hurt
    --        ['fall'] = {{}},
    --        ['hurt'] = {{}},

    --    --//________________________ End of Game ___________________________\\--


    --        ['dying'] = {{}},
    --        ['waiting'] = {{}},
    --        ['winning'] = {{}},

    --    --//_________________________ Specials _____________________________\\--

    --        ['special_1'] = {{}},
    --        ['special_2'] = {{}},
    --    --//________________________ Projectiles ____________________________\\--

    --        ['shoot'] = {{}},
    --        ['projectile_1_fly'] = {{}},
    --        ['projectile_1_exploded'] = {{}},
    --        ['projectile_1_destroyed'] = {{999, 1000}},


    --    },
    --    ['passive'] = function(dt, self)

    --    end,
    --    ['shoot'] = function(self)
    --        Projectile{
    --          player = self,
    --          type = 'fly',
    --          number = 1,
    --          velocity = 400
    --        }
    --    end,

    --    ['special_1'] = function(dt, self)
    --
    --    end,
    --    ['special_2']  = function(dt, self)

    --    end,


    --    ['cooldown'] = 5

    --},





}


function dash(dt, self, params)

    --//______________________ The Parameters Table ____________________________\\--
    local params = params or {}
    local startAnimation = params.startAnimation or 0
    local finalAnimation = params.finalAnimation or #self.animation.frames
    local speed = params.velocity or self.speed
    local damage = params.damage or self.damage
    local incline = params.incline or 0

    --\\________________________________________________________________________//--


    if self.animation.currentFrame >= startAnimation and self.animation.currentFrame< finalAnimation then
        self.inAir = true
        self.x = math.floor(self.x - speed * self.direction * dt * math.cos(math.rad(incline)))
        self.y = math.floor(self.y - speed * dt * math.sin(math.rad(incline)))
    end
    if self.animation.ending then
        self.state = 'jumping'
    end
    if self.animation.changing then
        self:detectDamage('around', damage)
    end
end
