class GUI extends PApplet
{
  PApplet parent;
  ControlP5 cp5;
  int layerSelected = 0;
  int rPaneWidth = 105;
  int rPaneXpos = 740;
  GUI_gearGroup gg;
  GUI_trackGroup tg;
  ScrollableList layerList, propList;

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

  public void controlEvent(ControlEvent theEvent) {
    //controller.matchSegmentController(theEvent);
  }

  public void setup()
  {
    cp5 = new ControlP5(this);
    cp5.disableShortcuts();
    cp5.setColorActive(ControlP5.GREEN);
    cp5.setColorForeground(ControlP5.ORANGE);
    gg = new GUI_gearGroup(cp5);
    tg = new GUI_trackGroup(cp5);

    layersGroup();    

    for (int i = 0; i < layers.size(); i++)
    { 
      addLayer(i);
    }
  }

  /* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   L A Y E R   M E T H O D S
   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

  void addLayer(int ls)
  {   
    cp5.get(ScrollableList.class, "Layers")
      .addItem("layer " + (ls + 1) + " ~ " + layers.get(ls).getType(), layers.get(ls));
  }

  void layersGroup()
  {
    cp5.addGroup("layers controls")
      .setBackgroundColor(color(255, 75))
      .disableCollapse()
      .setPosition(rPaneXpos, 150)
      .setSize(rPaneWidth, 100)
      .setColorForeground(ControlP5.BLUE);      

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
          gg.delGrid();
          tg.delMenu();
          layerSelected = int(theEvent.getController().getValue());
          gg.setGrid();
          tg.addMenu();
          layer(lock);
        }
      }
    }
    );
  }

  public void draw() 
  { 
    background(100);
    strokeWeight(3);
    line(gui.tg.trackStart, 270, gui.tg.trackEnd, 270);  

    if (tg.segmentHoover == true)
    {

      controller.tG.segmentHandler();
      cursor(HAND);
    } else 
    {
      cursor(ARROW);
    }
    //gif.aniPlay();
  }

  void keyPressed()
  {
    if(key == 'p')
    {
     controller.fileio.saveLayer();
     //controller.fileio.saveAni();
     //controller.fileio.saveCP5();
     println("saved");
    }

    if (key == 'q')
    {
      //controller.tG.aniUpdate.clear();
      //println("clear");
    }

    if (key == ' ')
    {
      //controller.tG.aniUpdate.clear(); 
      ani(pause);
      gif.aniPlayPause();
    }

    if (key == 'a')
    {
      controller.tG.editMode = controller.tG.editModes.get(1);
      controller.tG.updateSegmentHandler(mouseX);
    }
    if (key == 's')
    {
      controller.tG.editMode = controller.tG.editModes.get(0);
      controller.tG.updateSegmentHandler(mouseX);
    }
    if (key == 'd')
    {
      controller.tG.editMode = controller.tG.editModes.get(2);
      controller.tG.updateSegmentHandler(mouseX);
    }
  }

  float getMousePos()
  {
    return mouseX;
  }
} 