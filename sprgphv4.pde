import controlP5.*;

GUI gui;
StringList layerTypes = new StringList("SPIRO", "EXP");
ArrayList<Layer> layers =  new ArrayList();
int Width = 512;
int Height = 512;
boolean lock = false;
Spiro spiro = new Spiro();

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