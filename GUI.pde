class GUI extends PApplet
{
  PApplet parent;
  ControlP5 cp5;
  int layerSelected = 0;
  GUI_vector_controls vc;

  public GUI(PApplet theApplet)
  {
    super();
    parent = theApplet;
    PApplet.runSketch(new String[]{this.getClass().getName()}, this);
  }

  public void settings() 
  {
    size(860, 512);
  } 

  public void setup()
  {
    cp5 = new ControlP5(this);
    vc = new GUI_vector_controls(cp5);
  }

  public void draw() 
  {
    background(100);
  }
} 