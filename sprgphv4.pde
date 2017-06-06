/*

gears per 3 in group?
anyway, use accordion multi to organize
also, controlkey! whaaat

 ----
 also, the layer class will obviously have to handle setup of gears in gui as well
 and than maybe have the IDisplay interface also have a grinding() method to implement
 that way, the layer class simply holds all the variables, the interface provides methods, and derived classes are fun! 
  
 */
import controlP5.*;

GUI gui;
Spiro spiro = new Spiro();
ArrayList<Layer> layers =  new ArrayList();
int Width = 512;
int Height = 512;

void settings() {
  size(Width, Height, P3D);
  smooth(8);
}

void setup() {
  colorMode(RGB);
  surface.setTitle("Preview");
  surface.setResizable(true);
  layers.add(spiro);
  gui = new GUI(this);
}

void draw() {
  background(128);
  translate(width/2, height/2);
  for(Layer myLayer : layers){
    myLayer.display();
  }
}