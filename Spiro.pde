class Spiro extends Layer 
{
  ArrayList<PVector> radius = new ArrayList<PVector>();
  IntList petals = new IntList();

  Spiro(int type) 
  {

    super(2, 2000, type);
    fill = true;
    stroke = false;

    // yeah this is a bit hacky, but thats because lines extends spiro
    // hence need to perform a type check to disable this call for line type
    if (getType() == "SPIRO") 
    {
      for (int i = 0; i < numberOfVectors; i++) 
      {
        addVectors();
      }
    }
    
    vectorProperties.append("petals");
  }


  /* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   D E F A U L T   M E T H O D S
   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

  void display()  //<>//
  {
    displayStyle();  

    for (int t = 0; t < density; t++)
    {   
      xyz = grinding(t)[0];
      ellipse(xyz.x, xyz.y, lineX, lineY);
    }
  }

  PVector [] grinding(float t)
  {
    PVector [] location = new PVector[1];
    PVector loc = new PVector();
    if (lock != true)
    {
      for (int i = 0; i < getNumberOfVectors(); i++) 
      {
        theta = (TAU/density)*t;      
        ratio = 1/float(petals.get(i)-1);
        radius.get(i).x = cos(theta/ratio)*vectors.get(i).x; 
        radius.get(i).y = sin(theta/ratio)*vectors.get(i).y;
        location[0] = loc.add(radius.get(i));
      }
    }
    return location;
  }


  /* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~  
   G E T  &  S E T   M E T H O D S    
   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

  float getPetals(int gear)
  {
    return petals.get(gear);
  }

  void setPetals(int gear, int petal)
  {
    petals.set(gear, petal);
  }


  /* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~  
   O V E R R I D E   M E T H O D S    
   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

  void addVectors()
  {
    super.addVectors();
    radius.add(new PVector());
    petals.append(int(random(3, 11)));
  }

  void deleteVectors(int del)
  {
    super.deleteVectors(del);
    radius.remove(del);
    petals.remove(del);
  }
}