# Fifty Fighters - a Game







### Fifty Fighters 0

*The Screen Update*

**Date: September 1st, 2020**

- Creating *main.lua*
- Importing [push](https://github.com/Ulydev/push) library from [Ulydev](https://github.com/Ulydev)
- Initial screen definitions 

### Fifty Fighters 1

*The Background Update*

**Date: September 1st, 2020**

- Creating a Utils script that returns a table with the quads of a sprite sheet
- Defining *love.keypressed*, that quits the game when escape is pressed
- Getting a [background sprite](https://craftpix.net/product/2d-pixel-art-battle-backgrounds/) sheet from [craftpix.net](https://craftpix.net/) 

### Fifty Fighters 2

*The Map Update*

**Date: September 1st, 2020**

- In this update, I've imported a [Class](https://github.com/vrld/hump) library from [Matthias Richter](https://github.com/vrld) to define Classes and create objects in Lua

- I've also created the Map Class, that deals with the implementation of the background
- Lastly, in this update I've defined the *map.camX* and *map.camY* attributes, and called the *love.graphics.translate* function to create the movement effect

### Fifty Fighters 3

*The Animation Update*

**Date: September 1st, 2020**

- Creating the Animation Class
- Downloading a [background gif](https://steamcommunity.com/sharedfiles/filedetails/?id=1783305814)
- Converting the gif into a sprite sheet with [ezgif.com](https://ezgif.com/gif-to-sprite)

### Fifty Fighters 4

*The Player Update*

**Date: September 2nd, 2020**

- Creating Player.lua
- Downloading a soldier [sprite sheet](https://www.hiclipart.com/free-transparent-background-png-clipart-vlccj/download) from [HiClipart](https://www.hiclipart.com)

- Converting the sprite sheet into a file for idle animation

### Fifty Fighters 5

*The Movement Update*

**Date: September 2nd, 2020**

- Adding the movement behavior and the movement animation

  


### Fifty Fighters 6

*The Attack Update*

**Date: September 3rd, 2020**

- Implementing the possibility to attack with the attack behavior and animation

### Fifty Fighters 7

*The Jump Update*

**Date: September 3<sup>rd</sup>, 2020**

- Implementation of the jump behavior and animation

### Fifty Fighters 8

*The Death Update*

**Date: September 4<sup>th</sup>, 2020**

- Implementation of the dying behavior and animation
- Implementation of the waiting behavior and animation

### Fifty Fighters 9

*The Characters Update*

**Date: September 4<sup>th</sup>, 2020**

- Downloading some open source sprites from [The Spriter Resource](https://www.spriters-resource.com/)
- Creating, for each character, a directory for the sprite sheets

### Fifty Fighters 10

*The Damage Update*

**Date September 5<sup>th</sup>, 2020**

- Implementing x and y offsets for flipping
- Creating a hurt animation and behavior

- Creating a *Player:enemyAt(x, y)* function, that verifies if there is an enemy in the (x, y) coordinates
- Creating a *Player:detectDamage()* function that detects the presence of enemies in a circle around the character and hurts it

### Fifty Fighters 11

*The Victory Update*

**Date: September 5<sup>th</sup>, 2020**

- Adding the health and damage stats

- Implementing a winning animation and behavior
- When a player health drops to 0, his state is set to dying and his enemy's state is set to winning

### Fifty Fighters 12

*The Passive Update*

**Date: September 5<sup>th</sup>, 2020**

- Creating the *characters.lua* file, that contains a table with the characters stats and abilities

- Creating, for each character, a passive ability

### Fifty Fighters 13

*The Background Table Update*

**Date: September 5<sup>th</sup>, 2020**

- Creating a table with the backgrounds stats 

- Controlling the camera movement based on the players' position


### Fifty Fighters 14

*The Random Background Update*

**Date: September 6<sup>th</sup>, 2020**

- Implementing a random background selection

### Fifty Fighters 15

*The Special Attack Update*

**Date: September 7<sup>th</sup>, 2020**

- Implementing, for each character, a special attack

### Fifty Fighters 16

*The Projectile Update*

**Date: September 8<sup>th</sup>, 2020**

- Implementing projectiles 

### Fifty Fighters 17

*The Duck Update*

**Date: September 9<sup>th</sup>, 2020**

- Creating the duck behavior and animation

### Fifty Fighters 18

*The Cooldown Update*

**Date: September 9<sup>th</sup>, 2020**

- Implementing a cooldown for each special ability 

### Fifty Fighters 19

*The Button Update*

**Date: September 9<sup>th</sup>, 2020**

- In this update, I've created the Button Class, that renders a button, with a label and a function
- I've also created a mouseUpdate() function to track the actions of the mouse

### Fifty Fighters 20

*The Message Update*

**Date: September 9<sup>th</sup>, 2020**

- I've implemented a Message Class to take care of font, size and color implementations all at once

### Fifty Fighters 21

*The Life Bar Update*

**Date: September 9<sup>th</sup>, 2020**

- For this update, I've developed a life bar for the two players, based on their health percentage

### Fifty Fighters 22

*The Musical Update*

**Date: September 10<sup>th</sup>, 2020**

- Implementing a different background music for each map

- All musics from [Freesounds.org](https://freesound.org/)

### Fifty Fighters 23

*The Sound Update 1*

**Date: September 11<sup>th</sup>, 2020**

- Implementing sound effects for idle, jumping, hurt and attacking states

### Fifty Fighters 24

*The Sound Update 2*

**Date: September 12<sup>th</sup>, 2020**

- Implementing sound effects for special, dying, winning, duck and waiting states

### Fifty Fighters 25

*The Sprites Update 1 - Redefining the Animations*

**Date: September 12<sup>th</sup>, 2020**

- In this update I've redefined the animation and sprite system
- I've also imported 60 new sprite sheets from [The Spriters Resource](https://www.spriters-resource.com/),  for characters that **will soon be added**:
  - Adelheid Bernstein
  - Ash Crimson
  - Athena
  - Benimaru
  - Bonne
  - Brian Battler
  - Chang Koehan
  - Clark Still
  - Duck King
  - Duo Lon
  - Effects
  - Eiji Shiro
  - Elizabeth Blanctorche
  - Ex Kyo
  - Gai Tendo
  - Gato Futaba
  - Geese Howard
  - Goddess Athena
  - Goro Daimon
  - Heidern
  - Hotaru Futaba
  - Iori Yagami
  - Jyazu
  - K
  - Kasumi Todoh
  - Kim
  - Kula Diamond
  - Kyo Kusanagi
  - Magaki
  - Malin
  - Maxima
  - Momoko
  - Mr. Big
  - Oswald
  - P-Chan
  - Ralf Jones
  - Ramon
  - Robert Garcia
  - Rugal Bernstein
  - Ryo Sakazaki
  - Shen Woo
  - Shingo
  - Shion
  - Sho Hayate
  - Sie Kensou
  - Silver
  - Tizoc
  - Tung Fu Rue
  - Vanessa
  - Whip
  - Yuri Sakazaki

- I've written some **Python** scripts to help me unzip, rename and organize the new files

### Fifty Fighters 27

*The Sprites Update 2 - Redefining the Jump Method*

**Date: September 14<sup>th</sup>, 2020**

- In this update the jumping state, have been redefined, allowing characters to jump according to the animation
- The map animation have also been recreated to support the new Animation Class

### Fifty Fighters 28

*The Sprites Update 3 - Projectiles*

**Date: September 14<sup>th</sup>, 2020**

- Implementing changes in the projectile Class to allow instantaneous projectiles 

### Fifty Fighters 29 

*The Sprites Update 3 - Bugfixes*

**Date: September 14<sup>th</sup>, 2020**

- Fixing bugs from the recent changes on Animation, Jumping and Projectiles as 
  - x and y Offsets
  - Cam control 
  - Hit boxes 

- Now, the characters' life bar changes it's color based on the health

### Fifty Fighters 30

*The Dynamic Attack Update 1 - Ducking Punch and Air Punch*

**Date: September 15<sup>th</sup>, 2020**

- When characters punch while ducking they trigger a different attack - the ducking punch, with a different behavior and animation
- Also, when they punch during jump, a air punch animation and behavior is activated 

### Fifty Fighters 31

*The Dynamic Attack Update 2 - Kicks, Ducking Kicks*

**Date: September 15<sup>th</sup>, 2020**

- In this update, I've implemented a different type of attack - kick
- When players kick while ducking or jumping, they trigger different animations and behaviors for the kick

### Fifty Fighters 32

*The Multiple Animations Update*

**Date: September 15<sup>th</sup>, 2020**

- Implementing multiple animations for the same state

### Fifty Fighters 33

*The Sprites Update 4 - Specials*

**Date: September 15<sup>th</sup>, 2020**

- Redefining the special behavior based on the last updates on Animations



