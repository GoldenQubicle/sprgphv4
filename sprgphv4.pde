//import penner.easing.*;
import peasy.*;
import java.util.*;
import controlP5.*;
import de.looksgood.ani.*;
import de.looksgood.ani.easing.*;

PeasyCam cam;
GUI gui;
Controller controller;
Animation ani;
StringList layerTypes = new StringList("SPIRO", "LINES", "SPIRO3D", "MESH");
ArrayList<Layer> layers =  new ArrayList();
int Width = 512;
int Height = 512;
boolean lock = false;
boolean animate = false;
Spiro layer = new Spiro(0);
Lines layer2 = new Lines();
//Spiro3D layer2 = new Spiro3D();
//Mesh layer = new Mesh(3);


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
  controller = new Controller();
  Ani.init(this);
  Ani.noAutostart();
  Ani.setDefaultTimeMode(Ani.FRAMES);
  layers.add(layer);
  layers.add(layer2);
  ani = new Animation();
}

void draw() 
{
  background(128);
  translate(width/2, height/2);

  ani.aniTest();
  if (lock != true)
  {
    for (Layer myLayer : layers)
    {
      myLayer.display();
    }
  } else 
  {
    noLoop();
  }
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

String getLayerType()
{
  return layers.get(gui.layerSelected).getType();
}