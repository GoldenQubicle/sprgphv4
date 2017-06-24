class GUI_trackGroup
{
  ControlP5 cp5;
  Accordion trackControls;
  int track = 0;
  int trackHeight = 128;
  GUI_trackGroup(ControlP5 tg)  
  {    
    cp5 = tg;
    trackControls = cp5.addAccordion("TC")
      .setPosition(5, 256)
      .setWidth(730)
      .setCollapseMode(Accordion.SINGLE);
    addTrack(track);
  }


  void addTrack(int track)
  {
    addTrackGroup(track);
    addPropertiesList(track);
    setProperties(gui.layerSelected);
  }


  void delTrack()
  {
  }

  void addTrackGroup(int track) 
  {
    ani.tracks+=1;
    cp5.addGroup("track " + track)
      .setId(gui.layerSelected)
      .setBackgroundHeight(trackHeight)
      .setBackgroundColor(color(255, 50));
    trackControls.addItem(cp5.get(Group.class, "track " + track)).open(track);
  }

  void addPropertiesList(int track)
  {
    cp5.addScrollableList("properties" + track)    
      .setPosition(624, 10)
      .setSize(gui.rPaneWidth, trackHeight-10)
      .setGroup("track " + track)
      .setOpen(true)            
      .addCallback(new CallbackListener() 
    {
      public void controlEvent(CallbackEvent theEvent) 
      {
        String propKey = theEvent.getController().getLabel();
        println(propKey);
      }
    }
    );
  } 

  void setProperties(int ls)
  {
    List<String> layerProperties = new ArrayList<String>();

    for (int t = 0; t < ani.tracks; t++)
    {
      if (cp5.get(Group.class, "track " + t).getId() == ls)
      {               
        cp5.get(ScrollableList.class, "properties" + t).clear();   
        for (int g = 0; g < layers.get(ls).getNumberOfGears(); g++)
        {
          for (int p = 0; p < layers.get(ls).gearProp.size(); p++) {
            layerProperties.add("gear " + (g+1) + " "+  layers.get(ls).gearProp.get(p));
          }
        }
        cp5.get(ScrollableList.class, "properties" + t).addItems(layerProperties);
      }
    }
  }
}