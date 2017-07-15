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

    controller.mapStart = trackAddSegmentButtonWidth;
    controller.mapEnd = groupWidth;
  }

  /* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   T R A C K   G R O U P   S E T U P 
   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

  void addTrackGroup(String groupKey, ArrayList<String> properties) 
  {
    cp5.addGroup(groupKey)   
      .setId(gui.layerSelected)
      .setBackgroundHeight(properties.size()*50)
      .setBackgroundColor(color(255, 50))
      .setColorForeground(ControlP5.BLUE);

    cp5.addButton("del " + groupKey)
      .setGroup(groupKey)
      .setPosition(0, (properties.size()*50)-15)
      .setSize(40, 15)
      .setCaptionLabel("delete")
      .onClick(new CallbackListener() 
    {
      public void controlEvent(CallbackEvent theEvent) 
      {
        controller.tG.deleteGroup(theEvent.getController().getParent().getName());
      }
    }
    );

    for (int i = 0; i < properties.size(); i++)
    {
      String trackName = groupKey + "    property " + properties.get(i) ;
      cp5.addGroup(trackName)
        .setGroup(groupKey)   
        .setId(buttonPressed)
        .setStringValue(properties.get(i))
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
            track = theEvent.getController().getParent().getName(); // note being passed directly into addTrackSegment() below
            group = theEvent.getController().getParent().getParent().getName();
            String field = theEvent.getController().getParent().getStringValue();
            String property = theEvent.getController().getParent().getStringValue();
            int gear = theEvent.getController().getParent().getId(); 

            controller.tG.createSegment(property, gear, group, field);
          }
        }
      }
      );
    }

    trackControls.addItem(cp5.get(Group.class, groupKey)).open();
  }

  /* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   T R A C K   S E G M E N T   S E T U P 
   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

  void addTrackSegment(String segmentKey, String controllerKey)
  {        
    cp5.addScrollableList(segmentKey)
      .setStringValue(controllerKey)
      .setGroup(track)
      .setId(0)
      .setItems(gif.EasingNames)
      .setPosition(150, 0)
      .setBarHeight(trackHeight)
      .setWidth(500)
      .setCaptionLabel("easings")
      .setOpen(false)     
      .setColorForeground(ControlP5.BLUE)
      .addCallback(new CallbackListener() 
    {
      public void controlEvent(CallbackEvent theEvent) 
      {       
        if (theEvent.getAction() == ControlP5.ACTION_CLICK && controller.tG.edit == true)
        {
          theEvent.getController().bringToFront();
        }  

        if (theEvent.getAction() == ControlP5.ACTION_CLICK && controller.tG.edit == false)
        {
          ScrollableList segment = cp5.get(ScrollableList.class, theEvent.getController().getName());
          segment.setOpen(false);

          if (segment.getId() == 0)
          {
            segment.setId(1);
            segment.setColorForeground(ControlP5.RED); 
            segment.setColorBackground(ControlP5.RED);
          } else {
            segment.setId(0);
            segment.setColor(ControlP5.THEME_CP52014);
            }
        }

        if (theEvent.getAction() == ControlP5.ACTION_ENTER && controller.tG.edit == true)
        {                             
          segmentHoover = true;
          theEvent.getController().setColorForeground(ControlP5.ORANGE);
          theEvent.getController().setColorActive(ControlP5.GREEN);
          String segKey = theEvent.getController().getName();
          controller.tG.segmentActive = cp5.get(ScrollableList.class, segKey);          
          controller.tG.updateSegmentHandler(gui.mouseX);
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
   
   groupType is written in all CAPS and declared with setStringValue()
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
        String groupType = theEvent.getController().getStringValue();
        controller.tG.createGroup(groupType);
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
        String groupType = theEvent.getController().getStringValue() + (theEvent.getController().getId()+1);
        controller.tG.createGroup(groupType);
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