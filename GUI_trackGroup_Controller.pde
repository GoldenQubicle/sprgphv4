class GUI_trackGroup_Controller
{
  Map<String, Group> groups = new HashMap<String, Group>();
  Map<String, ScrollableList> segments = new HashMap<String, ScrollableList>();
  StringList editModes = new StringList("asOne", "left", "right");
  String editMode = editModes.get(0);
  boolean edit = false;
  float segMouseEnter, segWidth, segStart;
  int segmentID;
  ScrollableList segmentActive;

  GUI_trackGroup_Controller() 
  {
  }

  void createSegment(int layer, String property, int propertyIndex, int gear, String trackgroup, String field)
  {
    segmentID+=1;
    String segmentKey = trackgroup +  "    gearNo:" + gear +  "    property:" + property + "    segment:" + segmentID;
    String controllerKey = trackgroup.substring(11, 17) + field;

    gui.tg.addTrackSegment(segmentKey, controllerKey);
    segments.put(segmentKey, gui.cp5.get(ScrollableList.class, segmentKey));
    controller.initAni(gui.cp5.get(ScrollableList.class, segmentKey));
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
      gif.aniSegments.remove(segmentActive.getName());      
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

  void createGroup(String groupType)
  {
    String trackGroup = "trackGroup:" + groupType  + "    layer:" + (gui.layerSelected+1) + "    type:" + layers.get(gui.layerSelected).getType(); 
    ArrayList<String>trackProperties = new ArrayList<String>();

    if (!groups.containsKey(trackGroup))
    {
      if (groupType.contains("GEAR"))
      {
        trackProperties = layers.get(gui.layerSelected).gearProp;
      }
      if (groupType.contains("COLOR"))
      {
        trackProperties = layers.get(gui.layerSelected).colorProp;
      }

      gui.tg.addTrackGroup(trackGroup, trackProperties);
      groups.put(trackGroup, gui.cp5.get(Group.class, trackGroup));
    }
  }  

  void deleteGroup(String trackGroup)
  {
    if (groups.containsKey(trackGroup))
    {
      for (ScrollableList segment : segments.values())
      {
        if (segment.getName().contains(trackGroup))
        {
          gif.aniSegments.remove(segment.getName());
        }
      }      
      gui.cp5.get(Group.class, trackGroup).remove();
      groups.remove(trackGroup);
    }
  }

  void deleteGearTrackGroup(int g)
  {
    String trackGroup = "trackGroup:GEAR" + (g+1)  + "    layer:" + (gui.layerSelected+1) + "    type:" + layers.get(gui.layerSelected).getType(); 

    if (groups.containsKey(trackGroup))
    {
      deleteGroup(trackGroup);
    }
  }
}