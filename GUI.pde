class GUI extends PApplet
{
  PApplet parent;
  ControlP5 cp5;
  Accordion gearControls;
  int layerSelected = 0;
  int size2d = 150;

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
    gearControls = cp5.addAccordion("GC").setPosition(5, 5).setWidth(730).setCollapseMode(Accordion.SINGLE);
    gearGroups(layerSelected);
  }

  void gearGroups(int ls)
  {
    layerSelected = ls;
    int row = -1;
    int col = -1;
    int rowHeight = size2d + 100;

    for (int gears = 0; gears < layers.get(layerSelected).getNumberOfGears(); gears++)
    {
      col+=1;      
      if ( gears % 4 == 0) 
      {                
        row+=1;
        col = 0;        
        cp5.addGroup("row " + row).setBackgroundHeight(rowHeight).setBackgroundColor(color(255, 50));
      }

      // setting up new group per gear vector and adding it to the row group
      cp5.addGroup("gear " + gears).setPosition(10+col*(size2d+30), 15).setSize(size2d+20, size2d+75).setGroup(cp5.get(Group.class, "row " + row))
        .setCaptionLabel("gear " + (gears+1)).setBackgroundColor(color(255, 75)).disableCollapse();

      // actual gear controls created below. 
      // in the future I probably want to check layer type, and call methods accordingly
      // for now dont forget to set the group for control by adding; .setGroup( "gear " + gear) ; also pass down the gear int
      gearSlider2D(gears);
      gearPetals(gears);

      // adding rows to accordion menu
      gearControls.addItem(cp5.get(Group.class, "row " + row));
    }
  }

  void gearPetals(int gear)
  {
    cp5.addSlider("petals " + gear)
      .setGroup( "gear " + gear)
      .setId(gear)
      .setPosition(13, 200)
      .setSize(size2d, 8)
      .setValue(layers.get(layerSelected).petals.get(gear))
      .onChange(new CallbackListener() 
    {
      public void controlEvent(CallbackEvent theEvent) 
      {
        if (theEvent.getAction()==ControlP5.ACTION_BROADCAST) 
        {
          int gear = theEvent.getController().getId();
          layers.get(layerSelected).petals.set(gear, int(theEvent.getController().getValue()));
        }
      }
    }
    );
    cp5.getController("petals " + gear).getCaptionLabel().align(CENTER, CENTER);
  }

  void gearSlider2D(int gear) 
  {
    cp5.addSlider2D("radius x y " + gear)
      .setGroup( "gear " + gear)
      .setId(gear)
      .setPosition(10, 5)
      .setSize(size2d, size2d)
      .setValue(layers.get(layerSelected).radii.get(gear).x, layers.get(layerSelected).radii.get(gear).y)
      .setMinMax(-100, -100, 100, 100)
      .onChange(new CallbackListener()
    {
      public void controlEvent(CallbackEvent theEvent) 
      {
        if (theEvent.getAction()==ControlP5.ACTION_BROADCAST)
        {
          int gear = theEvent.getController().getId();
          layers.get(layerSelected).radii.get(gear).x = theEvent.getController().getArrayValue(0);
          layers.get(layerSelected).radii.get(gear).y = theEvent.getController().getArrayValue(1);
        }
      }
    }
    );
  }

  public void draw() 
  {
    background(100);
  }
}