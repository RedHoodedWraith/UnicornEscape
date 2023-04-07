# Project Plan & Reflection

**Author:** Rowan Asami Rhysand De Almeida</br>
**Dates Written & Updated:** Originally written in 2018; updated in 2023

Below are the supporting documentation I originally submitted at part of my project submission for CGRA151 in 2018. This document combines the Project Plan and the Report & Reflection documents. The Project Plan was written at the start of the project. Report & Reflection was written at the end of the project prior to its submission for CGRA151 for grading.

## Project Plan

### Vision
1. Game concept: A game sprite, the unicorn, is jumping on top of objects and manouvering around objects all to escape the rising acid below. The game play will be similar to that of Doodle Jump. The main differences are that the unicorn isn’t trying to attack enemies but instead is trying to avoid falling objects and touching the acid that is slowly rising behind them.
2. Game play: The main mechanics assumes the player is using a keyboard and/or a mouse (you can theorhetically play with a trackpad but it will be unconfortable). Pressing space or left clicking causes the game sprite to jump. Pressing left or right  or moving the mouse left or right controls the sprite’s horizontal movement.
3. Visual design: I plan on using a game made of shapes with sharp edges (like triangles) and neon colours. The backdrop will be a dark colour however at this stage, I have not decided on what colours they will be. The game is set inside a dark cavern with lots of ledges for the unicorn to jump on. All game resources will be made out of rectangles and triangles.

### Timetable
1. A core working program (done by two weeks before deadline): By two weeks, I plan to have at least a moving sprite that can move left and right upon being controls and jumps upon the space button or left mouse click. I also plan to have environment the player can interact with such as objects the sprite can jump on top of. I also hope to have at least gotten started on the liquid though not necesarily completed.
2. A reasonable submission (done by one week before deadline): I plan to have the more progress on the liquid and its fluid motion almost perfected. The asthetics of the game, such as colours should be completed by now.
3. A well-polished submission (done by project deadline): If I have time, I hope to add a little animation at the beginng the shows how the unicorn go in this situation.

## Report & Reflection

### Vision
A game sprite, the unicorn, is jumping on top of platforms the rising acid below. The game play will be similar to that of Doodle Jump. The main differences are that the unicorn isn’t trying to attack enemies but instead is avoiding touching the acid that is slowly rising behind them. As the player progresses in the game, the platforms get smaller and the acid rises faster.

### Achievement
I was able to make the sprite be able to jump on top of and stay on the platforms and have acid rise behind him. When the unicorn touches the acid, the game cuts to a game over screen. I was also able to make the menus for the game.

### Technical Challenges
My main challenge, despite sounding so simple, was trying to get the unicorn to stay on top the platform. This was surprisingly hard because along with gravity affecting its downward velocity, the unicorn often kept glitching through the platform and often getting stuck in it. I resolved this issue by having a “sitting” state where if its on a platform, the unicorn’s position gets set to be on top of the platform and its velocity gets set to zero and gravity is set to zero. The other challenge was trying to get the unicorn to stay on a platform when it position changes as a result of the unicorn moving upward. I resolved this by saving a platform block that the unicorn was on into its object everytime the platforms are drawn.

### Reflection
If I’ll be honest, making this was rather frustrating (though that might be because I started working on this quite late). The thing that took me the longest to implement was trying to get the unicorn to stay on a platform. Despite being so easy in theory, the issue often was that the sprite kept glitching through its boundary because gravity kept trying to increment velocity, which in turn kept tying to move the sprite’s position. That and combined with trying to make the every single element move downward as the sprite jumped. What I found surpringly easy was implementing gravity on a falling object. The game was going to have falling objects however due to time constraints as of writing this, I was unable to implement this. All in all, I am quite proud of this game, especially with how much work I had to put into this.
