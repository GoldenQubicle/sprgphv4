class Animation
{
Ani test ;

  Animation()
  {
    test();
  }
  
  void test()
  {
    
        test  = new Ani(layers.get(gui.layerSelected).props, 120, "vX", 200);

  }

  void anis()
  {
    


    if (keyPressed == true) 
    {
      animate = true;
      test.start();
    }
    if (test.isEnded() == true)
    {
      animate = false;
    }
          println(test.isPlaying());

  }
}