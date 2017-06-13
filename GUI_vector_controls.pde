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

    buttonsAddDelete();
    setGrid();
  }

  /* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   S T A R T  H E R E  xD
   
   slider2d control is added by default
   additional controls can be added per layerType
   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

  void addControlsToGroup(int gear)
  {
    slider2D(gear);   

    switch(getLayerType()) 
    {

    case "SPIRO":

      petals(gear);

      break;

    case "LINES":

      petals(gear);
      connectors(gear);

      break;
    }
  }

  /* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   V E C T O R  C O N T R O L S
   
   when creating new vector controls don't forget to pass down int gear 
   crucially, use it to set the group; .setGroup( "gear " + gear)
   also, remember positioning is relative to the gear group
   
   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

  void slider2D(int gear) 
  {
    vc.addSlider2D("radius x y " + gear+1)
      .setGroup( "gear " + gear)
      .setId(gear)
      .setPosition(10, 5)
      .setSize(size2d, size2d)
      .setValue(layers.get(gui.layerSelected).getVectors(gear).x, layers.get(gui.layerSelected).getVectors(gear).y)
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
          layers.get(gui.layerSelected).setVectors(gear, xy);
        }
      }
    }
    );
  }

  void petals(int gear)
  {  
    Spiro spiro = (Spiro)layers.get(gui.layerSelected);    
    vc.addSlider("petals " + gear)
      .setGroup( "gear " + gear)
      .setId(gear)
      .setPosition(10, 200)
      .setSize(size2d, 8)
      .setValue(spiro.getPetals(gear))
      .setCaptionLabel("petals")
      .onChange(new CallbackListener() 
    {
      public void controlEvent(CallbackEvent theEvent) 
      {
        if (theEvent.getAction()==ControlP5.ACTION_BROADCAST) 
        {    
          Spiro spiro = (Spiro)layers.get(gui.layerSelected);
          int gear = theEvent.getController().getId();
          int petal = int(theEvent.getController().getValue());
          spiro.setPetals(gear, petal);
        }
      }
    }
    );
    vc.getController("petals " + gear).getCaptionLabel().align(CENTER, CENTER);
  }
  
  void connectors(int gear)
  {  
   Lines line = (Lines)layers.get(gui.layerSelected);
    vc.addSlider("connect " + gear)
      .setGroup( "gear " + gear)
      .setId(gear)
      .setPosition(10, 185)
      .setSize(size2d, 8)
      .setValue(line.getConnect(gear))
      .setCaptionLabel("connections")
      .onChange(new CallbackListener() 
    {
      public void controlEvent(CallbackEvent theEvent) 
      {
        if (theEvent.getAction()==ControlP5.ACTION_BROADCAST) 
        {    
          Lines line = (Lines)layers.get(gui.layerSelected);
          int gear = theEvent.getController().getId();
          int connect = int(theEvent.getController().getValue());
          line.setConnect(gear, connect);
        }
      }
    }
    );
    vc.getController("connect " + gear).getCaptionLabel().align(CENTER, CENTER);
  }


  /* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   G L O B A L  V E C T O R  C O N T R O L S
   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

  void buttonsAddDelete() 
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
        layer(lock);
        int newGear = layers.get(gui.layerSelected).getNumberOfVectors()+1;
        layers.get(gui.layerSelected).setNumberOfVectors(newGear);
        layers.get(gui.layerSelected).addVectors();        
        setColsRows(newGear-1); 
        layer(lock);
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
        if (layers.get(gui.layerSelected).getNumberOfVectors() > 0)
        {
          layer(lock);
          int delGear = layers.get(gui.layerSelected).getNumberOfVectors()-1;
          layers.get(gui.layerSelected).setNumberOfVectors(delGear);
          layers.get(gui.layerSelected).deleteVectors(delGear); 
          removeRows(delGear);
          layer(lock);
        }
      }
    }
    );
    ;
  }

  /* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   G R I D  H A N D L E R S
   call setGrid when dealing with layer 
   otherwise, use setColsRows
   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

  void setGrid()
  {
    for (int i = 0; i < layers.get(gui.layerSelected).getNumberOfVectors(); i++)
    {
      setColsRows(i);
    }
  }

  void setColsRows(int gear)
  {
    col+=1;

    if (col == 4)
    {
      col = 0;
    }

    if (col == 0)
    {
      row+=1;
      addRows();
    }

    addSingleGroup(gear);
  }

  void addRows() 
  {
    vc.addGroup("row " + row)
      .setBackgroundHeight(rowHeight)
      .setBackgroundColor(color(255, 50));
    gearControls.addItem(vc.get(Group.class, "row " + row));
  }

  void removeRows(int del)
  {
    removeSingleGroup(del);
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

  void addSingleGroup(int gears) 
  {
    vc.addGroup("gear " + gears)
      .setPosition(10+col*(size2d+30), 15)
      .setSize(size2d+20, size2d+75)
      .setGroup(vc.get(Group.class, "row " + row))
      .setCaptionLabel("gear " + (gears+1))
      .setBackgroundColor(color(255, 75))
      .disableCollapse();

    addControlsToGroup(gears);
  }

  void removeSingleGroup(int del)
  {
    gearControls.removeItem(gui.cp5.get(Group.class, "gear " + del));
    gui.cp5.get(Group.class, "gear " + del).remove();
  }
}