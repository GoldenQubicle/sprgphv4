class Controller
{
  GUI_trackGroup_Controller tG;
  ScrollableList newSeg;

  Controller() 
  {
    tG = new GUI_trackGroup_Controller();
    // time range needs mapped from 15 - 730
    // hm yeah quick note, the createAni function in animation should probably not be responible for handling the HashMap
  }

  void clearAniupdate()
  {
    tG.aniUpdate.clear();
  }


  void checkAniTrackSegments()
  {
    for (String aniKey : tG.aniUpdate.keyArray())
    {
      if (!gif.aniSegments.containsKey(aniKey) && tG.aniUpdate.get(aniKey)== 0 ) 
      {
        newSeg =  controller.tG.segments.get(aniKey);       
        gif.aniSegments.put(aniKey, constructAni(newSeg));
      } else if (tG.aniUpdate.get(aniKey) == 0)
      {
        Ani updated = constructAni(controller.tG.segments.get(aniKey));        
        if (!gif.aniSegments.get(aniKey).equals(updated))
        {
          gif.aniSegments.replace(aniKey, updated);
        }
      } else if (tG.aniUpdate.get(aniKey) == 1)
      {
        controller.tG.segments.remove(aniKey);
        gif.aniSegments.remove(aniKey);    
      }
    }
    clearAniupdate();
  }


  Ani constructAni(ScrollableList segment)
  {
    String segmentKey = segment.getName();
    int layer = segment.getParent().getParent().getId();
    int gear = segment.getParent().getId(); 
    String property = segment.getParent().getStringValue();
    String field = segment.getStringValue();
    float duration = round(map(segment.getWidth(), 15, 730, 0, gif.frames));
    float start = round(map(segment.getPosition()[0], 15, 730, 0, gif.frames));
    int easing = int(segment.getValue());
    return gif.createAni(layer, property, gear, segmentKey, field, duration, start, easing );
  }
}