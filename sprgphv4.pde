/*
add 'set to zero' & text input fields per gear group
 add sidemenu with reset all gear (includes petals). Also add/minus gear buttons => the behavirou of which should probably be handled in a controller class
 
 cp5 controlkey! whaaat
 
 ===========================
 
 aaaarrgghhh dynamic adding / deleting vectors almost there, need to seperate each gui method
 i.e. 
 add row group to accordion - done
 add four gear groups to row group - done
 add actual controls to gear group - erg
 
 finally, want to have this setup such that, the callback to add/delete also of course takes into account the layer type!
 i.e. it needs to call a generic function
  
 
 
 
 
 */

import controlP5.*;

GUI gui;
Spiro spiro = new Spiro();
ArrayList<Layer> layers =  new ArrayList();
int Width = 512;
int Height = 512;
boolean Lock = false;

void settings()
{
  size(Width, Height, P3D);
  smooth(8);
}

void setup() 
{
  colorMode(RGB);
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