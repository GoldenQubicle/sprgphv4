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
    gearControls = cp5.addAccordion("GC")
      .setPosition(5, 5)
      .setWidth(730)
      .setCollapseMode(Accordion.MULTI);

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
        cp5.addGroup("row " + row)
          .setBackgroundHeight(rowHeight)
          .setBackgroundColor(color(255, 50));
      }

      //  for now we ALWAYS create vector controls - hence the add & delete buttons are created as well below
      //  specifically, create one new gear group per vector and add it to the proper row group
      //  then call the gearSlider2D method to create the controls and add it to gear group 

      cp5.addGroup("gear " + gears)
        .setPosition(10+col*(size2d+30), 15)
        .setSize(size2d+20, size2d+75)
        .setGroup(cp5.get(Group.class, "row " + row))
        .setCaptionLabel("gear " + (gears+1))
        .setBackgroundColor(color(255, 75))
        .disableCollapse();

      gearSlider2D(gears);

      // here we check the layer type and can create additional controls based off that
      // dont forget to set the control group by adding; .setGroup( "gear " + gear) ; also pass down the gear int    
      if (layers.get(layerSelected).getType() == "SPIRO")
      {
        gearPetals(gears);
      }

      // finally add the rows groups to accordion menu
      gearControls.addItem(cp5.get(Group.class, "row " + row));
    }
    gearAddDeleteReset();
  }

  void gearAddDeleteReset() 
  {
    cp5.addGroup("gears global controls")
    .setBackgroundColor(color(255, 75));
  
    cp5.addButton("gear +")
      .setPosition(5, 5)
      .setSize(50, 10)
      .activateBy(ControlP5.PRESSED)
      .setGroup("gears global controls");
    cp5.addButton("gear -")
      .setPosition(60, 5)
      .setSize(50, 10)
      .activateBy(ControlP5.PRESSED)
      .setGroup("gears global controls");
    gearControls.addItem(cp5.get(Group.class, "gears global controls"));
  }

  void gearPetals(int gear)
  {
    cp5.addSlider("petals " + gear)
      .setGroup( "gear " + gear)
      .setId(gear)
      .setPosition(10, 200)
      .setSize(size2d, 8)
      .setValue(layers.get(layerSelected).getPetals(gear))
      .onChange(new CallbackListener() 
    {
      public void controlEvent(CallbackEvent theEvent) 
      {
        if (theEvent.getAction()==ControlP5.ACTION_BROADCAST) 
        {
          int gear = theEvent.getController().getId();
          int petal = int(theEvent.getController().getValue());
          layers.get(layerSelected).setPetals(gear, petal);
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
      .setValue(layers.get(layerSelected).getRadius(gear).x, layers.get(layerSelected).getRadius(gear).y)
      .setMinMax(-100, -100, 100, 100)
      .onChange(new CallbackListener()
    {
      public void controlEvent(CallbackEvent theEvent) 
      {
        if (theEvent.getAction()==ControlP5.ACTION_BROADCAST)
        {
          int gear = theEvent.getController().getId();
          PVector xy = new PVector(theEvent.getController().getArrayValue(0), theEvent.getController().getArrayValue(1));
          layers.get(layerSelected).setRadius(gear, xy);
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