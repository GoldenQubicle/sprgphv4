import java.util.*;
import controlP5.*;
import de.looksgood.ani.*;
import de.looksgood.ani.easing.*;

GUI gui;
Controller controller = new Controller();
Animation ani = new Animation();
StringList layerTypes = new StringList("SPIRO", "LINES");
ArrayList<Layer> layers =  new ArrayList();
int Width = 512;
int Height = 512;
boolean lock = false;
Spiro spiro = new Spiro(0);
//Lines line = new Lines();

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
  gui = new GUI(this);
  Ani.init(this);
  //Ani.noAutostart();
  Ani.setDefaultTimeMode(Ani.FRAMES);
  layers.add(spiro);
  //layers.add(line);
}

void draw() 
{
  background(128);
  translate(width/2, height/2);

  ani.anis();
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