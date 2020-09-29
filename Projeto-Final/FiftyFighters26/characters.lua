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
    --['Ai'] = {

    --    --//________________________ Attributtes ___________________________\\--

    --    ['armor'] = 30,
    --    ['damage'] = 10,
    --    ['punch_range'] = 45,
    --    ['kick_range'] = 55,
    --    ['sex'] = 'female',
    --    ['shootTrigger'] = 3,

    --    ['animations'] = {
    --    --//_______________________ Idle and Dance _________________________\\--

    --        ['idle'] = {{0, 7}},
    --        ['dancing'] = {{141, 143}, {470, 474}, {540, 550}, {551, 561}, {561, 566}},

    --    --//__________________________ Movement ____________________________\\--

    --        ['walking'] = {{8, 23}},
    --        ['running'] = {{111, 116}},
    --        ['jumping'] = {{29, 31}},
    --        ['duck'] = {{36, 46}},

    --    --//__________________________ Damage ______________________________\\--

    --        -- Punch
    --        ['punch'] = {{69, 73}, {122, 127}, {211, 215}},
    --        ['duck_punch'] = {{131, 135}, {245, 249}},
    --        ['air_punch'] = {{99, 100}},

    --        -- Kick
    --        ['kick'] = {{135, 138}, {190, 195}},
    --        ['duck_kick'] = {{199, 203}},
    --        ['air_kick'] = {{115, 117}},

    --        -- Hurt
    --        ['fall'] = {{526, 530}},
    --        ['hurt'] = {{559, 560}},

    --    --//________________________ End of Game ___________________________\\--


    --        ['dying'] = {{562, 566}},
    --        ['waiting'] = {{608, 612}},
    --        ['winning'] = {{553, 556}},

    --    --//_________________________ Specials _____________________________\\--

    --        ['special_1'] = {{212, 219}},
    --        ['special_2'] = {{498, 500}},
--    --//________________________ Projectiles ____________________________\\--

    --        ['shoot'] = {{101, 104}, {463, 466}, {483, 491}},
    --        ['projectile_1_fly'] = {{466, 470}},
    --        ['projectile_1_exploded'] = {{198, 207}},
    --        ['projectile_1_destroyed'] = {{999, 1000}},

    --        ['projectile_2_spawn'] = {{338, 339}},
    --        ['projectile_2_exploded'] = {{999, 1000}},
    --        ['projectile_2_destroyed'] = {{999, 1000}},

    --        ['projectile_3_fly'] = {{354, 355}},
    --        ['projectile_3_exploded'] = {{}},
    --        ['projectile_3_destroyed'] = {{999, 1000}}

    --    },
    --    ['passive'] = function(dt, self)
    --        if self.health <= 50 then
    --            self.health = math.floor(self.health + 10 * dt)
    --            self.lifebar:updateDimensionsAndColors()
    --        end
    --    end,
    --    ['shoot'] = function(player)
    --        Projectile{player = player, type = 'fly', number = 1, velocity = 400}
    --    end,

    --    ['special_1'] = function(dt, self)
    --        dash(dt, self)
    --    end,
    --    ['special_2']  = function(dt, self)
    --        if self.animation.currentFrame > 4 and self.animation.currentFrame < 8 then
    --            self.y = math.floor(self.y + 400 * dt)
    --        elseif self.animation.currentFrame > 8 and self.animation.changing and not --self.animation.ending then
    --            self.x = math.floor(self.x + self.velocity /2 * dt * self.direction)
    --            Projectile{
    --                player = self,
    --                type = 'fly',
    --                number = 2,
    --                incline = 270,
    --                velocity = 400
    --            }
    --        else
    --            self.projectiles = {}
    --            self.numberOfProjectiles = 0
    --            self.state = 'jumping'
    --        end

    --    end,


    --    ['cooldown'] = 5

    --},

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
            self.enemy.range = Characters[self.enemy.name]['punch_range'] / 1.5
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
        ['shootTrigger'] = 3,

        ['animations'] = {
        --//_______________________ Idle and Dance _________________________\\--

            ['idle'] = {{0, 6}},
            ['dancing'] = {{94, 100}},

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

        --//__________________________ Movement ____________________________\\--

            ['walking'] = {{17, 24}},
            ['running'] = {{71, 77}},
            ['jumping'] = {{32, 40}},
            ['duck'] = {{454, 455}},

        --//__________________________ Damage ______________________________\\--

            -- Punch
            ['punch'] = {{140, 150}, {1486, 1495}},
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
            ['winning'] = {{309, 316}},

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
            if self.enemy.name == 'Athena' then
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
              velocity = 300
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
                velocity = 50
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

 --['Moriya-Minakata'] = {

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

    local startAnimation = params.startAnimation or 0
    local finalAnimation = params.finalAnimation or #self.animation.frames
    local speed = params.speed or self.speed
    local damage = params.damage or self.damage
    local incline = params.incline or 0

    --\\________________________________________________________________________//--


    if self.animation.currentFrame >= startAnimation and self.animation.currentFrame< finalAnimation then
        self.inAir = true
        self.x = math.floor(self.x - 2 * speed * self.direction * dt * math.cos(math.rad(incline)))
        self.y = math.floor(self.y - 2 * speed * dt * math.sin(math.rad(incline)))
    end
    self:detectDamage('around', damage)
    if self.animation.ending then
        self.state = 'jumping'
    end
end
