/*
Title: Unicorn Escape
Author: Rowan De Almeida

This game was made for the 2018 CGRA151 Project at VUW.
This software is free for all non-comercial and educational use.

Copyright Rowan De Almeida 2018
All Rights Reserved
*/

// Velocity and Acceleration Values
float grav = 1;

// State Booleans
Boolean startPerm;
Boolean contactFound;
Boolean gameOver;
Boolean leveled;
Boolean instructPerm;
Boolean pause;

// Important Objects
ArrayList<Block> list;  // Arraylist to store the blocks
UnicornSprite s;  // Main Character Sprite
Liquid acid;  // The acid obstacle object
Block b; // Test Platform
Block a; // Test Platform

// Fonts
PFont pacifico;
PFont varelaR;
PFont quicksand;

// Other Values
int score;
int finalScore;
int level;
color backgroundColour;

/* The Set Up Loop */
void setup(){
  
  startPerm = false;
  contactFound = false;
  gameOver = false;
  leveled = false;
  instructPerm = false;
  pause = false;
  
  score = 0;
  level = 1;
  backgroundColour = color(74,74,112);
  list = new ArrayList<Block>();
  
  pacifico = createFont("fonts/Pacifico-Regular.ttf", 32);
  varelaR = createFont("fonts/VarelaRound-Regular.ttf", 32);
  quicksand = createFont("fonts/Quicksand-Regular.ttf", 32);
  
  size(600, 800);
  s = new UnicornSprite(0,0);
  acid = new Liquid();
  for(int i=0; i<9; i++){
    list.add(new Block(random(0,width-200), 60+(100*i)));
  }
  list.add(new Block(10,500));  // Starting Platform
  
  a = new Block(); // Sample Block
}

/* The Main Draw Loop */
void draw(){
  println(pause);
  if(!startPerm){
    if(instructPerm){
      instructions(); 
    }else{
      startMenu(); 
    }
  }else if(gameOver){
    gameOverScreen();
  }
  else if(pause){
    pauseMenu();
  }else{
    background(backgroundColour);
    //onePlatform();
    drawPlatforms();
    s.draw();  // Redraws the sprite
    acid.increase();
    if(s.jumping){
      acid.decrease();
    }
    acid.draw();
    finalScore = Math.round(score/100);
    levelUp();
    banner();
    //printDiagnostics();
  }
}



/* Methods and Functions */


// Draws a repeated set of Platforms
void drawPlatforms(){
  contactFound = false;
  for(int i=0; i<list.size(); i++){
    list.get(i).draw();
    if(s.isOn(list.get(i))){
      s.blockCompare = list.get(i);
      contactFound = true;
    }else if(s.y+s.totHeight+s.offsetY >= height){
      contactFound = true; 
    }
    // Draws a new platform for every platform that goes past the bottom of the screen
    if(list.get(i).y1 > height){
      list.set(i, new Block(random(0,width-a.sizeX), -20-(random(30,65))));
      list.get(i).sizeX = a.sizeX;
      for(int j=0; j<list.size(); j++){
        while(i != j && (list.get(j).isOn(list.get(i)))){
          list.set(i, new Block(random(0,width-a.sizeX), -20-(random(40,60))));
          list.get(i).sizeX = a.sizeX;
          //j = 0;
          break; 
        }
      }
    }
   }
   if(!contactFound){
    s.sitting = false;
  }
  
}

void keyPressed(){
   // Keyboard Controls
  if((keyCode == UP || key == 'w') && (keyCode == CONTROL) && (keyCode == ALT)){
    s.up();
  }
  if((keyCode == DOWN || key == 's') && (keyCode == CONTROL) && (keyCode == ALT)){
    s.down();
  }
  if((keyCode == RIGHT || key == 'd')){
    s.right();
  }
  if((keyCode == LEFT || key == 'a')){
    s.left();
  }
  if(keyCode == ' ' || keyCode == UP || key == 'w'){
    s.jump();
  }
  if(key == 'p' || keyCode == 'p'){
    if(!pause){
      pause = true; 
    }else{
      pause = false; 
    }
  }
}

