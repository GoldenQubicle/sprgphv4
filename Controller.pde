class Controller
{
  GUI_trackGroup_Controller tG;
  float mapStart, mapEnd;
  FloatDict aniValue = new FloatDict();
  FileIO fileio = new FileIO();

  Controller() 
  {
    tG = new GUI_trackGroup_Controller();
  }

  void play()
  {
    gif.createSeq();
    gif.aniPlayPause();
  }

  void initAni(ScrollableList segment)
  {
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
        if (segment.getStringValue().equals(theEvent.getController().getStringValue()))
        {
          aniValue.set(segment.getName(), theEvent.getController().getValue());
          break;
        }
        if (segment.getStringValue().contains(theEvent.getController().getStringValue()) && segment.getName().contains("x"))
        {
          aniValue.set(segment.getName(), theEvent.getController().getArrayValue(0));
          //break;
        }
        if (segment.getStringValue().contains(theEvent.getController().getStringValue()) && segment.getName().contains("y"))
        {
          aniValue.set(segment.getName(), theEvent.getController().getArrayValue(1));
          break;
        }
        if (segment.getStringValue().contains(theEvent.getController().getStringValue()) && segment.getName().contains("z"))
        {
          aniValue.set(segment.getName(), theEvent.getController().getValue());
          break;
        }
      }
    }
  }
}