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

  void checkAniTrackSegments()
  {
    for (String aniKey : tG.aniUpdate.keyArray())
    {
      if (!gif.aniSegments.containsKey(aniKey) && tG.aniUpdate.get(aniKey)== 0 ) 
      {
        newSeg =  controller.tG.segments.get(aniKey);       
        gif.aniSegments.put(aniKey, aniParameters(newSeg));
      } else if (tG.aniUpdate.get(aniKey) == 0)
      {
        update = aniParameters(controller.tG.segments.get(aniKey));        
        if (!gif.aniSegments.get(aniKey).equals(update))
        {
          gif.aniSegments.replace(aniKey, update);
        }
      } else if (tG.aniUpdate.get(aniKey) == 1)
      {
        controller.tG.segments.remove(aniKey);
        gif.aniSegments.remove(aniKey);
      }
    }
    tG.aniUpdate.clear();
  }

  Ani aniParameters(ScrollableList segment)
  {
    int layer = segment.getParent().getParent().getId();
    int gear = segment.getParent().getId(); 
    String property = segment.getParent().getStringValue();
    String field = segment.getStringValue();
    float duration = round(map(segment.getWidth(), mapStart, mapEnd, 0, gif.frames));
    float start = round(map(segment.getPosition()[0], mapStart, mapEnd, 0, gif.frames));
    int easing = int(segment.getValue());
    return  gif.createAni(layer, property, gear, field, duration, start, easing);
  }
}