void startMenu(){
  
  // Background and Font Colours
  background(0);
  fill(255,255,255);
  textAlign(CENTER);
  
  // Title
  String title = "Unicorn Escape";
  textFont(pacifico, 80);
  float titleWidth = textWidth(title);
  text(title, (width/2), (height/3)-50);
  
  // Play Button
  String playS = "Play";
  textFont(varelaR);
  float playSwidth = textWidth(playS);
  float playSheight = textAscent() - textDescent();
  if(((mouseX >= (width/2)-(playSwidth/2)) && (mouseX <= (width/2)+playSwidth))
  && ((mouseY >= (height/2)-playSheight) && (mouseY <= (height/2)+playSheight))){
    fill(250,255,0);
    if(mousePressed){
      startPerm = true; 
    }
  }else{
   fill(255);
  }
  text(playS, (width/2), (height/2)+playSheight);
  
  // How to Play Button
  String instButton = "How to Play";
  textFont(varelaR);
  float instWid = textWidth(instButton);
  float instHei = textAscent() - textDescent();
  if(((mouseX >= (width/2)-instWid/2) && (mouseX <= (width/2)+instWid/2))
  && ((mouseY >= (height/2)-playSheight+20+instHei) && (mouseY <= (height/2)+playSheight+20+instHei))){
    fill(250,255,0);
    if(mousePressed){
      startPerm = false;
      instructPerm = true;
    }
  }else{
   fill(255);
  }
  text(instButton, (width/2), (height/2)+playSheight+20+instHei);
  
  // Exit
  String closeProgram = "Exit";
  float closePwidth = textWidth(closeProgram);
  float closeHeight = textAscent() - textDescent();
  if(((mouseX >= (width/2)-closePwidth/2) && (mouseX <= (width/2)+closePwidth/2))
  && ((mouseY >= (height/2)-playSheight+20+instHei+20+closeHeight) && (mouseY <= (height/2)+playSheight+20+instHei+20+closeHeight))){
    fill(250,255,0);
    if(mousePressed){
      exit();
    }
  }else{
   fill(255);
  }
  text(closeProgram, width/2, (height/2)+playSheight+20+instHei+20+closeHeight);
  
}

// Instructions
void instructions(){
  background(0);
  fill(255);
  
  // Title
  String insTitle = "How to Play";
  String introA = "Yuri the Unicorn is stuck in a cave. To make it worse,";
  String introB = "the cave below is filling up with acid.";
  String introC = "Help Yuri escape the cave by jumping onto";
  String introD =  "each ledge before the acid catches up to him.";
  String directions1a = "Use either the 'A' or 'LEFT' keys to move the unicorn left";
  String directions1b = "and the 'D' or 'RIGHT' keys to move the unicorn right.";
  String directions2 = "To jump, press either the 'W', 'UP' or 'SPACE BAR' keys.";
  String directions3 = "Press 'P' to pause";
  String backButton = "Back";
  String credit = "This game was made by Rowan Rathod for the 2018 CGRA151 Project";
  float backWidth = textWidth(backButton);

  textFont(quicksand,45);
  textAlign(CENTER);
  text(insTitle, (width/2),100);
  
  textFont(quicksand, 20);
  textAlign(CENTER);
  text(introA, (width/2), 175);
  text(introB, (width/2), 200);
  text(introC, (width/2), 225);
  text(introD, width/2, 250);
  text(directions1a, (width/2), 300);
  text(directions1b, (width/2), 325);
  text(directions2, width/2, 350);
  text(directions3, width/2, 400);
  
  
  textAlign(CENTER);
  textFont(varelaR, 15);
  text(credit, width/2, 600);
  
  textFont(varelaR, 20);
  textAlign(LEFT);
  if(((mouseX >= 10) && (mouseX <= 10+backWidth))
  && (((mouseY >= height-textDescent()-textAscent()-6)) && (mouseY <= height))){
    fill(250,255,0);
    if(mousePressed){
      instructPerm = false;
    }
  }else{
   fill(255);
  }
  text(backButton, 10, height - (textAscent() - textDescent()));
  println(textAscent() - textDescent());
}

// Game Over Screen
void gameOverScreen(){
  
  // Background and Font Colours
  background(0);
  fill(255,255,255);
  textAlign(CENTER);
  
  // Title
  String title = "Game Over";
  textFont(varelaR, 80);
  text(title, (width/2), (height/3)-50);
  
  // Play Button
  String playS = "Play Again";
  textFont(varelaR);
  float playSwidth = textWidth(playS);
  float playSheight = textAscent() - textDescent();
  if(((mouseX >= (width/2)-(playSwidth/2)) && (mouseX <= (width/2)+(playSwidth/2)))
  && ((mouseY >= (height/2)-playSheight) && (mouseY <= (height/2)+playSheight))){
    fill(250,255,0);
    if(mousePressed){
      reset();
      startPerm = true;
    }
  }else{
   fill(255);
  }
  text(playS, (width/2), (height/2)+playSheight);
  
  // Exit
  String closeProgram = "Exit";
  float closePwidth = textWidth(closeProgram);
  float closeHeight = textAscent() - textDescent();
  if(((mouseX >= (width/2)-closePwidth/2) && (mouseX <= (width/2)+closePwidth/2))
  && ((mouseY >= (height/2)-playSheight+20+closeHeight) && (mouseY <= (height/2)+playSheight+20+closeHeight))){
    fill(250,255,0);
    if(mousePressed){
      exit();
    }
  }else{
   fill(255);
  }
  text(closeProgram, width/2, (height/2)+playSheight+30+closeHeight);
  
}

