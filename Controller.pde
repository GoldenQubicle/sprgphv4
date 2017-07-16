class Controller
{
  GUI_trackGroup_Controller tG;
  float mapStart, mapEnd;
  FloatDict aniValue = new FloatDict();
  FileIO fileio = new FileIO();
  ArrayList<Layer> initialState = new ArrayList<Layer>();

  Controller() 
  {
    tG = new GUI_trackGroup_Controller();
  }

  void play()
  {
    setInitialLayerState();
    gif.createSeq();
    gif.seq.start();
  }

  void setInitialLayerState()
  {
    initialState.clear();

    for (Layer toCopy : layers)
    {

      switch(toCopy.getType())
      {

      case "SPIRO":

        Spiro initSpiro = new Spiro(toCopy);
        initialState.add(initSpiro);

        break;

      case "LINES":

        Lines initLines = new Lines(toCopy);
        initialState.add(initLines);

        break;

      case "SPIRO3D":

        Spiro3D initSpiro3D = new Spiro3D(toCopy);
        initialState.add(initSpiro3D);

        break;

      case "MESH":
        
        Mesh initMesh = new Mesh((Mesh)toCopy);
        initialState.add(initMesh);

        break;
      }
    }
  }

  void getInitialLayerState()
  {
    for (int i = 0; i < initialState.size(); i++)
    {
      layers.set(i, initialState.get(i));
    }
  }

  void initAni(ScrollableList segment)
  {
    // in here, grab data from segments and store it somewhere
    int layer = segment.getParent().getParent().getId();
    int gear = segment.getParent().getId(); 
    String field = segment.getParent().getStringValue();
    String controllerKey = segment.getStringValue();
    String segmentKey = segment.getName();
    float duration = round(map(segment.getWidth(), mapStart, mapEnd, 0, gif.frames));
    float start = round(map(segment.getPosition()[0], mapStart, mapEnd, 0, gif.frames));
    int easing = int(segment.getValue());
    float value = 0;

    if (aniValue.hasKey(segmentKey)) {    
      value = aniValue.get(segmentKey);
    } else 
    {
      value = 150;
    }

    gif.createAni(layer, field, gear, controllerKey, start, duration, easing, value);
  }

  void setAniValue(ControlEvent theEvent)
  {
    for (ScrollableList segment : tG.segments.values())
    {
      if (segment.getId() == 1)
      {  
        //println(segment.getStringValue() + " " + theEvent.getController().getStringValue());

        if (segment.getStringValue().contains("x"))
        {
          aniValue.set(segment.getName(), theEvent.getController().getArrayValue(0));
        }       

        if (segment.getStringValue().contains("y"))
        {
          aniValue.set(segment.getName(), theEvent.getController().getArrayValue(1));
        }      

        if (segment.getStringValue().equals(theEvent.getController().getStringValue()))
        {
          aniValue.set(segment.getName(), theEvent.getController().getValue());
        }
      }
    }
  }
}