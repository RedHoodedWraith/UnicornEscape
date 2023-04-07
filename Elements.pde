/*
Title: Unicorn Escape
Author: Rowan Asami De Almeida

This game was made for the 2018 CGRA151 Project at VUW.
This software is free for all non-comercial and educational use.

Supporting class for UnicornEscape.pde

This class handles the platforms the sprite can land on

Copyright Rowan Asami Rhysand De Almeida 2018
All Rights Reserved
*/

class Block {
  
  // Sizes
    public float sizeX = 250;
    public float sizeY = 20;
    public float padding = 50;
    
    // Colour
    color c = color(60);
    
    // Coordinates
    public float x1;
    public float x2;
    public float y1;
    public float y2;
  
  
  Block() {
    // Randomly places the block anywhere within the window
    x1 = random(0,width-sizeX);
    x2 = x1 + sizeX;
    y1 = random(0,height-sizeY);
    y2 = y1 + sizeY;
    
    //c = color(random(0,255),random(0,255),random(0,255));  // Sets to a random colour
    //this.draw();
  }
  
  Block(float x, float y) {
    // Places the block within the window at the designated points
    x1 = x;
    x2 = x1 + sizeX;
    y1 = y;
    y2 = y1 + sizeY;
    
    //c = color(random(0,255),random(0,255),random(0,255));  // Sets to a random colour
    //this.draw();
  }
  
  void draw() {
    this.draw(x1, y1);
  }
  
  void draw(float x, float y) {
    noStroke();  // No Stroke Line for the shape
    fill(c);  // Sets the colour of the object to the above colour
    
    rect(x,y,sizeX,sizeY);  // Draws the rectangle 
  }
  
  // Returns Whether there is any overlap with another Block object
  Boolean isOn(Block other) {
    Block me = this;
    
    return (((me.x1 < other.x2) && (me.x1 >= other.x1)) || ((me.x2 <= other.x2) && (me.x2 > other.x1)))
    && (((me.y1 < other.y2) && (me.y1 >= other.y1)) || ((me.y2 <= other.y2) && (me.y2 > other.y1)));
    
  }
  
  // Returns Whether there is any overlap with another Block object's padding
  Boolean isNear(Block other) {
    Block me = this;
    
    return (((me.x1 - padding < other.x2 + padding) && (me.x1 - padding >= other.x1 - padding)) || ((me.x2 + padding <= other.x2 + padding) && (me.x2 + padding > other.x1 - padding)))
    && (((me.y1 - padding < other.y2) && (me.y1 - padding >= other.y1)) || ((me.y2 + padding <= other.y2) && (me.y2 + padding > other.y1 - padding)));
    
  }
  
  // Updates the Coordiantes by the values in the parameters
  void update(float x, float y) {
    x1 += x;
    x2 += x;
    y1 += y;
    y2 += y;
  }
  
}
