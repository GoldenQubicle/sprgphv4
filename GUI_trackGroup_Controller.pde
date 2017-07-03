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
   S E G M E N T  M E T H O D S  
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
      segmentChanged(segmentActive.getStringValue(), 1);
      gui.cp5.getController(segmentActive.getStringValue()).remove();
      //trackSegments.remove(tobeMoved.getStringValue());
    }
  }

  void updateSegmentHandler(float mousePos)
  {
    segWidth = segmentActive.getWidth();
    segStart = segmentActive.getPosition()[0];
    segMouseEnter = mousePos;
  }


  void segmentChanged(String segmentKey, int flag)
  {
    // soo when controller goes to town, segments flagged for deletion needs to be removed from trackSegments as well
    if (!aniUpdate.hasKey(segmentKey))
    {
      aniUpdate.add(segmentKey, flag);
    } else 
    {
      aniUpdate.set(segmentKey, flag);
    }
  }

  void createSegment(int layer, String property, int prop, int gear, String trackgroup, String field)
  {
    segment+=1;
    String trackSegment = trackgroup +  "    gearNo:" + gear +  "    property:" + prop + "    segment:" + segment;
    gui.tg.addTrackSegment(trackSegment, segment);
    segments.put(trackSegment, gui.cp5.get(ScrollableList.class, trackSegment));
    //gif.createAni(layer, property, prop, gear, trackSegment, field);
  }

  /* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   T R A C K   G R O U P   S E T U P 
   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

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

    for (String segmentKey : segments.keySet())
    {
      if (segmentKey.contains(trackGroup))
      {
        //trackSegments.remove(segmentKey);
        segmentChanged(segmentKey, 1);
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