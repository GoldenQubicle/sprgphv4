/*
 
 ----
 also, the layer class will obviously have to handle setup of gears in gui as well
 and than maybe have the IDisplay interface also have a grinding() method to implement
 that way, the layer class simply holds all the variables, the interface provides methods, and derived classes are fun! 
 
  */
  
import controlP5.*;

//GUI gui;
Spiro spiro;
ArrayList<Layer> layerActive =  new ArrayList();
int Width = 513;
int Height = 513;
color cBackground;

void settings() {
  size(Width, Height, P3D);
  smooth(8);
}

void setup() {
  //colorMode(RGB);
  //surface.setTitle("Preview");
  //surface.setResizable(true);
  cBackground = color(128, 128, 128);
  spiro = new Spiro();
  layerActive.add(spiro);
  //gui = new GUI(this);
}

void draw() {
  background(cBackground);
  //surface.setSize(Width, Height);
  spiro.display();
  //translate(Width/2, Height/2);
  //for(int i = 0; i < layerActive.size(); i++){
  //  layerActive.get(i).display();
  //}
  
  //for (Layer layers : layerActive) {
  //  layers.display();
  //}
}