// When to increment current level
void levelUp(){
  if((finalScore % 100 == 0) && !leveled){
    level = 1+(finalScore/100);
    if(level != 1){
      acid.updateRising(0.15);
      if(a.sizeX > 175){
        a.sizeX -= 5;
      }
    }
    leveled = true;
  }else{
    leveled = false;
  }
  
  if(level == 2){
    backgroundColour = color(87, 148, 186);
    s.bodyColor = color(31, 53, 137);
    acid.colour = color(141, 226, 118);
  }
  if(level == 3){
    backgroundColour = color(87, 148, 186);
    s.bodyColor = color(31, 53, 137);
  }
  
}

// Banner
void banner(){
  float bH = 30;  // Banner Height
  fill(50);
  rect(0,0,width,bH);
  fill(255);
  textFont(varelaR);
  textSize(15);
  text(finalScore, 10, 20);
  String levelString = "Level: " + level;
  float levelSwidth = textWidth(levelString);
  text(levelString, width-levelSwidth-10, 20);
}

// Pause Menu
void pauseMenu(){
  
  float pauseWidth = width*0.7;
  float pWidthDiff = width - pauseWidth;
  float pauseHeight = height*0.7;
  float pHeightDiff = height - pauseHeight;
  String pauseTitle = "Game Paused";
  String continueButton = "Continue";
  String mainMenuP = "Exit to Main Menu";
  float pTextHeight = textDescent() - textAscent();
  textAlign(CENTER);
  
  fill(30);
  rect(pWidthDiff/2, pHeightDiff/2, pauseWidth, pauseHeight);
  fill(255);
  textFont(quicksand,50);
  text(pauseTitle, (width/2), (height/2)-(pauseHeight/4));
  
  // Resume Game Button
  textFont(varelaR, 30);
  if(((mouseX >= (width/2)-textWidth(continueButton)/2) && (mouseX <= (width/2)+textWidth(continueButton)/2))
  && ((mouseY >= (height/2)-(pauseHeight/10) + pTextHeight) && (mouseY <= (height/2)-(pauseHeight/10) - pTextHeight))){
    fill(250,255,0);
    if(mousePressed){
      pause = false;
    }
  }else{
    fill(255);
  }
  text(continueButton, (width/2), (height/2)-(pauseHeight/10));
  
  // Exit to Main Menu Button
  textFont(varelaR, 30);
  if(((mouseX >= (width/2)-textWidth(mainMenuP)/2) && (mouseX <= (width/2)+textWidth(mainMenuP)/2))
  && ((mouseY >= (height/2) + pTextHeight) && (mouseY <= (height/2) - pTextHeight))){
    fill(250,255,0);
    if(mousePressed){
      startPerm = false;
      reset();
    }
  }else{
    fill(255);
  }
  text(mainMenuP, (width/2), (height/2));
  
}

void reset(){
  setup();
}

// Prints out some important details (For Development Purposes)
void printDiagnostics(){
  println(" ");
  println("velY: " + s.velY);
  println("x: " + s.x);
  println("y: " + (s.y+s.totHeight));
  println("Contact: " + s.isOn(b));
  println("Falling: " + s.falling);
  println("Sitting: " + s.sitting); 
}

// Draws one platform (For debugging purposes)
void onePlatform(){
  if(s.isOn(b)){
    s.blockCompare = b;
  }else if(s.isOn(a)){
    s.blockCompare = a; 
  }
  else{
    s.sitting = false;    
  }
  
  println(a.isOn(b));
  a.draw();
  b.draw();
}

// Draws a static set of Platforms (For debugging purposes)
void buildPlatforms(){
  contactFound = false;
  for(int i=0; i<list.size(); i++){
    list.get(i).draw();
    
    if(s.isOn(list.get(i))){
      s.blockCompare = list.get(i);
      contactFound = true;
    }   
  }
  
  if(!contactFound){
    s.sitting = false;
  }
}
