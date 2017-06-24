class Controller
{


  Controller()
  {
  }


  List<String> addLayerPropertiesToTrack(int ls)
  {
    List<String> layerProperties = new ArrayList<String>();
    
    // setting up gearProperties first of all 
    for(int g = 0; g < layers.get(ls).getNumberOfGears(); g++)
    {
      for(int p = 0; p < layers.get(ls).gearProp.size(); p++){
        layerProperties.add("gear " + (g+1) + " "+  layers.get(ls).gearProp.get(p));
      }
    }
    return layerProperties;
  }

  void getLayerProperties()
  {
  }
}