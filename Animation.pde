class Animation  //<>//
{
  PApplet parent;
  AniSequence seq;
  Ani ani;

  Map<String, Ani> aniSegments = new HashMap<String, Ani>();

  Easing[] easings = { Ani.LINEAR, Ani.QUAD_IN, Ani.QUAD_OUT, Ani.QUAD_IN_OUT, Ani.CUBIC_IN, Ani.CUBIC_IN_OUT, Ani.CUBIC_OUT, Ani.QUART_IN, Ani.QUART_OUT, Ani.QUART_IN_OUT, Ani.QUINT_IN, Ani.QUINT_OUT, Ani.QUINT_IN_OUT, Ani.SINE_IN, Ani.SINE_OUT, Ani.SINE_IN_OUT, Ani.CIRC_IN, Ani.CIRC_OUT, Ani.CIRC_IN_OUT, Ani.EXPO_IN, Ani.EXPO_OUT, Ani.EXPO_IN_OUT, Ani.BACK_IN, Ani.BACK_OUT, Ani.BACK_IN_OUT, Ani.BOUNCE_IN, Ani.BOUNCE_OUT, Ani.BOUNCE_IN_OUT, Ani.ELASTIC_IN, Ani.ELASTIC_OUT, Ani.ELASTIC_IN_OUT};
  String[] EasingNames = {"LINEAR", "QUAD_IN", "QUAD_OUT", "QUAD_IN_OUT", "CUBIC_IN", "CUBIC_IN_OUT", "CUBIC_OUT", "QUART_IN", "QUART_OUT", "QUART_IN_OUT", "QUINT_IN", "QUINT_OUT", "QUINT_IN_OUT", "SINE_IN", "SINE_OUT", "SINE_IN_OUT", "CIRC_IN", "CIRC_OUT", "CIRC_IN_OUT", "EXPO_IN", "EXPO_OUT", "EXPO_IN_OUT", "BACK_IN", "BACK_OUT", "BACK_IN_OUT", "BOUNCE_IN", "BOUNCE_OUT", "BOUNCE_IN_OUT", "ELASTIC_IN", "ELASTIC_OUT", "ELASTIC_IN_OUT"};

  float duration = 2.5;
  int frames = int(duration * 60);

  Animation(PApplet theApplet)
  {
    parent = theApplet;
    Ani.init(parent);
    Ani.setDefaultTimeMode(Ani.FRAMES);
    Ani.noAutostart();
    seq = new AniSequence(parent);
  }


  /* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   G E N E R A L   M E T H O D S   
   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

  Ani createAni(int layer, String property, int gear, String field, float duration, float delay, int easing)
  {
    Object obj = new Object();

    switch(property)
    {
    case "GEAR":
      obj = layers.get(layer).gears.get(gear).vector;
      if (field == "petals")
      {
        obj = layers.get(layer).gears.get(gear);
      }
      break;

    case "COLOR":
      obj = layers.get(layer);
      break;
    }
     //                  edit     edit         edit      edit
    ani = new Ani(obj, duration, delay, field, 150, easings[easing]);
    ani.setPlayMode(Ani.FORWARD);
    ani.noRepeat();
    return ani;
  }


  /* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   P L A Y  M E T H O D S   
   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

  void aniPlayPause()
  {
    for (Ani ani : aniSegments.values()) 
    {
      if (!ani.isPlaying() && pause == false)
      {        
        ani.start();
      }
      if (ani.isPlaying() && pause == true)
      {
        ani.end();      
        ani.seek(0);
      }
    }
  }

  void aniCheckForEnd()
  {
    for (Ani ani : aniSegments.values()) 
    {
      if (ani.isEnded())
      {
        ani.seek(0);
        pause = true;
      }
    }
  }
}