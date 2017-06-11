class Spiro extends Layer 
{
  ArrayList<PVector> radius = new ArrayList<PVector>();
  IntList petals = new IntList();

  Spiro() 
  {
    super(2, 25000, 0);
    fill = true;
    stroke = false;
    for (int i = 0; i < numberOfVectors; i++) 
    {
      radius.add(i, new PVector());
      petals.set(i, int(random(3, 11)));
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
      xyz = grinding(t);
      ellipse(xyz.x, xyz.y, lineX, lineY);
    }
  }

  PVector grinding(float t)
  {
    PVector loc = new PVector();
    if (lock != true)
    {
      for (int i = 0; i < getNumberOfVectors(); i++) 
      {
        theta = (TAU/density)*t;      
        float ratio = 1/float(petals.get(i)-1);
        radius.get(i).x = cos(theta/ratio)*vectors.get(i).x; 
        radius.get(i).y = sin(theta/ratio)*vectors.get(i).y;
        loc.add(radius.get(i));
      }
    }
    return loc;
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

  float getPetals(int gear)
  {
    return petals.get(gear);
  }

  public void setPetals(int gear, int petal)
  {
    petals.set(gear, petal);
  }
}