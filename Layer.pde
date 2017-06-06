class Layer  {

  PVector xyz = new PVector();
  ArrayList<PVector> gears = new ArrayList<PVector>();
  ArrayList<PVector> radii = new ArrayList<PVector>();
  IntList petals = new IntList();
  int numberOfGears;
  color cFill, cStroke;
  float Density, lx, ly, sw, theta;  

  Layer(int gN, float density) {

    numberOfGears = gN;
    Density = density;
    lx = 1;
    ly = 1;
    sw = 1;

    cFill = color(random(155, 255), random(155, 255), random(155, 255));
    cStroke = color(random(155, 255), random(155, 255), random(155, 255));

    for (int i = 0; i <= numberOfGears; i++) {
      gears.add(i, new PVector());
      radii.add(i, new PVector(random(5,50), random(5,50), 0));
      petals.set(i,int(random(3,18)));
    }
  }
  
  void gearControls(){
    
  }
  
  int gearsGet(){
   return numberOfGears-1; 
  }
  
  // layer needs to have display method in order for derived classes to be, well, displayed =) 
  void display(){    
  }
 
}