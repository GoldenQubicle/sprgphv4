/*
so yeah bit of an issue here: 
 
 in order to have varied number of gears, I obviously cannot rely on xyz.x = gear1.xyz.x + gear2.xyz.x + ... etc
 
 instead Ill need something like
 for(int i = 0; i < gears.size(); i++){
 xyz.add(gears.get(i)); 
 }
 whereby gears is nothing but an PVector ArrayList. . and this fucks things over bigtime. . at least in regard to the previous version
 
 SO; what Im bascially saying is, good luck with that :) i.e. have to get used to working with vectors. . 
 and the current thinking is that I have to normalise some stuff and than final step is multiply by the radius of something. . 
 
 first order of business is to get the spiro class to draw a circle with a fixed radius yet varied density
 
 ----
 also, the layer class will obviously have to handle setup of gears in gui as well
 and than maybe have the IDisplay interface also have a grinding() method to implement
 that way, the layer class simply holds all the variables, the interface provides methods, and derived classes are fun! 
 
 
 
 
 */

Spiro spiro = new Spiro();

void setup() {
  size(1024, 1024, P3D);
  colorMode(RGB);
  smooth(8);
}

void draw() {
  background(128);
  translate(width/2, height/2);
  spiro.display();
}