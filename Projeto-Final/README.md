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

   



