class Liquid{
  
  color colour;
  float volume;
  float rising;
    
  
 Liquid(){
    volume = 0;
    rising = 0.5;
    colour = color(62,147,47);
 }
 
 void draw(){
   
   if(volume < 100){
     volume = 100; 
   }
   
   fill(colour);
   rect(0,height-volume,width,volume); 
 }
 
 void increase(){
  volume += rising;
 }
 
 void decrease(){
   volume -= rising-(rising/2); 
 }
 
 void updateRising(float update){
   rising += update; 
 }
 
}
