import peasy.*;
import java.util.*;
import java.io.*;
import controlP5.*;
import de.looksgood.ani.*;
import de.looksgood.ani.easing.*;

PeasyCam cam;
GUI gui;
Controller controller;
Animation gif;
StringList layerTypes = new StringList("SPIRO", "LINES", "SPIRO3D", "MESH");
ArrayList<Layer> layers =  new ArrayList();
int Width = 512;
int Height = 512;
boolean lock = false;
boolean pause = true;
//Spiro layer = new Spiro(0);
//Lines layer2 = new Lines();
//Spiro3D layer = new Spiro3D();
Mesh layer = new Mesh(3);

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
  cam = new PeasyCam(this, 512);
  cam.setFreeRotationMode();
  gui = new GUI(this);
  gif = new Animation(this);
  controller = new Controller();
  layers.add(layer);
  //layers.add(layer2);
}

void draw() 
{
  background(128);
  translate(width/2, height/2);

  for (Layer myLayer : layers)
  {
    myLayer.display();
  }
  gif.aniCheckForEnd();
}  

void layer(boolean locked)
{
  if (locked == false)
  {
    lock = true;
  } else 
  {
    lock = false;
  }
}

void ani(boolean playing)
{
  if (playing == true)
  {
    pause = false;
  } else
  {
    pause = true;
  }
}

String getLayerType()
{
  return layers.get(gui.layerSelected).getType();
}