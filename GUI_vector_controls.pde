class GUI_vector_controls
{
  ControlP5 vc;
  Accordion gearControls;
  int row = -1;
  int col = -1;
  int size2d = 150;
  int rowHeight = size2d + 100;

  GUI_vector_controls(ControlP5 cp5)
  {    
    vc = cp5;
    gearControls = vc.addAccordion("GC")
      .setPosition(5, 5)
      .setWidth(730)
      .setCollapseMode(Accordion.SINGLE);

    gearAddDeleteReset();
    gearsSetGrid();
  }

  void gearsSetGrid()
  {
    for (int i = 0; i < layers.get(gui.layerSelected).getNumberOfGears(); i++)
    {
      gearsColRow(i);
    }
  }

  void gearsColRow(int gear)
  {
    col+=1;

    if (col == 4)
    {
      col = 0;
    }

    if (col == 0)
    {
      row+=1;
      gearNewRow();
    }

    gearSingleGroup(gear);
  }

  void gearNewRow() {
    vc.addGroup("row " + row)
      .setBackgroundHeight(rowHeight)
      .setBackgroundColor(color(255, 50));
    gearControls.addItem(vc.get(Group.class, "row " + row));
  }

  void gearSingleGroup(int gears) {
    vc.addGroup("gear " + gears)
      .setPosition(10+col*(size2d+30), 15)
      .setSize(size2d+20, size2d+75)
      .setGroup(vc.get(Group.class, "row " + row))
      .setCaptionLabel("gear " + (gears+1))
      .setBackgroundColor(color(255, 75))
      .disableCollapse();

    // slider2d is default for vectors
    gearSlider2D(gears); 
    // for addition controls we first check the layer type
    gearCheckLayerType(gears);
  }

  void gearCheckLayerType(int gears)
  {
    // additional vector controls to gear groups to be added here

    String type = layers.get(gui.layerSelected).getType();

    switch(type) 
    {
    case "SPIRO" :  
      gearPetals(gears);
      break;
    case "TEST" :  
      break;
    }
  }

  void gearAddDeleteReset() 
  {
    vc.addGroup("gears global controls")
      .setBackgroundColor(color(255, 75))
      .disableCollapse()
      .setPosition(740, 15)
      .setSize(105, 50);

    vc.addButton("gear +")
      .setPosition(0, 5)
      .setSize(50, 10)
      .setGroup("gears global controls")
      .setCaptionLabel("Add")
      .onClick(new CallbackListener() 
    {
      public void controlEvent(CallbackEvent theEvent) 
      {
        layerLock(Lock);
        int newGear = layers.get(gui.layerSelected).getNumberOfGears()+1;
        layers.get(gui.layerSelected).setNumberOfGears(newGear);
        layers.get(gui.layerSelected).newVectors();        
        gearsColRow(newGear-1); 
        layerLock(Lock);
      }
    }
    );

    vc.addButton("gear -")
      .setPosition(55, 5)
      .setSize(50, 10)
      .setGroup("gears global controls")
      .setCaptionLabel("Delete")
      .onClick(new CallbackListener() 
    {
      public void controlEvent(CallbackEvent theEvent) 
      {
        if (layers.get(gui.layerSelected).getNumberOfGears() > 0)
        {
          layerLock(Lock);
          //col-=1;
          int delGear = layers.get(gui.layerSelected).getNumberOfGears()-1;
          layers.get(gui.layerSelected).setNumberOfGears(delGear);
          layers.get(gui.layerSelected).deleteVectors(delGear); 
          //gearRemoveGroup(delGear);
          gearRemoveColRow(delGear);
          layerLock(Lock);
        }
      }
    }
    );
    ;
  }

  void gearRemoveColRow(int del)
  {
    gearRemoveGroup(del);
    if (col == 0)
    {
      col = 3;
      gearControls.removeItem(gui.cp5.get(Group.class, "row " + row));
      gui.cp5.get(Group.class, "row " + row).remove();
      row-=1;
    } else 
    {
      col-=1;
    }
  }

  void gearRemoveGroup(int del)
  {
    gearControls.removeItem(gui.cp5.get(Group.class, "gear " + del));
    gui.cp5.get(Group.class, "gear " + del).remove();
  }

  void gearPetals(int gear)
  {
    vc.addSlider("petals " + gear)
      .setGroup( "gear " + gear)
      .setId(gear)
      .setPosition(10, 200)
      .setSize(size2d, 8)
      .setValue(layers.get(gui.layerSelected).getPetals(gear))
      .setCaptionLabel("petals")
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
    vc.addSlider2D("radius x y " + gear+1)
      .setGroup( "gear " + gear)
      .setId(gear)
      .setPosition(10, 5)
      .setSize(size2d, size2d)
      .setValue(layers.get(gui.layerSelected).getRadius(gear).x, layers.get(gui.layerSelected).getRadius(gear).y)
      .setMinMax(-100, -100, 100, 100)
      .setCaptionLabel("radius x y ")
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