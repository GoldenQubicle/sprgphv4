class Controller
{
  Map<String, Group>trackGroups = new HashMap<String, Group>();


  Controller()
  {
  }




  void createTrackGroup(String buttonName)
  {
    String trackGroup = "layer " + (gui.layerSelected+1) + " ~ " + layers.get(gui.layerSelected).getType() + " ~ " + buttonName;
    StringList trackProperties = new StringList();

    if (!trackGroups.containsKey(trackGroup))
    {

      if (buttonName.contains("gear"))
      {
        trackProperties = layers.get(gui.layerSelected).gearProp;
      }
       if (buttonName.contains("color"))
      {
        trackProperties = layers.get(gui.layerSelected).colorProp;
      }

      gui.tg.addTrackGroup(trackGroup, trackProperties);      
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