class GUI_trackGroup
{
  ControlP5 cp5;
  Accordion trackControls;
  int groupHeight = 128;
  int groupWidth = 730;
  int trackHeight = 20;
  int trackOffset = 5;
  int trackAddSegmentButtonWidth = 15;
  int trackStart = trackOffset + trackAddSegmentButtonWidth;
  int trackEnd = trackOffset + groupWidth;
  int yPos = 0;
  int col = 0;  
  int buttonPressed; // used to retrieve gearNo for controller, -1 when not applicable
  String track, group;
  boolean segmentHoover = false;

  GUI_trackGroup(ControlP5 tg)  
  {    
    cp5 = tg;
    trackControls = cp5.addAccordion("TC")
      .setPosition(trackOffset, 256+20)
      .setWidth(groupWidth)
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
      .setBackgroundColor(color(255, 50))
      .setColorForeground(ControlP5.BLUE);

    cp5.addButton("del " + tgName)
      .setGroup(tgName)
      .setPosition(0, (properties.size()*50)-15)
      .setSize(40, 15)
      .setCaptionLabel("delete")
      .onClick(new CallbackListener() 
    {
      public void controlEvent(CallbackEvent theEvent) 
      {
        controller.tG.deleteGroup(theEvent.getController().getParent().toString());
      }
    }
    );

    for (int i = 0; i < properties.size(); i++)
    {
      String trackName = "property " + properties.get(i) + " " +  tgName;
      cp5.addGroup(trackName)
        .setGroup(tgName)   
        .setId(buttonPressed)
        .setStringValue(property)
        .setPosition(0, 20+(40*i))
        .setWidth(groupWidth)
        .setHeight(0)
        .setBackgroundHeight(trackHeight)
        .setBackgroundColor(color(255, 50))
        .setCaptionLabel(properties.get(i))
        .disableCollapse();

      cp5.getGroup(trackName).getCaptionLabel().align(ControlP5.LEFT, ControlP5.TOP_OUTSIDE);

      cp5.addButton("segment " + trackName)
        .setCaptionLabel("+")
        .setStringValue(properties.get(i))
        .setId(i)
        .setGroup(trackName)
        .setPosition(0, 0)
        .setSize(trackAddSegmentButtonWidth, trackHeight)
        .onClick(new CallbackListener() 
      {
        public void controlEvent(CallbackEvent theEvent) 
        {
          if (controller.tG.edit == true)
          {
            group = theEvent.getController().getParent().getParent().getName();
            track = theEvent.getController().getParent().getName();
            int gear = theEvent.getController().getParent().getId(); 
            int layer = theEvent.getController().getParent().getParent().getId();
            String property = theEvent.getController().getParent().getStringValue();
            int propertyIndex = theEvent.getController().getId();
            String field = theEvent.getController().getStringValue();
            controller.tG.createSegment(layer, property, propertyIndex, gear, group, field);
          }
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


  /* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   T R A C K   S E G M E N T   S E T U P 
   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

  void addTrackSegment(String segmentKey, int segmentId, String field)
  {        
    cp5.addScrollableList(segmentKey)
      .setStringValue(field)
      .setId(segmentId)
      .setGroup(track)
      .setItems(gif.EasingNames)
      .setPosition(150, 0)
      .setBarHeight(trackHeight)
      .setWidth(500)
      .setCaptionLabel("easings")
      .setOpen(false)     
      .setColorForeground(ControlP5.TEAL)
      .addCallback(new CallbackListener() 
    {
      public void controlEvent(CallbackEvent theEvent) 
      {       
        if (theEvent.getAction() == ControlP5.ACTION_CLICK)
        {
          theEvent.getController().bringToFront();
          //int easing= int(theEvent.getController().getValue());
          //String segKey = theEvent.getController().getStringValue();
          //gif.setAniEasing(easing, segKey);
        }    

        if (theEvent.getAction() == ControlP5.ACTION_ENTER && controller.tG.edit == true)
        {                             
          segmentHoover = true;
          theEvent.getController().setColorForeground(ControlP5.ORANGE);
          theEvent.getController().setColorActive(ControlP5.GREEN);
          String segKey = theEvent.getController().getName().toString();
          controller.tG.segmentActive = cp5.get(ScrollableList.class, segKey);
          controller.tG.updateSegmentHandler(gui.mouseX);
          controller.tG.segmentChanged(segKey, 0);
        }
        if (theEvent.getAction() == ControlP5.ACTION_LEAVE)
        {
          segmentHoover = false;
        }
      }
    }
    );
  }


  /* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   G L O B A L  T R A C K  C O N T R O L S
   additional trackGroups can be added here
   
   trackGroup buttons need add..() & del..() methods,
   which in turn need to be added to addMenu() & delMenu() below
     
   trackGroup name is written in all CAPS and declared with setStringValue()
   use getStringValue() to pass it down to controller on callback  
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
        controller.tG.createGroup(theEvent.getController().getStringValue());
      }
    }
    );
  }

  void delColorTrackButton()
  {
    cp5.get(Button.class, "color").remove();
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
        controller.tG.createGroup(theEvent.getController().getStringValue());
      }
    }
    );

    col+=1;
  }

  void delGearTrackButtons(int g)
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
   
   N O T E: at present there is no layerType switch case yet 
   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

  void addMenu()
  {
    addColorTrackButton();

    for (int g = 0; g < layers.get(gui.layerSelected).getNumberOfGears(); g++)
    {
      addGearTrackButtons(g);
    }
  }

  void delMenu()
  {
    delColorTrackButton();

    for (int i = layers.get(gui.layerSelected).getNumberOfGears()-1; i >= 0; i--)
    {
      delGearTrackButtons(i);
    }
  }

  void menuTrackGroup()
  {
    cp5.addGroup("menuTrackGroups")
      .setCaptionLabel("Track Groups")
      .setPosition(gui.rPaneXpos, 256+30)
      .setSize(gui.rPaneWidth, 150)
      .setBackgroundColor(color(255, 50))
      .setColorForeground(ControlP5.BLUE)
      .disableCollapse()
      .setOpen(true);
  }
}