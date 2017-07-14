class FileIO {
  ObjectMapper mapper = new ObjectMapper();


  FileIO()
  {
    mapper.configure(SerializationFeature.FAIL_ON_EMPTY_BEANS, false);
    mapper.setVisibility(PropertyAccessor.FIELD, JsonAutoDetect.Visibility.ANY);
  }

  void saveLayers()
  {
    try 
    {
      mapper.writerWithDefaultPrettyPrinter().writeValue(new File("C:\\Users\\Erik\\Documents\\Processing\\sprgphv4\\test.json"), layers);
    } 
    catch(IOException ie) {
      ie.printStackTrace();
    }
  }

  void saveAni()
  {
    for (Ani myAni : gif.aniSegments.values())
    {
      try 
      {
        mapper.writerWithDefaultPrettyPrinter().writeValue(new File("C:\\Users\\Erik\\Documents\\Processing\\sprgphv4\\test.json"), myAni);
      } 
      catch(IOException ie) {
        ie.printStackTrace();
      }
    }
  }

}