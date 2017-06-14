class GUI extends PApplet
{
  PApplet parent;
  ControlP5 cp5;
  int layerSelected = 0;
  int rPaneWidth = 105;
  int rPaneXpos = 740;
  GUI_vector_controls vc;
  ScrollableList layerList;

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
    layersGroup();
    for (int i = 0; i < layers.size(); i++)
    { 
      addLayer(i);
    }
  }

  void layersGroup()
  {
    cp5.addGroup("layers controls")
      .setBackgroundColor(color(255, 75))
      .disableCollapse()
      .setPosition(rPaneXpos, 85)
      .setSize(rPaneWidth, 100);    

    cp5.addScrollableList("Layers")
      .setGroup("layers controls")
      .setPosition(0, 5)
      .setSize(rPaneWidth, 50)
      .setType(ScrollableList.DROPDOWN)
      .setOpen(false)
      .addCallback(new CallbackListener() 
    {
      public void controlEvent(CallbackEvent theEvent) 
      {
        theEvent.getController().bringToFront();
        if (layerSelected != theEvent.getController().getValue())
        {
          layer(lock);
          vc.delGrid();
          layerSelected = int(theEvent.getController().getValue());
          vc.setGrid();
          layer(lock);
        }
      }
    }
    );
  }

  void addLayer(int ls)
  {   
    cp5.get(ScrollableList.class, "Layers")
      .addItem("layer " + (ls + 1) + " ~ " + layers.get(ls).getType(), layers.get(ls));
  }

  public void draw() 
  { 
    background(100);
  }
} 