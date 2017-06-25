class GUI_trackGroup
{
  ControlP5 cp5;
  Accordion trackControls;
  int track = 0;
  int trackHeight = 128;
  int yPos = 0;
  int col = 0;  

  GUI_trackGroup(ControlP5 tg)  
  {    
    cp5 = tg;
    trackControls = cp5.addAccordion("TC")
      .setPosition(5, 256+20)
      .setWidth(730)
      .setCollapseMode(Accordion.SINGLE);

    menuTrackGroup();

    for (int g = 0; g < layers.get(gui.layerSelected).getNumberOfGears(); g++)
    {  
      addGearTrackButtons(g);
    }
  }


  /* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   T R A C K   G R O U P  C O N T R O L S
   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

  void addTrackGroup(String track) 
  {
    String tgName = "layer " + (gui.layerSelected+1) + " ~ " + layers.get(gui.layerSelected).getType() + " ~ " + track; 
    cp5.addGroup(tgName)
      .setId(gui.layerSelected)
      .setBackgroundHeight(trackHeight)
      .setBackgroundColor(color(255, 50));
    trackControls.addItem(cp5.get(Group.class, tgName)).open();
  }


  /* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   G L O B A L  T R A X  C O N T R O L S
   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

  void addGearTrackButtons(int g)
  {    
    if (g%2 == 0)
    {
      yPos+=15; 
      col = 0;
    }    
    cp5.addButton("tG gear " + (g+1))
      .setPosition((50*col)+2, yPos)
      .setSize(45, 10)
      .setGroup("menuTrackGroups")
      .onClick(new CallbackListener() 
    {
      public void controlEvent(CallbackEvent theEvent) 
      {
        addTrackGroup(theEvent.getController().getName());
      }
    }
    );

    col+=1;
  }

  void removeGearTrackButtons(int g)
  {
    if (g%2 == 0)
    {
      yPos-=15;
      col = 1;
    }
    if (col > 1)
    {
      col-=1;
    }

    cp5.get(Button.class, "tG gear " + (g+1)).remove();
    
  }

  void menuTrackGroup()
  {
    cp5.addGroup("menuTrackGroups")
      .setPosition(gui.rPaneXpos, 256+30)
      .setSize(gui.rPaneWidth, 150)
      .setBackgroundColor(color(255, 50))
      .setOpen(true);
  }

}