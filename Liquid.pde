/*
Title: Liquid Class for Unicorn Escape
Author: Rowan Asami De Almeida

This game was made for the 2018 CGRA151 Project at VUW.
This software is free for all non-comercial and educational use.

Supporting class for UnicornEscape.pde

This class handles the rising liquid the sprite is escaping from.

Copyright Rowan Asami Rhysand De Almeida 2018
All Rights Reserved
*/

class Liquid {

  color colour;
  float volume;
  float rising;

  Liquid() {
    volume = 0;
    rising = 0.5;
    colour = color(62,147,47);
  }

  void draw() {
    if(volume < 100) {
      volume = 100; 
    }
    
    fill(colour);
    rect(0,height-volume,width,volume); 
  }

  void increase() {
    volume += rising;
  }

  void decrease() {
    volume -= rising-(rising/2); 
  }

  void updateRising(float update) {
    rising += update; 
  }
 
}
