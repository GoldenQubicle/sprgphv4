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
StringList layerTypes = new StringList("SPIRO", "LINES", "SPIRO3D");
ArrayList<Layer> layers =  new ArrayList();
int Width = 512;
int Height = 512;
boolean lock = false;
boolean animate = false;
//Spiro layer = new Spiro(0);
Mesh layer = new Mesh();
//Lines layer = new Lines();
//Spiro3D layer = new Spiro3D();


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
  //layers.add(line);
  ani = new Animation();
}

void draw() 
{
  background(0);
  translate(width/2, height/2);

  ani.aniTest();
  for (Layer myLayer : layers)
  {
    myLayer.display();
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