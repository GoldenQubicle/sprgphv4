class GUI_vector_controls
{
  ControlP5 vc;
  Accordion gearControls;
  int row = -1;
  int col = -1;

  GUI_vector_controls(ControlP5 cp5)
  {    
    vc = cp5;
    gearControls = vc.addAccordion("GC")
      .setPosition(5, 5)
      .setWidth(730)
      .setCollapseMode(Accordion.MULTI);
    gearGroups(gui.layerSelected);
  }

  void gearSingleGroup(int gears) {
    vc.addGroup("gear " + gears)
      .setPosition(10+col*(gui.size2d+30), 15)
      .setSize(gui.size2d+20, gui.size2d+75)
      .setGroup(vc.get(Group.class, "row " + row))
      .setCaptionLabel("gear " + (gears+1))
      .setBackgroundColor(color(255, 75))
      .disableCollapse();
  }

  void gearGroups(int ls)
  {
    gui.layerSelected = ls;
    //int row = -1;
    //int rowHeight = gui.size2d + 100;

    for (int gears = 0; gears < layers.get(gui.layerSelected).getNumberOfGears(); gears++)    
    {
      col = gearGridColRow(gears)[0];
      gearNewRow(gears);
      gearSingleGroup(gears);
      //  for now we ALWAYS create vector controls - hence the add & delete buttons are created as well below
      //  specifically, create one new gear group per vector and add it to the proper row group
      //  then call the gearSlider2D method to create the controls and add it to gear group 


      gearSlider2D(gears);

      // here we check the layer type and can create additional controls based off that
      // dont forget to set the control group by adding; .setGroup( "gear " + gear) ; also pass down the gear int    
      if (layers.get(gui.layerSelected).getType() == "SPIRO")
      {
        gearPetals(gears);
      }

      // add the rows groups to accordion menu
      gearControls.addItem(vc.get(Group.class, "row " + row));
    }
    gearAddDeleteReset();
  }

  int [] gearGridColRow(int gN)
  {
    int [] colrow = new int [2];
    colrow[0] = gN%4 ;    
    colrow[1] = gN/4;
    return colrow;
  }

  void gearNewRow(int gears) {
    int rowHeight = gui.size2d + 100;

    if (row != gearGridColRow(gears)[1])
    {
      row = gearGridColRow(gears)[1];
      vc.addGroup("row " + row)
        .setBackgroundHeight(rowHeight)
        .setBackgroundColor(color(255, 50));
      gearControls.addItem(vc.get(Group.class, "row " + row));
    };
  }

  void gearAddDeleteReset() 
  {
    vc.addGroup("gears global controls")
      .setBackgroundColor(color(255, 75));

    vc.addButton("gear +")
      .setPosition(5, 5)
      .setSize(50, 10)
      .setGroup("gears global controls")
      .onClick(new CallbackListener() 
    {
      public void controlEvent(CallbackEvent theEvent) 
      {
        layerLock(Lock);
        int newGear = layers.get(gui.layerSelected).getNumberOfGears()+1;
        layers.get(gui.layerSelected).setNumberOfGears(newGear);
        layers.get(gui.layerSelected).newVectors();
        println(gearGridColRow(newGear), row);
        gearSingleGroup(newGear);

        gearSlider2D(newGear-1);
        gearPetals(newGear-1);
        gearNewRow(newGear);
        gearControls.updateItems();
        layerLock(Lock);
      }
    }
    );

    vc.addButton("gear -")
      .setPosition(60, 5)
      .setSize(50, 10)
      .setGroup("gears global controls");
    gearControls.addItem(vc.get(Group.class, "gears global controls"));
  }

  void gearPetals(int gear)
  {
    vc.addSlider("petals " + gear)
      .setGroup( "gear " + gear)
      .setId(gear)
      .setPosition(10, 200)
      .setSize(gui.size2d, 8)
      .setValue(layers.get(gui.layerSelected).getPetals(gear))
      .onChange(new CallbackListener() 
    {
      public void controlEvent(CallbackEvent theEvent) 
      {
        if (theEvent.getAction()==ControlP5.ACTION_BROADCAST) 
        {
          int gear = theEvent.getController().getId();
          int petal = int(theEvent.getController().getValue());
          layers.get(gui.layerSelected).setPetals(gear, petal);
        }
      }
    }
    );
    vc.getController("petals " + gear).getCaptionLabel().align(CENTER, CENTER);
  }

  void gearSlider2D(int gear) 
  {
    vc.addSlider2D("radius x y " + gear)
      .setGroup( "gear " + gear)
      .setId(gear)
      .setPosition(10, 5)
      .setSize(gui.size2d, gui.size2d)
      .setValue(layers.get(gui.layerSelected).getRadius(gear).x, layers.get(gui.layerSelected).getRadius(gear).y)
      .setMinMax(-100, -100, 100, 100)
      .onChange(new CallbackListener()
    {
      public void controlEvent(CallbackEvent theEvent) 
      {
        if (theEvent.getAction()==ControlP5.ACTION_BROADCAST)
        {
          int gear = theEvent.getController().getId();
          PVector xy = new PVector(theEvent.getController().getArrayValue(0), theEvent.getController().getArrayValue(1));
          layers.get(gui.layerSelected).setRadius(gear, xy);
        }
      }
    }
    );
  }
}