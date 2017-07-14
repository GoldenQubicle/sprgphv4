class FileIO {
  ObjectMapper mapper = new ObjectMapper();


  FileIO()
  {
    mapper.configure(SerializationFeature.FAIL_ON_EMPTY_BEANS, false);
    mapper.setVisibility(PropertyAccessor.FIELD, JsonAutoDetect.Visibility.ANY);
  }


  void saveLayer()
  {

    //for (Layer myLayer : layers)
    //{
      try {

        mapper.writerWithDefaultPrettyPrinter().writeValue(new File("C:\\Users\\Erik\\Documents\\Processing\\sprgphv4\\test.json"), layers);
      } 
      catch(IOException ie) {
        ie.printStackTrace();
      }
    //}
  }

  void saveAni()
  {
    for (Ani myAni : gif.aniSegments.values())
    {
      try {

        mapper.writerWithDefaultPrettyPrinter().writeValue(new File("C:\\Users\\Erik\\Documents\\Processing\\sprgphv4\\test.json"), myAni);
      } 
      catch(IOException ie) {
        ie.printStackTrace();
      }
    }
  }
  
  void saveCP5()
  {
     try {

        mapper.writerWithDefaultPrettyPrinter().writeValue(new File("C:\\Users\\Erik\\Documents\\Processing\\sprgphv4\\test.json"), gui.cp5.get(Accordion.class,"gearControls"));
      } 
      catch(IOException ie) {
        ie.printStackTrace();
      }
    
  }
}