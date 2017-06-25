class Controller
{
  Map<String, Group>trackGroups = new HashMap<String, Group>();


  Controller()
  {
  }

  void deleteTrackGroup(int g)
  {
    String trackGroup =  "layer " + (gui.layerSelected+1) + " ~ " + layers.get(gui.layerSelected).getType() + " ~ " + "tG gear " + (g+1);
     if (trackGroups.containsKey(trackGroup))
    {
      gui.cp5.get(Group.class, trackGroup).remove();
      trackGroups.remove(trackGroup);
    }
  }
  

  void createTrackGroup(String buttonName)
  {
    String trackGroup = "layer " + (gui.layerSelected+1) + " ~ " + layers.get(gui.layerSelected).getType() + " ~ " + buttonName;

    if (!trackGroups.containsKey(trackGroup))
    {
      gui.tg.addTrackGroup(trackGroup);
      trackGroups.put(trackGroup, gui.cp5.get(Group.class, trackGroup));
    } else
    {
    // present message that trackGroup already exists  
  }
   
  }
}