

# Fifty Fighters - a Game



## Introduction 

Hi, my name is Davi Nakamura, I'm from Brazil and I've been studying Computer Science for my own since this year May. In July I started taking CS50x classes with David J. Malan, Brian Yu, Doug Lloyd and, later, with Colton Ogden in the game track. In these three months I've learned a lot about the computational thinking, how computers work, memory and  data structures. 

In the begging of September, I've finished the game track classes and started this project - Fifty Fighters. Fighting games were always one of my favorite type of games, so I've decided to create my own version. With some open source sprites, backgrounds and sounds from the internet  (check the credits section below), I've developed this game. 



## How to play?

You need two persons to play it. Each one can choose one character, and the one who wins 1/2/3 rounds (depending on the max number of rounds you select in the main menu) is the winner. 



### Controls 

| Action            | Player 1  | Player 2 |
| ----------------- | --------- | -------- |
| Move right        | d         | l        |
| Move left         | a         | j        |
| Run right         | d + space | l + p    |
| Jump              | w         | i        |
| Punch             | f         | h        |
| Kick              | c         | m        |
| Special Ability 1 | e         | u        |
| Special Ability 2 | r         | y        |
| Shoot             | q         | o        |
| Dance             | v         | n        |

Also, the animations, for example, of punch while you are ducking is different of the animations of punch while you are jumping or idle. 

## Credits 

- Sprite sheets from [The Spriters Resouce](https://www.spriters-resource.com/)

- Backgrounds:

  - [VectorStock](https://www.vectorstock.com/royalty-free-vectors/fighting-game-background-vectors)

  - [TwistedSifter](https://twistedsifter.com/2013/05/animated-gifs-of-fighting-game-backgrounds/)

  -  [NeoGeo.com](http://www.neo-geo.com/forums/showthread.php?229323-Fighting-game-backgrounds-animated/page5) 

  - [Fighting Game Backgrounds](https://www.fgbg.art/)

  - [Assuntos Criativos](https://www.assuntoscriativos.com.br/2013/11/45-cenarios-animados-de-jogos-de-luta-2d.html#.U7he4vldU2Y)

    

- Sounds:
  - [Freesound.org](https://freesound.org/)
- Sound editing:
  - [Twisted Wave](https://twistedwave.com/online)
- Sprite sheet conversion:
  - [ezgif.com](https://ezgif.com/gif-to-sprite)
- Research sources: 
  - [lua.org](https://www.lua.org/)
  - [love2d.org](https://love2d.org/)



## Updates

I've written, in order, all the 104 updates, since the creation of a black screen to the last bug fixes.  Some of them may be in the incorrect order/date since I did it some time after they occurred .

[toc]

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
- I've also imported 40 new sprite sheets from [The Spriters Resource](https://www.spriters-resource.com/),  for characters that **will soon be added**:
  - Adam Bernstein
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

### Fifty Fighters 34

*The Super Special Update*

**Date: September 16<sup>th</sup>, 2020**

- Defining a super special ability for each character

### Fifty Fighters 35

*The Fall Update*

**Date: September 16<sup>th</sup>, 2020**

- Implementation of a fall behavior and animation for player that die in the air 

### Fifty Fighters  36

*The Sprites Update 5 - Even More Sprites*

**Date: September 16<sup>th</sup>, 2020**

- Getting more sprite sheets from  [The Spriters Resource](https://www.spriters-resource.com/) for more characters

### Fifty Fighters 37

*The Running Update*

**Date: September 16<sup>th</sup>, 2020**

- In this update I've implemented the running behavior and animation

### Fifty Fighters 38

*The Sprites Update 5 - Character Select Images*

**Date: September 16<sup>th</sup>, 2020**

- Getting portraits for every character

### Fifty Fighters 39

*The Dance Update*

**Date: September 16<sup>th</sup>, 2020**

- Implementing a funny dance for the characters



### Fifty Fighters 40

*The Portrait Update*

**Date: September 17<sup>th</sup>, 2020**

- Showing a character portrait next to the life bar

### Fifty Fighters 41

*The Character Select Update*

**Date: September 18<sup>th</sup>, 2020**

- Implementing the possibility to select characters

### Fifty Fighters 42 

*The Map Update*

**Date: September 19<sup>th</sup>, 2020**

- Implementing a random selection of maps 

### Fifty Fighters 43

*The "Boring Stuff Automation with Python" Update*

- I've created four new Python scripts to automate the following tasks: 
  - Extract from ZIP files
  - Move folders
  - Rename thousands of files
  - Crop, resize and paste images 

### Fifty Fighters 44 - 90

*The Characters Update 1 - 40*

**Date: September 20<sup>th</sup> - October 16<sup>th</sup>, 2020**

- In these 46 updates, I've inserted 40 characters in the game, each one with different damage, range, armor, passive, special 1 and 2 abilities .

### Fifty Fighters 91

*The Start Update*

**Date: October 17<sup>th</sup>, 2020**

- When the game starts, characters will perform a special start dance 

### Fifty Fighters 92

*The Finish Him/Her Update*

**Date: October 18<sup>th</sup>, 2020**

- When characters hit 0 health points, they will be in waiting state and the enemy will have a chance to give them a final hit 

### Fifty Fighters 93

*The Maps Update 2 - More Maps*

**Date: October 19<sup>th</sup>, 2020**

- Adding some cool new maps: 
  - São Paulo Race 
  - Dinosaur Desert
  - Java Palace 

### Fifty Fighters 94

*The Rounds Update*

**Date: October 20<sup>th</sup>, 2020**

- Creating a rounds system in the game

### Fifty Fighters 95

*The Options Update*

**Date: October 20<sup>th</sup>, 2020**

- Implementing a options screen that allows the player to choose between 1, 3 and 5 rounds 

### Fifty Fighters 96

*The Pause Update*

**Date: October 21<sup>th</sup>, 2020**

- Now, when the player hits enter, the game pauses/resumes

### Fifty Fighters 97

*The Music Update 2*

**Date: October 21<sup>th</sup>, 2020**

- Adding two new background musics

### Fifty Fighters 98

*The Voice Update*

**Date: October 22<sup>th</sup>, 2020**

- Adding a voice, that says the round, the winner, the finish him/her message and counts

### Fifty Fighters 99

*The Sound Update 1 - Male Characters*

**Date: October 22<sup>th</sup>, 2020**

- Adding sound Effects for male characters

### Fifty Fighters 100 

*The Sound Update 2 - Female Characters*

**Date: October 22<sup>th</sup>, 2020**

- Adding sound effects for female characters

### Fifty Fighters 101 - 103

*The Bug Fixes Updates 1-3*

**Date: October 23<sup>th</sup>, 2020**

- Fixing lots of bugs

### Fifty Fighters 104 

*The Final Update*

**Date: October 23<sup>th</sup>, 2020**

- Updating README.md
- Reordering the files 
- Testing the game





