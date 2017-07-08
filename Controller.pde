class Controller
{
  GUI_trackGroup_Controller tG;
  ScrollableList newSeg;
  Ani update;
  float mapStart, mapEnd;
  ArrayList<Layer> layerInit = new ArrayList<Layer>();

  Controller() 
  {
    tG = new GUI_trackGroup_Controller();

  }

  /* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   A N I   T R A C K   H A N D L I N G   
   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/


  void matchSegmentController(ControlEvent theEvent)
  {

    if (tG.aniUpdate.size() > 0)
    {
      String aniSegmentKey = tG.aniUpdate.key(0);
      String segmentControllerKey = tG.segments.get(aniSegmentKey).getStringValue();
      if (segmentControllerKey.contains(theEvent.getController().getStringValue()))      
      {
        updateAniEndValue(aniSegmentKey, theEvent.getController().getValue());
      }
      if (segmentControllerKey.contains(theEvent.getController().getStringValue()) && segmentControllerKey.contains("x"))
      {
        updateAniEndValue(aniSegmentKey, theEvent.getController().getArrayValue(0));
      }
      if (segmentControllerKey.contains(theEvent.getController().getStringValue()) && segmentControllerKey.contains("y"))
      {
        updateAniEndValue(aniSegmentKey, theEvent.getController().getArrayValue(1));
      }
    }
  }


  void updateAniEndValue(String aniKey, float value)
  {
    gif.aniSegments.get(aniKey).setEnd(value);
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
  }
}