class Animation
{
  Easing[] easings = { Ani.LINEAR, Ani.QUAD_IN, Ani.QUAD_OUT, Ani.QUAD_IN_OUT, Ani.CUBIC_IN, Ani.CUBIC_IN_OUT, Ani.CUBIC_OUT, Ani.QUART_IN, Ani.QUART_OUT, Ani.QUART_IN_OUT, Ani.QUINT_IN, Ani.QUINT_OUT, Ani.QUINT_IN_OUT, Ani.SINE_IN, Ani.SINE_OUT, Ani.SINE_IN_OUT, Ani.CIRC_IN, Ani.CIRC_OUT, Ani.CIRC_IN_OUT, Ani.EXPO_IN, Ani.EXPO_OUT, Ani.EXPO_IN_OUT, Ani.BACK_IN, Ani.BACK_OUT, Ani.BACK_IN_OUT, Ani.BOUNCE_IN, Ani.BOUNCE_OUT, Ani.BOUNCE_IN_OUT, Ani.ELASTIC_IN, Ani.ELASTIC_OUT, Ani.ELASTIC_IN_OUT};
  String[] EasingNames = {"LINEAR", "QUAD_IN", "QUAD_OUT", "QUAD_IN_OUT", "CUBIC_IN", "CUBIC_IN_OUT", "CUBIC_OUT", "QUART_IN", "QUART_OUT", "QUART_IN_OUT", "QUINT_IN", "QUINT_OUT", "QUINT_IN_OUT", "SINE_IN", "SINE_OUT", "SINE_IN_OUT", "CIRC_IN", "CIRC_OUT", "CIRC_IN_OUT", "EXPO_IN", "EXPO_OUT", "EXPO_IN_OUT", "BACK_IN", "BACK_OUT", "BACK_IN_OUT", "BOUNCE_IN", "BOUNCE_OUT", "BOUNCE_IN_OUT", "ELASTIC_IN", "ELASTIC_OUT", "ELASTIC_IN_OUT"};

  Ani test, test2, test3;
  int tracks;

  Animation()
  {
  }

  void aniTest()
  {
    // if(propertyList.getValue == "cFill")
    //Object fill = layers.get(gui.layerSelected);


    //Spiro spiro = (Spiro)layers.get(gui.layerSelected);
    //Object petalsProps =  spiro.gears.get(0);

    //Object vector = layers.get(gui.layerSelected).gears.get(0).vector;
    //Object vector2 = layers.get(gui.layerSelected).gears.get(1).vector;

    //Ani test = new Ani(vector, 200, 60, "x", 150);
    //Ani test2 = new Ani(petalsProps, 230, 30, "petals", 100);
    //Ani test3 = new Ani(vector2, 260, 0, "y", 150);


    if (keyPressed == true)
    {
      //test.start();
      //test2.start();
      //test3.start();
      //println( test2);
    }
  }
}