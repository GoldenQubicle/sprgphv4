class Controller
{
  GUI_trackGroup_Controller tG;

  Controller() 
  {
    tG = new GUI_trackGroup_Controller();
    // time range needs mapped from 15 - 730
    // hm yeah quick note, the createAni function in animation should probably not be responible for handling the HashMap
  }



  void checkAniTrackSegments()
  {
    for (String aniKey : controller.tG.aniUpdate.keyArray())
    {
      if (!gif.aniSegments.containsKey(aniKey)) {
        ScrollableList newSeg = controller.tG.segments.get(aniKey);
        constructAni(newSeg);
      } else if (controller.tG.aniUpdate.get(aniKey) == 0)
      {
        
      }
    }
  }


  void constructAni(ScrollableList segment)
  {
    String segmentKey = segment.getName();
    int layer = segment.getParent().getParent().getId();
    int gear = segment.getParent().getId(); 
    String property = segment.getParent().getStringValue();
    int propertyIndex = segment.getId();
    String field = segment.getStringValue();
    float duration = round(map(segment.getWidth(), 15, 730, 0, gif.frames));
    float start = round(map(segment.getPosition()[0], 15, 730, 0, gif.frames));
    int easing = int(segment.getValue());
    gif.createAni(layer, property, propertyIndex, gear, segmentKey, field, duration, start, easing );
  }
}