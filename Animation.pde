
class Animation

{
  Ani test, test2;

  Animation()
  {
  }
  
  
  void aniTest()
  {
    // if(propertyList.getValue == "cFill")
   Object fill = layers.get(gui.layerSelected);
      
   
   Spiro spiro = (Spiro)layers.get(gui.layerSelected);
   Object connect = spiro.gears.get(1);
   Object petalsProps =  spiro.gears.get(0);   
 
   
   Ani test = new Ani(connect, 200,"connect", 50);
   Ani test2 = new Ani(petalsProps, 100, "petals", 50);
    
    
    if(keyPressed == true)
    {
     test.start();
     test2.start();
    //println( test2);
    }
  }
  
  

}