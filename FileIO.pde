class FileIO {
  ObjectMapper mapper = new ObjectMapper();


  FileIO()
  {
    mapper.configure(SerializationFeature.FAIL_ON_EMPTY_BEANS, false);
    mapper.setVisibility(PropertyAccessor.FIELD, JsonAutoDetect.Visibility.ANY);
  }


  void loadLayers()
  {
    //try 
    //{
    //  Layer lImport = new Layer();
    //  lImport = mapper.readValue(new File("C:\\Users\\Erik\\Documents\\Processing\\sprgphv4\\layerImport.json"), Layer.class);
    //  println(lImport.type, lImport.getNumberOfGears());
    //} 
    //catch(IOException ie) {
    //  ie.printStackTrace();
    //}
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
    try 
    {
      mapper.writerWithDefaultPrettyPrinter().writeValue(new File("C:\\Users\\Erik\\Documents\\Processing\\sprgphv4\\test.json"), " ");
    } 
    catch(IOException ie) {
      ie.printStackTrace();
    }
  }
}