class Controller
{
  Map<String, Group>trackGroups = new HashMap<String, Group>();
  Map<String, ScrollableList>trackSegments = new HashMap<String, ScrollableList>();
  int segment;
  StringList aniEditModes = new StringList("asOne", "left", "right");
  String aniEditMode = aniEditModes.get(1);
  boolean edit = true;
  float deltaX, segWidth;
  ScrollableList tobeMoved;

  Controller()
  {
  }

  void getDelta (String segmentKey, float segStart, float segwidth, float mousePos)
  {
    segWidth = segwidth;
    tobeMoved = trackSegments.get(segmentKey);
    deltaX = mousePos - segStart;

    if (aniEditMode.equals("left"))
    {
      segWidth = segWidth + segStart;
    }
    if (aniEditMode.equals("right"))
    {
      segWidth = segWidth - segStart;
    }
  }

  void moveAni(float mouse)
  {    
    switch(aniEditMode) 
    {        
    case "asOne":  
      tobeMoved.setPosition(mouse-deltaX, tobeMoved.getPosition()[1]);
      break;
    case "left":
      tobeMoved.setPosition(mouse-deltaX, tobeMoved.getPosition()[1]);
      tobeMoved.setWidth(int(segWidth-abs(mouse-deltaX)));
      break;
    case "right" :
      tobeMoved.setWidth(int(segWidth+(mouse-deltaX)));
      break;
    }
    // constrains need to be split out into cases / editModes as well
    if (tobeMoved.getPosition()[0] < gui.tg.trackAddSegmentButtonWidth)
    {
      tobeMoved.setPosition(gui.tg.trackAddSegmentButtonWidth, tobeMoved.getPosition()[1]) ;
    }
    if(tobeMoved.getPosition()[0]+tobeMoved.getWidth() > gui.tg.trackGroupWidth)
    {
     tobeMoved.setPosition(gui.tg.trackAddSegmentButtonWidth, tobeMoved.getPosition()[1]) ;
    }
  }

  void createAniSegment(int layer, String property, int prop, int gear, String trackgroup, String field)
  {
    segment+=1;
    String trackSegment = trackgroup + "    property:" + prop + "    segment:" + segment;
    gui.tg.addTrackSegment(trackSegment, segment);
    trackSegments.put(trackSegment, gui.cp5.get(ScrollableList.class, trackSegment));
    gif.createAni( layer, property, prop, gear, trackSegment, field);
  }

  /* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   T R A C K   G R O U P   S E T U P 
   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

  void createTrackGroup(String property)
  {
    String trackGroup = "trackGroup:" + (trackGroups.size() + 1) + "    layer:" + (gui.layerSelected+1) + "    type:" + layers.get(gui.layerSelected).getType() + "    group:" + property;
    StringList trackProperties = new StringList();

    if (!trackGroups.containsKey(trackGroup))
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

      trackGroups.put(trackGroup, gui.cp5.get(Group.class, trackGroup));
    } else
    {
      // present message that trackGroup already exists
    }
  }  

  void deleteTrackGroup(String tgName)
  {
    String trackGroup = tgName.substring(0, (tgName.length()-8));

    if (trackGroups.containsKey(trackGroup))
    {
      gui.cp5.get(Group.class, trackGroup).remove();
      trackGroups.remove(trackGroup);
    }
  }

  void deleteGearTrackGroup(int g)
    // 2706 defunct atm
    // this is getting called when deleting gear vectors from layer, and deletes the corresponding trackGroup if present
    // asymmetrical function, i.e. there's no corresponding addGearTrackGroup
  {
    String trackGroup =  "layer " + (gui.layerSelected+1) + " ~ " + layers.get(gui.layerSelected).getType() + " ~ " + "tG gear " + (g+1);
    if (trackGroups.containsKey(trackGroup))
    {
      gui.cp5.get(Group.class, trackGroup).remove();
      trackGroups.remove(trackGroup);
    }
  }
}