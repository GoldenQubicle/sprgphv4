class Controller
{
  GUI_trackGroup_Controller tG;
  float mapStart, mapEnd;
  FileIO fileio = new FileIO();

  Controller() 
  {
    tG = new GUI_trackGroup_Controller();
  }

  /* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   A N I   T R A C K   H A N D L I N G   
   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

  void matchSegmentController(ControlEvent theEvent)
  {


    for (ScrollableList segment : tG.segments.values())
    {
      if (segment.getId() == 1)
      {
        if (segment.getStringValue().equals(theEvent.getController().getStringValue()))
        {
          updateAniEndValue(segment.getName(), theEvent.getController().getValue());
          break;
        }
        if (segment.getStringValue().contains(theEvent.getController().getStringValue()) && segment.getName().contains("x"))
        {
          updateAniEndValue(segment.getName(), theEvent.getController().getArrayValue(0));
          break;
        }
        if (segment.getStringValue().contains(theEvent.getController().getStringValue()) && segment.getName().contains("y"))
        {
          updateAniEndValue(segment.getName(), theEvent.getController().getArrayValue(1));
          break;
        }
      }
    }
  }

  void updateAniEndValue(String aniKey, float value)
  {
    gif.aniSegments.get(aniKey).setEnd(value);
    println(value);
  }

  void updateAni(ScrollableList segment)
  {
    String segmentKey = segment.getName();
    float duration = round(map(segment.getWidth(), mapStart, mapEnd, 0, gif.frames));
    float start = round(map(segment.getPosition()[0], mapStart, mapEnd, 0, gif.frames));
    int easing = int(segment.getValue());

    gif.aniSegments.get(segmentKey).setDelay(start);
    gif.aniSegments.get(segmentKey).setDuration(duration);  
    gif.aniSegments.get(segmentKey).setEasing(gif.easings[easing]);
  }

  void initAni(ScrollableList segment)
  {
    int layer = segment.getParent().getParent().getId();
    int gear = segment.getParent().getId(); 
    String field = segment.getParent().getStringValue();
    String controllerKey = segment.getStringValue();
    String segmentKey = segment.getName();
    gif.createAni(layer, field, gear, controllerKey, segmentKey);
    updateAni(segment);
  }
}