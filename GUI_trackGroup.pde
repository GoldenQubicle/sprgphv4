class GUI_trackGroup
{
  ControlP5 cp5;
  Accordion trackControls;
  int track = 1;
  int trackHeight = 128;
  GUI_trackGroup(ControlP5 tg)  
  {    
    cp5 = tg;
    trackControls = cp5.addAccordion("TC")
      .setPosition(5, 256)
      .setWidth(730)
      .setCollapseMode(Accordion.SINGLE);
    addTrack(1);
    addPropertiesList(1);
setProperties(1);
  }

  void addTrack(int track) 
  {
    cp5.addGroup("track " + track)
      .setId(track)
      .setBackgroundHeight(trackHeight)
      .setBackgroundColor(color(255, 50));
    trackControls.addItem(cp5.get(Group.class, "track " + track)).open(track-1);
  }

  void addPropertiesList(int track)
  {
    cp5.addScrollableList("properties")    
      .setPosition(624, 10)
      .setSize(gui.rPaneWidth, 100)
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

  void setProperties(int track)
  {    
   cp5.get(ScrollableList.class, "properties") 
   .clear()
   .addItems(controller.addLayerPropertiesToTrack(track-1));    
  }
  
}