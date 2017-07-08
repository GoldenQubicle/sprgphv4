class FileIO {
  ObjectMapper mapper = new ObjectMapper();


  FileIO()
  {
    mapper.configure(SerializationFeature.FAIL_ON_EMPTY_BEANS, false);
    mapper.setVisibility(PropertyAccessor.FIELD, JsonAutoDetect.Visibility.ANY);
  }


  void saveLayer()
  {

    for (Layer myLayer : layers)
    {
      try {

        mapper.writerWithDefaultPrettyPrinter().writeValue(new File("C:\\Users\\Erik\\Documents\\Processing\\sprgphv4\\test.json"), myLayer);
      } 
      catch(IOException ie) {
        ie.printStackTrace();
      }
    }
  }
}