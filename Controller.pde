class Controller
{
  Map<String, Group>trackGroups = new HashMap<String, Group>();
  Map<String, ScrollableList>trackSegments = new HashMap<String, ScrollableList>();
  IntDict aniUpdate = new IntDict();
  int segment;
  StringList aniEditModes = new StringList("asOne", "left", "right");
  String aniEditMode = aniEditModes.get(0);
  boolean editMode = true;
  float segMouseEnter, segWidth, segStart;
  ScrollableList tobeMoved;

  Controller()
  {
  }

  void aniToBeUpdated(String segmentKey, int flag)
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

  void aniSegmentHandler()
  {
    float delta = segMouseEnter-gui.mouseX;
    switch(aniEditMode) 
    {  
    case "asOne" :
      float newStart = constrain((segStart-delta), gui.tg.trackAddSegmentButtonWidth, gui.tg.trackGroupWidth-tobeMoved.getWidth());
      tobeMoved.setPosition(newStart, tobeMoved.getPosition()[1]); 
      break;

    case "left" :
      float newStart2 = constrain((segStart-delta), gui.tg.trackAddSegmentButtonWidth, gui.tg.trackGroupWidth);
      tobeMoved.setPosition(newStart2, tobeMoved.getPosition()[1]);
      if (tobeMoved.getPosition()[0] > 15)
      {
        tobeMoved.setWidth(int(segWidth+delta));
      }
      break;

    case "right" :
      float newWidth = constrain((segWidth-delta), 0, gui.tg.trackGroupWidth-segStart);
      tobeMoved.setWidth(int(newWidth));
      break;
    }

    if (gui.keyPressed == true && gui.key == DELETE)
    {
      aniToBeUpdated(tobeMoved.getStringValue(), 1);
      gui.cp5.getController(tobeMoved.getStringValue()).remove();
      //trackSegments.remove(tobeMoved.getStringValue());
    }
  }

  void updateHandlerValues(float mousePos)
  {
    segWidth = tobeMoved.getWidth();
    segStart = tobeMoved.getPosition()[0];
    segMouseEnter = mousePos;
  }


  void createAniSegment(int layer, String property, int prop, int gear, String trackgroup, String field)
  {
    segment+=1;
    String trackSegment = trackgroup +  "    gearNo:" + gear +  "    property:" + prop + "    segment:" + segment;
    gui.tg.addTrackSegment(trackSegment, segment);
    trackSegments.put(trackSegment, gui.cp5.get(ScrollableList.class, trackSegment));
    //gif.createAni(layer, property, prop, gear, trackSegment, field);
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

    for (String segmentKey : trackSegments.keySet())
    {
      if (segmentKey.contains(trackGroup))
      {
        //trackSegments.remove(segmentKey);
        aniToBeUpdated(segmentKey, 1);
      }
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