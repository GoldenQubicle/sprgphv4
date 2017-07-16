class Animation   //<>//
{
  PApplet parent;
  Ani ani, master;
  AniSequence seq;

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
  }


  /* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   G E N E R A L   M E T H O D S   
   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

  void createSeq()
  {
    seq = new AniSequence(parent);
    seq.beginSequence();
    seq.beginStep();
    master = new Ani(duration, frames, "", frames);
    seq.add(master);
    
    for (ScrollableList segment : controller.tG.segments.values())
    {
      // so here, grab data from segments and call createAni
      controller.initAni(segment);
      seq.add(ani);
    }
    seq.endStep();
    seq.endSequence();
  }


  void createAni(int layer, String field, int gear, String controllerKey, float delay, float duration, int easing, float value)
  {
    Object obj = new Object();

    if (controllerKey.contains("GEAR"))
    {
      obj = layers.get(layer).gears.get(gear).vector;
      if (field == "petals" || field == "connect")
      {
        obj = layers.get(layer).gears.get(gear);
      }
    }

    if (controllerKey.contains("COLOR"))
    {
      obj = layers.get(layer);
    }
    
    ani =  new Ani(obj, duration, delay, field, value, easings[easing]);
    ani.setPlayMode(Ani.FORWARD);
    ani.noRepeat();    
  }


  /* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   P L A Y  M E T H O D S   
   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

  void aniCheckForEnd()
  {
    if (seq != null)
    {
      if (seq.isEnded())
      {
        if(pause == false )
        {
          controller.getInitialLayerState();
          println("sequence has ended");
        }
        pause = true;
      }
    }
  }
}