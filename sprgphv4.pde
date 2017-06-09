/*
add 'set to zero' & text input fields per gear group

 
 cp5 controlkey! whaaat
 
 ===========================
 
so need to check on delete: vector index cannot go below zero - prolly do this in layer?
also, need to check when there's an empty row, and if yes, delte that from accordion
 
 
 
 
 */

import controlP5.*;

GUI gui;
StringList layerTypes = new StringList("SPIRO", "TEST");
ArrayList<Layer> layers =  new ArrayList();
int Width = 512;
int Height = 512;
boolean Lock = false;
Spiro spiro = new Spiro();

void settings()
{
  size(Width, Height, P3D);
  smooth(8);
}

void setup() 
{ colorMode(RGB);
  surface.setTitle("Preview");
  surface.setResizable(true);
  layers.add(spiro);
  gui = new GUI(this);
}

void draw() 
{
  background(128);
  translate(width/2, height/2);

  for (Layer myLayer : layers)
  {
    myLayer.display();
  }    
}

void layerLock(boolean lock)
{
  if (lock == false)
  {
    Lock = true;
  } else 
  {
    Lock = false;
  }
}