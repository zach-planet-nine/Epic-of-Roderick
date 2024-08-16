# The Epic of Roderick

*The Epic of Roderick* is an _incomplete_ RPG built for...uh like iOS 3 or something. 
I learned the engine part from following [these tutorials from 71 squared](https://www.youtube.com/watch?v=Y1FAmxU6zZ0&list=PLE9F4AAE584A1F340), and their companion book, which is so old now that I can't seem to find it on the internet.

It's written in Objective-C with a smattering of OpenGL ES 1.0 (pre-shaders people), which is probably the equivalent of Egyptian hieroglyphics to people learning to code today. 
But, though it doesn't run, the code does show up in XCode so maybe there's something to be gleaned for any Mac users out there.

I have no plans to revive this particular project, though Roderick lives on in the lore of Planet Nine. 
It's offered here in the hope that my struggles of figuring all this out long ago, might help future developers.

### Overview

The Epic of Roderick (TEoR) is meant to feel like an SNES-era JRPG.
It's 2D with a tile map overworld, and separate battle scenes reminiscent of Final Fantasies 4-6. 
The novelish aspect of it at the time was its use of iPhones' touch input for controls rather than an overlayed virtual controller.

#### Battle System

Rather than employing Square's atb system for battle member selection (a game mechanic, which is oddly patented), TEoR uses Elder Scrolls style stamina and magic bars for atacks and spells.
The idea is for the player to switch between characters by tapping them once their bars recharge, and then use an action based on the powers available to them. 
In later levels this made battle pretty frenetic, which I thought was fun.

Each character had a different input for attacking: Roderick slashed his sword, the Valkyrie tapped to throw a spear, the wizard long pressed for an energy ball, and the ranger used the accelerometer to aim his bow. 
Each character was also supposed to have a special ability, but I kind of abandoned those halfway so you'll see remnants in the code, but I don't think any of it actually worked (except for the Ranger's animals, because they were cool).

Spells are collected as runes throughout the game, whether as story items or other ways.
They're cast by drawing them on the screen.
My rudimentary approach to capturing drawn input can be found in the InputManager class, which is only 2300 lines long or so.
After they're drawn, the rune can then be dragged onto characters or enemies to be cast.

There were also supposed to be items, but I never got that far on them.

Enemies have, I thought, a kind of nifty AI system based on the gambit system of FF XII. 
You define all sorts of states, like character with lowest health, or enemy with most stamina, and then you can give each enemy a threshold for that state.
So it's something like if my essence is above 50%, use this ability on the character with the most health.
Then you basically just have one decider method to pick an action when the enemy's turn comes up.

#### Character

The characters are found as the story progresses.
In the scenes I built you start as Roderick, and find the Valkyrie, the Wizard, and the Ranger.

Each character has stats, experience, levels, hp, mp (called essence), endurance, and luck.
They have overworld sprites for walking around, and battle sprites for battle.
Almost all of which is placeholder art.

#### Story

So one of the most important things I learned building this is the importance of tooling in game development.
In a game engine, you have the concept of scenes, and can just start at any scene, but I didn't have this here, and once I started putting the story together I found I had to play fifteen minutes through the game just to get to what I wante to test.
I quickly built the ability to do that at that point, but I wish I had built it in at the beginning because adding it in was awkward.

You'll also see the ScriptReader class. 
Even if you don't plan on having your game be in different languages, I recommend using a localization file like this. 
The 300 strings here was for like 20-30 minutes of play time.
A full length game will easily have thousands of strings, and managing those in code will be awful.

#### Game Engine

As I mention above, I built the engine based on a tutorial.
I did add some Physics to the animations and particle systems, which may be interesting. 
I think this is a pretty good indicator of just what role the engine plays in all this--the engine's like 15 classes out of the 500 in this 30 minute unfinished game.

#### Animations

So here's where I think this can be helpful.
I don't really like GUIs because to use a GUI you have to learn how to use the GUI, and quite frankly I don't have time for that.
So all the animations are done in code.
Which is pretty cool, because you don't often see game animations done in code.

I wanted the game to feel like a bullet hell during battle, so a lot of the spells have lot of particle effects, and hit multiple times.
There's damage, but it's not balanced at all.
Somewhere there's a huge spreadsheet of all the skills and spells, but it might be lost to the archives.

#### Overworld

The overworld uses [TBXML](https://github.com/codebots-ltd/TBXML), which interestingly hasn't been updated in 12 years either. 
It's just an XML parser for tile sets, and tile maps. 

### How to run

This doesn't run. 
If I get really bored some day I might try to get it to run again.
If you get it running, I will gladly approve that PR.

### Conclusion

Have fun looking at this ancient code. 
If you stumble upon this, and want to ask me questions head on over to https://opensourceforce.net, join the discord there and hmu.
I'm planetnineisaspaceship.
