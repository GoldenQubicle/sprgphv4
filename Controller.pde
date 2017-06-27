class Controller
{
  Map<String, Group>trackGroups = new HashMap<String, Group>();


  Controller()
  {
  }


  void createAniSegment(int layer, String property, int prop, int gear)
  {

    println("layer = " + layer + ", property is " + property + " propertyIndex = " + prop + " gearNo " + gear );  
    
    gui.tg.addTrackSegment(layer, prop);
  }

  void createTrackGroup(String property)
  {
    String trackGroup = "track:" + (trackGroups.size() + 1) + "    layer:" + (gui.layerSelected+1) + "    type:" + layers.get(gui.layerSelected).getType() + "    group:" + property;
    StringList trackProperties = new StringList();

    if (!trackGroups.containsKey(trackGroup))
    {

      if (property.equals("GEAR"))
      {
        trackProperties = layers.get(gui.layerSelected).gearProp;
      }
      if (property.equals("COLOR"))
      {
        trackProperties = layers.get(gui.layerSelected).colorProp;
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