class Controller
{
  GUI_trackGroup_Controller tG;
  ScrollableList newSeg;
  Ani update;
  float mapStart, mapEnd;

  Controller() 
  {
    tG = new GUI_trackGroup_Controller();
  }

  /* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   A N I   T R A C K   H A N D L I N G   
   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/




  //void checkAniTrackSegments()
  //{
  //  for (String aniKey : tG.aniUpdate.keyArray())
  //  {
  //    if (!gif.aniSegments.containsKey(aniKey) && tG.aniUpdate.get(aniKey)== 0 ) 
  //    {
  //      newSeg =  controller.tG.segments.get(aniKey);       
  //      gif.aniSegments.put(aniKey, aniParameters(newSeg));
  //      //println(aniKey);
  //    } else if (tG.aniUpdate.get(aniKey) == 0)
  //    {
  //      update = aniParameters(controller.tG.segments.get(aniKey));        
  //      if (!gif.aniSegments.get(aniKey).equals(update))
  //      {
  //        gif.aniSegments.replace(aniKey, update);
  //      }
  //    } else if (tG.aniUpdate.get(aniKey) == 1)
  //    {
  //      controller.tG.segments.remove(aniKey);
  //      gif.aniSegments.remove(aniKey);
  //    }
  //  }
  //  tG.aniUpdate.clear();
  //}

  void wibble(ControlEvent theEvent)
  {

    if (tG.aniUpdate.size() > 0)
    {
      String aniSegmentKey = tG.aniUpdate.key(0);
      String segmentControllerKey = tG.segments.get(aniSegmentKey).getStringValue();
      if (segmentControllerKey.contains(theEvent.getController().getStringValue()))      
      {
        //println(theEvent.getController().getStringValue(), tG.segments.get(aniSegmentKey).getStringValue());
        updateAniEndValue(aniSegmentKey, theEvent.getController().getValue());
  println(segmentControllerKey);
        //if (segmentControllerKey.contains("x"))
        //{
        //  updateAniEndValue(aniSegmentKey, theEvent.getController().getArrayValue()[0]);
        //}
        //if (segmentControllerKey.contains("y"))
        //{
        //  updateAniEndValue(aniSegmentKey, theEvent.getController().getArrayValue()[1]);
        //}
      }
    }

    //println(theEvent.getController().getName());
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

  // split this into one function for actually creating ani and put it in map (possibly animation class can handle this)
  // and have anothter function which updates the parameters
  void initAni(ScrollableList segment)
  {
    int layer = segment.getParent().getParent().getId();
    int gear = segment.getParent().getId(); 
    String field = segment.getParent().getStringValue();
    String controllerKey = segment.getStringValue();
    String segmentKey = segment.getName();
    //float duration = round(map(segment.getWidth(), mapStart, mapEnd, 0, gif.frames));
    //float start = round(map(segment.getPosition()[0], mapStart, mapEnd, 0, gif.frames));
    //int easing = int(segment.getValue());

    //println("layer: " + layer + " gear: " +  gear + " field: " +  field + " controller: " +  controllerKey + " duration: " +  duration + " start: " +  start + " easing: " + easing);
    //println(segmentKey);
    gif.createAni(layer, field, gear, controllerKey, segmentKey);
  }
}