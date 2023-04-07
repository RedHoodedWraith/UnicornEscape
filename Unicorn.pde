class UnicornSprite{
  public float x;  // X Position
  public float y;  // Y Position
  float xp;
  float yp;
  float mHead;
  float cHead;
  float size  = 10;
  float step = 25-xp;  // Movement stepocity (Debugging Purposes)
  float velX = 0;
  float velY = 0.3;
  float jumpVel = -22;
  float grav = 1;  // Gravity
  float offsetX;
  float offsetY;
  float totWidth;
  float totHeight;
  Boolean sitting = true;  // Boolean for whether the sprite is in contact with a platform or the bottom of the window
  Boolean jumping;
  Boolean falling;
  Boolean orientRight = true;
  Block blockCompare;
  color bodyColor;

UnicornSprite(float x, float y){
  // Sets the minipixel size and location
  xp = size;
  yp = size/1.5;
  
  jumping = false;
  falling = false;

  bodyColor = color(65,105,255);

  offsetX = 1.5*xp;
  offsetY = 0.5*yp;
  
  this.x = x+offsetX;
  this.y = y+offsetY;
  
  totWidth = (xp*8);
  totHeight = (yp*8.5);

}

  void moveX(float newX){
    for(int i=0; i<newX; i++){
       if((this.x > 0-xp) && (this.x + this.totWidth< width)){
          this.x += newX/abs(newX);
        }
    }
  }
  
  void moveY(float newY){
    for(int i=0; i<newY; i++){
       if((this.y > 0) && (this.y + this.totHeight < height)){
          this.y += newY/abs(newY);
        }
    }
  }
  
  // Jump
  void jump(){
    if(sitting){
      jumping = true;
      velY = jumpVel;
      sitting = false;
    }
  }

  // Move Left
  void left(){
   //for(int i=0; i<=step; i++){
      if(((this.x + offsetX> 0))){
        //this.x--;
        this.x-=step;
      }
      else if(this.x + offsetX < 0){
      //this.x = -xp;
      this.x = 0-offsetX;
      }
    //}
    orientRight = false;
  }
  
  // Move Right
  void right(){
    //for(int i=0; i<=step; i++){
      if(((this.x + offsetX + this.totWidth< width))){
        //this.x++;
        this.x+=step;
      }
      else if(((this.x + offsetX + this.totWidth > width))){
       //this.x = width - this.totWidth;
       this.x = width - this.totWidth - offsetX;
      }
    //}
    orientRight = true;
  }
  
  // Move Up (Debug Only)
  void up(){
   for(int i=0; i<=step; i++){
     if((this.y > 0)){
       this.y--;
     }
   }
  }

  // Move Down (Debug Only)
  void down(){
   for(int i=0; i<=step; i++){
     if(((this.y + this.totHeight < height))){
       this.y++;
     }
   }
  }
  
  // Method to call when sprite is on a ground (e.g. Platform or Bottom of window)
  void onSurface(float groundY){
    jumping = false;
    falling = false;
    y = groundY - totHeight - offsetY;
    velY = 0;  // Velocity gets set to zero
    sitting = true;  // Sets its boolean to true
  }
  


  void draw(){
    
    int extraCount = 0;
    x += velX;
    
    // Increments vertical speed one pixel at a time
    for(int i=0; i<abs(velY); i++){
      y += abs(velY)/velY;
      if(velY < 0){
        score++;
      }
      // Sets sprite back inside the pane at the top when it leaves the threshold a quarter of the height from top
      if(y < height/4){
        y = height/4;
        extraCount++;
        acid.decrease();
      }
      
      if(y+totHeight > height-acid.volume){
        gameOver = true;
      }
      
      // Sets sprite back inside the pane at the bottom when it leaves the window from bottom
      if(y+totHeight+offsetY >= height){
        onSurface(height);
      }
      // Checks if there is still contact with a platform
      if(blockCompare != null){
        if(s.isOn(blockCompare) && falling){
          onSurface(blockCompare.y1); 
        }
      }
      
    }
    // Updates the rest of the blocks when the sprite moves 
    if(extraCount>0){
      for(int i=0; i<list.size(); i++){
        list.get(i).update(0,extraCount+5);
      }
    }
    
    if(velY > 0){
      falling = true; 
    }
    
    // Applies gravity when not on platform or bottom of window
    if(!sitting){
      velY += grav;
    } else{
      velY = 0;
    }
    
    /* // Draws a rectange around the sprite (For Debugging Purposes)
    stroke(0);
    fill(255);
    rect(x+1.5*xp,y,totWidth,totHeight);*/
    
    // Sets the colours
    noStroke();
    fill(bodyColor);
  
    // Draws the torso of the sprite
    beginShape();
    vertex(7*xp+x,2.25*yp+y);
    vertex(7.70*xp+x,6.3*yp+y);
    vertex(3.1*xp+x, 4.95*yp+y);
    vertex(2.8*xp+x, 3.8*yp+y);
    endShape(CLOSE);
  
    // Head Variables
    float xh1 = 7*xp + x;
    float yh1 = 2.25*yp + y;
    float xh2 = 9.5*xp + x;
    float yh2 = 2.25*yp + y;
    float xh3 = 7*xp + x;
    float yh3 = 0.8*yp + y;
  
    mHead = ((9.5*xp-7*xp)+x/(2.25*yp/0.8*yp)+y);  //(xh2-xh3)/(yh2-yh3)
    cHead = 9.5*xp-mHead*2.25*yp;  //xh2 - mHead*yh2
  
    // Draws the head of the sprite
    triangle(xh1,yh1, xh2,yh2, xh3,yh3);
    drawHorn();
  
    // Draws the back leg of the sprite
    triangle(3.4*xp + x,5.1*yp + y, 2.4*xp + x,8.5*yp +y, 3.4*xp + x,8.5*yp +y);
  
    // Draws the front leg of the sprite
    triangle(6.5*xp +x, 6*yp +y, 6*xp + x,8.5*yp + y, 6.7*xp + x,8.5*yp + y);
  
    this.drawHorn();
    this.drawTail();
  
  }
  
  void grid(){
  fill(255);
  rect(x,y,totWidth,totHeight);
  float gridColour = 220;
  // Draws a horizontal gird for guide
  for(int i=1; i<xp*10; i++){

    if(i%xp == 0){
       stroke(gridColour);
       line(i+x,0+y,i+x,(yp*10)+y);
    }
  }

  // Draws a vertical gird for guide
  for(int i=1; i<yp*10; i++){

    if(i%yp == 0){
       stroke(gridColour);
       line(0+x,i+y,(xp*10)+x,i+y);
    }
  }
}
  
  void drawHorn(){
    // Draws the horn of the sprite
    float xho1 = 8*xp;
    float yho1 = ((xho1-cHead)/mHead);
    float xho2 = 8.5*xp;
    float yho2 = (xho2-cHead)/mHead;
    float xho3 = 8.5*xp;
    float yho3 = 0.5*yp;
  
  
    triangle(xho1+x, yho1+y, xho2+x, yho2+y, xho3+x, yho3+y);
  }
  
  void drawTail(){
    // Draws the horn of the sprite
    float xho1 = 2.8*xp;
    float yho1 = 3.8*yp;
    float xho2 = 2*xp;
    float yho2 = 5*yp;
    float xho3 = 1.5*xp;
    float yho3 = 4.5*yp;
  
  
    triangle(xho1+x, yho1+y, xho2+x, yho2+y, xho3+x, yho3+y);
  }
  
  // Checks if the sprite is overlapping a block
  Boolean isOn(Block other){
    if(other != null){
      return ((x+totWidth+offsetX-3.3*xp >= other.x1) && (x+offsetX <= other.x2))
      && ((y+totHeight+offsetY >= other.y1) && (y+totHeight+offsetY <= other.y2));
    }
    return false;
  }
}
