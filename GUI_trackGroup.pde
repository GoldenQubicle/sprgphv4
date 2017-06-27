class GUI_trackGroup
{
  ControlP5 cp5;
  Accordion trackControls;
   int trackGroupHeight = 128;
  int trackGroupWidth = 730;
  int trackHeight = 20;
  int trackWidth = 705;
  int yPos = 0;
  int col = 0;  
  int buttonPressed; // used for gearNo, -1 when not applicable

  GUI_trackGroup(ControlP5 tg)  
  {    
    cp5 = tg;
    trackControls = cp5.addAccordion("TC")
      .setPosition(5, 256+20)
      .setWidth(trackGroupWidth)
      .setCollapseMode(Accordion.SINGLE);

    menuTrackGroup();
    addMenu();
  }


  /* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   T R A C K   G R O U P   S E T U P 
   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

  void addTrackGroup(String tgName, StringList properties, String property) 
  {
    cp5.addGroup(tgName)   
      .setId(gui.layerSelected)
      .setBackgroundHeight(properties.size()*50)
      .setBackgroundColor(color(255, 50));

    cp5.addButton("del " + tgName)
      .setGroup(tgName)
      .setPosition(0, (properties.size()*50)-15)
      .setSize(40, 15)
      .setCaptionLabel("delete")
      .onClick(new CallbackListener() 
    {
      public void controlEvent(CallbackEvent theEvent) 
      {
        controller.deleteTrackGroup(theEvent.getController().getParent().toString());
      }
    }
    );

    for (int i = 0; i < properties.size(); i++)
    {
      String track = "track " + properties.get(i) + " " +  tgName;
      cp5.addGroup(track)
        .setGroup(tgName)   
        .setId(buttonPressed)
        .setStringValue(property)
        .setPosition(0, 20+(40*i))
        .setSize(trackGroupWidth, 15)
        .setBackgroundHeight(trackHeight)
        .setBackgroundColor(color(255, 50))
        .setCaptionLabel(properties.get(i))
        .disableCollapse();

      cp5.addButton("segment " + track)
        .setCaptionLabel("+")
        .setId(i)
        .setGroup(track)
        .setPosition(0, 0)
        .setSize(15, trackHeight)
        .onClick(new CallbackListener() 
      {
        public void controlEvent(CallbackEvent theEvent) 
        {
          int gear = theEvent.getController().getParent().getId(); 
          int layer = theEvent.getController().getParent().getParent().getId();
          String property = theEvent.getController().getParent().getStringValue();
          int propertyIndex = theEvent.getController().getId();
          // function to add segments
          controller.createAniSegment(layer, property, propertyIndex, gear);
        }
      }
      );
    }

    if (property.equals("GEAR"))
    {
      cp5.getGroup(tgName).setCaptionLabel(tgName + " " + (buttonPressed+1));
    }

    trackControls.addItem(cp5.get(Group.class, tgName)).open();
  }

  void addTrackSegment(int layer, int prop)
  {
  }


  /* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   G L O B A L  T R A C K  C O N T R O L S
   additional trackGroups added to menu here
   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

  void addColorTrackButton()
  {
    cp5.addButton("color")
      .setStringValue("COLOR")
      .setId(-1)
      .setPosition(2, 2)
      .setSize(45, 10)
      .setGroup("menuTrackGroups")
      .onClick(new CallbackListener() 
    {
      public void controlEvent(CallbackEvent theEvent) 
      {
        buttonPressed = theEvent.getController().getId();
        controller.createTrackGroup(theEvent.getController().getStringValue());
      }
    }
    );
  }

  void addGearTrackButtons(int g)
  {    
    if (g%2 == 0)
    {
      yPos+=15; 
      col = 0;
    }    

    cp5.addButton("tG gear " + (g+1))      
      .setStringValue("GEAR")
      .setId(g)
      .setPosition((50*col)+2, yPos)
      .setSize(45, 10)
      .setGroup("menuTrackGroups")
      .setCaptionLabel("gear " + (g+1))
      .onClick(new CallbackListener() 
    {
      public void controlEvent(CallbackEvent theEvent) 
      {
        buttonPressed = theEvent.getController().getId();
        controller.createTrackGroup(theEvent.getController().getStringValue());
      }
    }
    );

    col+=1;
  }

  void removeGearTrackButtons(int g)
  {
    if (g%2 == 0)
    {
      yPos-=15;
      col = 1;
    }
    if (col > 1)
    {
      col-=1;
    }

    cp5.get(Button.class, "tG gear " + (g+1)).remove();
  }


  /* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   T R A C K G R O U P  S I D E  M E N U    
   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

  void menuTrackGroup()
  {
    cp5.addGroup("menuTrackGroups")
      .setCaptionLabel("Track Groups")
      .setPosition(gui.rPaneXpos, 256+30)
      .setSize(gui.rPaneWidth, 150)
      .setBackgroundColor(color(255, 50))
      .setOpen(true);
  }

  void delMenu()
  {
    deleteColorTrackButton();

    for (int i = layers.get(gui.layerSelected).getNumberOfGears()-1; i >= 0; i--)
    {
      removeGearTrackButtons(i);
    }
  }

  void addMenu()
  {
    addColorTrackButton();

    for (int g = 0; g < layers.get(gui.layerSelected).getNumberOfGears(); g++)
    {
      addGearTrackButtons(g);
    }
  }

  void deleteColorTrackButton()
  {
    cp5.get(Button.class, "color").remove();
  }
}