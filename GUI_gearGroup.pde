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
    addToGlobalGearGroup();
    setGrid();
  }

  /* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   S T A R T  H E R E  xD
   
   slider2d control is added by default to gear
   additional property controls can be added per layerType
   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

  void addToGearGroup(int gear)
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

    case "MESH":

      petals(gear);

      break;
    }
  }

  void addToGlobalGearGroup()
  {
    // pls note this will probably fall over on layerswitching
    // 1 7 nope is just not doing anything atm
    switch(getLayerType()) 
    {
    case "MESH":

      meshRadius();

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
    cp5.addSlider2D("radius x y " + (gear+1))
      .setGroup( "gear " + gear)
      .setId(gear)
      .setStringValue("GEAR")
      .setPosition(10, 5)
      .setSize(size2d, size2d)
      .setValue(layers.get(gui.layerSelected).getGearVectors(gear).x, layers.get(gui.layerSelected).getGearVectors(gear).y)
      .setMinMax(-100, -100, 100, 100)
      .setCaptionLabel("radius x y ")
      .setColorForeground(ControlP5.BLUE)
      .setColorActive(ControlP5.ORANGE)
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
      .setStringValue("GEAR")
      .setPosition(10, 180)
      .setSize(size2d, 8)
      .setRange(-100, 100)
      .setValue(layers.get(gui.layerSelected).getGearVectors(gear).z)
      .setCaptionLabel("z depth")
      .setColorForeground(ControlP5.BLUE)
      .setColorActive(ControlP5.ORANGE)
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
      .setStringValue("GEAR")
      .setPosition(10, 200)
      .setSize(size2d, 8)
      .setValue(spiro.getPetals(gear))
      .setCaptionLabel("petals")
      .setColorForeground(ControlP5.BLUE)
      .setColorActive(ControlP5.ORANGE)
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
      .setStringValue("GEAR")
      .setPosition(10, 185)
      .setSize(size2d, 8)
      .setValue(line.getConnect(gear))
      .setCaptionLabel("connections")
      .setColorForeground(ControlP5.BLUE)
      .setColorActive(ControlP5.ORANGE)
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
      .setSize(gui.rPaneWidth, 100)
      .setColorForeground(ControlP5.BLUE);    

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
        gui.tg.addGearTrackButtons(newGear-1);
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
          gui.tg.delGearTrackButtons(del);   
          controller.tG.deleteGearTrackGroup(del);
          layer(lock);
        }
      }
    }
    );
    ;
  }

  /* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   C U S T O M   L A Y E R T Y P E 
   G L O B A L   C O N T R O L S
   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

  void meshRadius()
  {
    Slider [] meshRadii = new Slider[3];
    Mesh layer = (Mesh)layers.get(gui.layerSelected);

    meshRadii[0] = cp5.addSlider("meshXr")
      .setGroup("gears global controls")
      .setPosition(0, 25)
      .setSize(gui.rPaneWidth, 10)
      .setValue(layer.getMeshRadius().x)
      .setId(0)
      .setColorForeground(ControlP5.BLUE)
      .setColorActive(ControlP5.ORANGE);

    meshRadii[1] = cp5.addSlider("meshYr")
      .setGroup("gears global controls")
      .setPosition(0, 40)
      .setSize(gui.rPaneWidth, 10)
      .setValue(layer.getMeshRadius().y)
      .setId(1)
      .setColorForeground(ControlP5.BLUE)
      .setColorActive(ControlP5.ORANGE);

    meshRadii[2]  = cp5.addSlider("meshZr")
      .setGroup("gears global controls")
      .setPosition(0, 55)
      .setSize(gui.rPaneWidth, 10)
      .setValue(layer.getMeshRadius().z)
      .setId(2)
      .setColorForeground(ControlP5.BLUE)
      .setColorActive(ControlP5.ORANGE);

    cp5.getController("meshXr").getCaptionLabel().align(CENTER, CENTER);
    cp5.getController("meshYr").getCaptionLabel().align(CENTER, CENTER);
    cp5.getController("meshZr").getCaptionLabel().align(CENTER, CENTER);

    // so actually what is labeled x controls the z space
    // the other two. . kinda weird to call it x & y but yeah, they do something else 
    // basically: because origin of the rings is in x&y, and then gets translated
    // the controls are a bit cross wired

    for (Slider radius : meshRadii)
    {
      radius.addCallback(new CallbackListener() 
      {
        public void controlEvent(CallbackEvent theEvent) 
        {
          if (theEvent.getAction()==ControlP5.ACTION_BROADCAST)
          {
            Mesh layer = (Mesh)layers.get(gui.layerSelected);
            Slider radi = cp5.get(Slider.class, theEvent.getController().getName());           

            if (radi.getId() == 0 )
            {
              layer.setMeshRadius(radi.getValue(), layer.getMeshRadius().y, layer.getMeshRadius().z );
            }

            if (radi.getId() == 1 )
            {
              layer.setMeshRadius(layer.getMeshRadius().x, radi.getValue(), layer.getMeshRadius().z );
            }

            if (radi.getId() == 2 )
            {
              layer.setMeshRadius(layer.getMeshRadius().x, layer.getMeshRadius().y, radi.getValue() );
            }
          }
        }
      }
      );
    }
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

    addGearGroup(gear);
  }

  void removeColsRows(int del)
  {
    removeGearGroup(del);

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
      .setBackgroundColor(color(255, 50))
      .setColorForeground(ControlP5.BLUE);
    gearControls.addItem(cp5.get(Group.class, "row " + row)).open(row);
  }

  void removeRows()
  {
    gearControls.removeItem(gui.cp5.get(Group.class, "row " + row));
    gui.cp5.get(Group.class, "row " + row).remove();
  }

  void addGearGroup(int gears) 
  {
    cp5.addGroup("gear " + gears)
      .setPosition(10+col*(size2d+30), 15)
      .setSize(size2d+20, size2d+75)
      .setGroup(cp5.get(Group.class, "row " + row))
      .setCaptionLabel("gear " + (gears+1))
      .setBackgroundColor(color(255, 75))
      .setColorForeground(ControlP5.BLUE)
      .disableCollapse();

    addToGearGroup(gears);
  }

  void removeGearGroup(int del)
  {
    gearControls.removeItem(gui.cp5.get(Group.class, "gear " + del));
    gui.cp5.get(Group.class, "gear " + del).remove();
  }
}