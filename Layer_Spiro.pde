class Spiro extends Layer  //<>//
{
  ArrayList<PVector> circ = new ArrayList<PVector>();
  IntList petals = new IntList();

  Spiro(int type) 
  {
    super(1, 2000, type);
    fill = true;
    stroke = false;

    gearProp.append("petals");
 

    // yeah this is a bit hacky, but thats because lines & mesh extends spiro
    // hence need to perform a check to disable this call for those layerTypes
    if (getType() == "SPIRO" ) 
    {
      for (int i = 0; i < numberOfGears; i++) 
      {
        addGears();
      }
    }
  }

  /* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   D E F A U L T   M E T H O D S
   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

  void display() 
  {
    cam.setActive(false);

    displayStyle();  

    for (int t = 0; t < density; t++)
    {   
      if (lock != true)
      {
        xyz = grinding(t)[0];
        ellipse(xyz.x, xyz.y, lineX, lineY);
      }
    }
  }

  PVector [] grinding(float t)
  {
    PVector [] location = new PVector[1];
    PVector loc = new PVector();

    for (int i = 0; i < super.getNumberOfGears(); i++) 
    {
      theta = (TAU/density)*t;      
      ratio = 1/(getPetals(i)-1);
      circ.get(i).x = cos(theta/ratio)*getGearVectors(i).x; 
      circ.get(i).y = sin(theta/ratio)*getGearVectors(i).y;
      location[0] = loc.add(circ.get(i));
    }
    return location;
  }

  /* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~  
   P R O P E R T I E S ~~~~  L T Y P E      
   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

  float getPetals(int gear)  
  {
    return gears.get(gear).petals;
  }

  void setPetals(int gear, int petal)
  {
    gears.get(gear).petals = petal;
  }

  /* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~  
   P R O P E R T I E S ~~~~ O V E R R I D E      
   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

  void addGears()
  {
    super.addGears();
    circ.add(new PVector());
  }

  void deleteGears(int del)
  {
    super.deleteGears(del);
    circ.remove(del);
  }
}