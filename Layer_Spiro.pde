class Spiro extends Layer 
{
  ArrayList<PVector> circ = new ArrayList<PVector>();
  IntList petals = new IntList();

  Spiro(int type) 
  {

    super(2, 2000, type);
    fill = true;
    stroke = false;

    properties.append("petals");

    // yeah this is a bit hacky, but thats because lines extends spiro
    // hence need to perform a type check to disable this call for line type
    if (getType() == "SPIRO") 
    {
      for (int i = 0; i < numberOfGears; i++) 
      {
        addProperties();
      }
    }
  }


  /* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   D E F A U L T   M E T H O D S
   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

  void display() 
  {
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

    for (int i = 0; i < getNumberOfGears(); i++) 
    {
      theta = (TAU/density)*t;      
      ratio = 1/(getPetals(i)-1);
      circ.get(i).x = cos(theta/ratio)*vectors.get(i).x; 
      circ.get(i).y = sin(theta/ratio)*vectors.get(i).y;
      location[0] = loc.add(circ.get(i));
    }
    return location;
  }


  /* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~  
   P R O P E R T I E S ~~~~  L T Y P E      
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
   P R O P E R T I E S ~~~~ O V E R R I D E      
   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

  void addProperties()
  {
    super.addProperties();
    circ.add(new PVector());
    petals.append(int(random(3, 11)));
  }

  void deleteProperties(int del)
  {
    super.deleteProperties(del);
    circ.remove(del);
    petals.remove(del);
  }
}