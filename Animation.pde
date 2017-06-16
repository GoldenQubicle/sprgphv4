class Animation
{


  Animation()
  {
  }
  
  void anis()
  {
       Ani test = new Ani(layers.get(gui.layerSelected).props.get("x"), 120, "x", 200); 
      
      if(keyPressed == true){
        test.start();
        println("ani start " + layers.get(gui.layerSelected).props.get("x"));
      }
      
      
      println(layers.get(gui.layerSelected).props.get("x"));
  }
  
}