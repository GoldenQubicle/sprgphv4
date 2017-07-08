class GUI_trackGroup_Controller
{
  Map<String, Group> groups = new HashMap<String, Group>();
  Map<String, ScrollableList> segments = new HashMap<String, ScrollableList>();
  IntDict aniUpdate = new IntDict();
  int segment;
  StringList editModes = new StringList("asOne", "left", "right");
  String editMode = editModes.get(0);
  boolean edit = true;
  float segMouseEnter, segWidth, segStart;
  ScrollableList segmentActive;

  GUI_trackGroup_Controller() 
  {
  }

  /* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   R E F A C T O R   T H I S   S H I T  
   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

  // this needs to be repurposed to something like segmentSelected
  // and used to perform matching stringValue with active controllers
  // this takes place in main controller
  void segmentChanged(String segmentKey, int flag)
  {
    if (!aniUpdate.hasKey(segmentKey))
    {
      aniUpdate.add(segmentKey, flag);
    }
    if (flag == 1)
    {
      aniUpdate.set(segmentKey, flag);
    }
  }

  void createSegment(int layer, String property, int propertyIndex, int gear, String trackgroup, String field)
  {
    segment+=1;
    String trackSegment = trackgroup +  "    gearNo:" + gear +  "    property:" + propertyIndex + "    segment:" + segment;
    gui.tg.addTrackSegment(trackSegment, segment, field);
    segments.put(trackSegment, gui.cp5.get(ScrollableList.class, trackSegment));
    // call main controller for ani creation
    // dont forget delete segment below will also need to make a direct call 
  }

  /* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   S E G M E N T  H A N D L E R   
   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

  void segmentHandler()
  {
    float delta = segMouseEnter-gui.mouseX;
    switch(editMode) 
    {  
    case "asOne" :
      float newStart = constrain((segStart-delta), gui.tg.trackAddSegmentButtonWidth, gui.tg.groupWidth-segmentActive.getWidth());
      segmentActive.setPosition(newStart, segmentActive.getPosition()[1]); 
      break;

    case "left" :
      float newStart2 = constrain((segStart-delta), gui.tg.trackAddSegmentButtonWidth, gui.tg.groupWidth);
      segmentActive.setPosition(newStart2, segmentActive.getPosition()[1]);
      if (segmentActive.getPosition()[0] > 15)
      {
        segmentActive.setWidth(int(segWidth+delta));
      }
      break;

    case "right" :
      float newWidth = constrain((segWidth-delta), 0, gui.tg.groupWidth-segStart);
      segmentActive.setWidth(int(newWidth));
      break;
    }

    if (gui.keyPressed == true && gui.key == DELETE)
    {     
      segmentChanged(segmentActive.getName(), 1);
      gui.cp5.getController(segmentActive.getName()).remove();
    }
  }

  void updateSegmentHandler(float mousePos)
  {
    if (!segments.isEmpty()) {
      segWidth = segmentActive.getWidth();
      segStart = segmentActive.getPosition()[0];
      segMouseEnter = mousePos;
    }
  }

  /* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   T R A C K   G R O U P   S E T U P 
   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

  // ok something broke because now it's possible to add multiple trackGroups for the same properties
  // this wasnt the case before 7-7
  void createGroup(String property)
  {
    String trackGroup = "trackGroup:" + (groups.size() + 1) + "    layer:" + (gui.layerSelected+1) + "    type:" + layers.get(gui.layerSelected).getType() + "    group:" + property;
    StringList trackProperties = new StringList();

    if (!groups.containsKey(trackGroup))
    {
      switch(property)
      {
      case "GEAR" :
        trackProperties = layers.get(gui.layerSelected).gearProp;
        break;

      case "COLOR" :
        trackProperties = layers.get(gui.layerSelected).colorProp;
        break;
      }

      gui.tg.addTrackGroup(trackGroup, trackProperties, property);

      groups.put(trackGroup, gui.cp5.get(Group.class, trackGroup));
    } else
    {
      // present message that trackGroup already exists
    }
  }  

  void deleteGroup(String tgName)
  {
    String trackGroup = tgName.substring(0, (tgName.length()-8));

    if (groups.containsKey(trackGroup))
    {
      gui.cp5.get(Group.class, trackGroup).remove();
      groups.remove(trackGroup);
    }

    for (String segKey : segments.keySet())
    {
      if (segKey.contains(trackGroup))
      {
        segmentChanged(segKey, 1);
      }
    }
  }

  void deleteGearTrackGroup(int g)
    // 2706 defunct atm
    // this is getting called when deleting gear vectors from layer, and deletes the corresponding trackGroup if present
    // asymmetrical function, i.e. there's no corresponding addGearTrackGroup
  {
    String trackGroup =  "layer " + (gui.layerSelected+1) + " ~ " + layers.get(gui.layerSelected).getType() + " ~ " + "tG gear " + (g+1);
    if (groups.containsKey(trackGroup))
    {
      gui.cp5.get(Group.class, trackGroup).remove();
      groups.remove(trackGroup);
    }
  }
}