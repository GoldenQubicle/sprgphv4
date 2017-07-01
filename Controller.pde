class Controller
{
  Map<String, Group>trackGroups = new HashMap<String, Group>();
  Map<String, ScrollableList>trackSegments = new HashMap<String, ScrollableList>();
  int segment;
  StringList editModes = new StringList("aniCenter", "aniLeft", "aniRight");
  String editMode = editModes.get(0);

  Controller()
  {
  }

  void hooverAniSegment(float mousePosX)
  {
    for (String segment : trackSegments.keySet())
    {
      if (gui.cp5.isMouseOver(gui.cp5.getController(segment)))
      {        
        switch(editMode) 
        {          
        case "aniCenter":

          mouseCenter(gui.cp5.get(ScrollableList.class, segment), mousePosX);
          println(gui.cp5.get(ScrollableList.class, segment).getParent().getParent().getParent().getPosition()[0] + gui.cp5.get(ScrollableList.class, segment).getPosition()[0]); // absolute position

          break;

        case "aniLeft":

          mouseLeft(gui.cp5.get(ScrollableList.class, segment), mousePosX);
          println(gui.cp5.get(ScrollableList.class, segment).getPosition());

          break;

        case "aniRight":

          mouseRight(gui.cp5.get(ScrollableList.class, segment), mousePosX);
          println(gui.cp5.get(ScrollableList.class, segment).getPosition());

          break;
        }
      }
    }
  }    

  void mouseCenter(ScrollableList segment, float mousePosX)
  { // moving entire segment
    float segCenter = segment.getPosition()[0] + (segment.getWidth()/2);
    float deltaX = mousePosX - segCenter;
    //println("center", deltaX);
  }

  void mouseLeft(ScrollableList segment, float mousePosX)
  { // manipulate start time
    float segStart = segment.getPosition()[0];
    float deltaX = mousePosX - segStart;
    //println("left", deltaX);
  }

  void mouseRight(ScrollableList segment, float mousePosX)
  { // manipulaye end time
    float segEnd = segment.getPosition()[0] + segment.getWidth();
    float deltaX = segEnd - mousePosX;
    //println("right", deltaX);
  }

  void createAniSegment(int layer, String property, int prop, int gear, String trackgroup, String field)
  {
    segment+=1;
    String trackSegment = trackgroup + "    property:" + prop + "    segment:" + segment;
    gui.tg.addTrackSegment(trackSegment, segment);
    trackSegments.put(trackSegment, gui.cp5.get(ScrollableList.class, trackSegment));
    //println(layer, property, prop, gear, );
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