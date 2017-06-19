class GUI_gearGroup
{
  ControlP5 cp5;
  Accordion gearControls;
  int row = -1;
  int col = -1;
  int size2d = 150;
  int rowHeight = size2d + 100;

  GUI_gearGroup(ControlP5 gg)
  {    
    cp5 = gg;
    gearControls = cp5.addAccordion("GC")
      .setPosition(5, 5)
      .setWidth(730)
      .setCollapseMode(Accordion.SINGLE);

    buttonsAddDelete();
    setGrid();
  }

  /* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   S T A R T  H E R E  xD
   
   slider2d control is added by default to gear
   additional property controls can be added per layerType
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

    case "SPIRO3D":

      petals(gear);
      zSlider3D(gear);

      break;
    }
  }

  /* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   P R O P E R T I E S  C O N T R O L S
   
   when creating new properties controls don't forget positioning is relative to group 
   
   pass down gear int and use it to set the group; 
   .setGroup( "gear " + gear)
   
   cast layer to lType to access their property methods;
   layerType layer = (layerType)layers.get(gui.layerSelected);    
   
   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

  void slider2D(int gear) 
  {
    cp5.addSlider2D("radius x y " + gear+1)
      .setGroup( "gear " + gear)
      .setId(gear)
      .setPosition(10, 5)
      .setSize(size2d, size2d)
      .setValue(layers.get(gui.layerSelected).getGearVectors(gear).x, layers.get(gui.layerSelected).getGearVectors(gear).y)
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
          layers.get(gui.layerSelected).setGearVectors(gear, xy);
        }
      }
    }
    );
  }

  void zSlider3D(int gear)
  {
    cp5.addSlider("z" + gear)
      .setGroup( "gear " + gear)
      .setId(gear)
      .setPosition(10, 180)
      .setSize(size2d, 8)
      .setRange(-100, 100)
      .setValue(layers.get(gui.layerSelected).getGearVectors(gear).z)
      .setCaptionLabel("z depth")
      .onChange(new CallbackListener() 
    {
      public void controlEvent(CallbackEvent theEvent) 
      {
        if (theEvent.getAction()==ControlP5.ACTION_BROADCAST) 
        {
          Spiro3D layer3d = (Spiro3D)layers.get(gui.layerSelected);
          int gear = theEvent.getController().getId();
          float z = theEvent.getController().getValue();
          layer3d.setZDepth(gear, z);
        }
      }
    }
    );
    cp5.getController("z" + gear).getCaptionLabel().align(CENTER, CENTER);
    cp5.get(Slider.class, "petals " + gear).setRange(0, 20).getCaptionLabel().align(CENTER, CENTER);
  }

  void petals(int gear)
  {  
    Spiro spiro = (Spiro)layers.get(gui.layerSelected);    
    cp5.addSlider("petals " + gear)
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
    cp5.getController("petals " + gear).getCaptionLabel().align(CENTER, CENTER);
  }

  void connectors(int gear)
  {  
    Lines line = (Lines)layers.get(gui.layerSelected);
    cp5.addSlider("connect " + gear)
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
    cp5.getController("connect " + gear).getCaptionLabel().align(CENTER, CENTER);
  }



  /* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   G L O B A L  G E A R  C O N T R O L S
   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

  void buttonsAddDelete() 
  {
    cp5.addGroup("gears global controls")
      .setBackgroundColor(color(255, 75))
      .disableCollapse()
      .setPosition(gui.rPaneXpos, 15)
      .setSize(gui.rPaneWidth, 50);    

    cp5.addButton("gear +")
      .setPosition(0, 5)
      .setSize(50, 10)
      .setGroup("gears global controls")
      .setCaptionLabel("Add")
      .onClick(new CallbackListener() 
    {
      public void controlEvent(CallbackEvent theEvent) 
      {
        layer(lock);
        int newGear = layers.get(gui.layerSelected).getNumberOfGears()+1;
        layers.get(gui.layerSelected).setNumberOfGears(newGear);
        layers.get(gui.layerSelected).addGears();        
        setColsRows(newGear-1); 
        layer(lock);
      }
    }
    );

    cp5.addButton("gear -")
      .setPosition(55, 5)
      .setSize(50, 10)
      .setGroup("gears global controls")
      .setCaptionLabel("Delete")
      .onClick(new CallbackListener() 
    {
      public void controlEvent(CallbackEvent theEvent) 
      {
        if (layers.get(gui.layerSelected).getNumberOfGears() > 1)
        {
          layer(lock);
          int del = layers.get(gui.layerSelected).getNumberOfGears()-1;
          layers.get(gui.layerSelected).setNumberOfGears(del);
          layers.get(gui.layerSelected).deleteGears(del);        
          removeColsRows(del);
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
    for (int i = 0; i < layers.get(gui.layerSelected).getNumberOfGears(); i++)
    {
      setColsRows(i);
    }
  }

  void delGrid()
  {
    for (int i = layers.get(gui.layerSelected).getNumberOfGears()-1; i >= 0; i--)
    {
      removeColsRows(i);
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

  void removeColsRows(int del)
  {
    removeSingleGroup(del);

    if (col == 0)
    {
      col = 3;
      removeRows();
      row-=1;
    } else 
    {
      col-=1;
    }
  }

  void addRows() 
  {
    cp5.addGroup("row " + row)
      .setBackgroundHeight(rowHeight)
      .setBackgroundColor(color(255, 50));
    gearControls.addItem(cp5.get(Group.class, "row " + row)).open(row);
  }

  void removeRows()
  {
    gearControls.removeItem(gui.cp5.get(Group.class, "row " + row));
    gui.cp5.get(Group.class, "row " + row).remove();
  }

  void addSingleGroup(int gears) 
  {
    cp5.addGroup("gear " + gears)
      .setPosition(10+col*(size2d+30), 15)
      .setSize(size2d+20, size2d+75)
      .setGroup(cp5.get(Group.class, "row " + row))
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