class Lines extends Spiro
{ 
  IntList connect = new IntList();
  ArrayList<PVector> radius2 = new ArrayList<PVector>();
  PVector xy2 = new PVector();

  Lines()
  {       
    super(1);

    fill = false;
    stroke = true;

    for (int i = 0; i < numberOfVectors; i++) 
    {
      addVectors();
    }

    vectorProperties.append("connect");
  }


  /* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   D E F A U L T   M E T H O D S
   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

  void display() 
  {
    displayStyle();  

    for (int i = 0; i < getNumberOfVectors(); i++) 
    {
      for (int j = 0; j < getPetals(i); j++)
      {
        theta = (TAU/getPetals(i))*j;      
        phi = (TAU/getPetals(i))*(j+getConnect(i));          
        if (lock != true)
        {
          xyz =  grinding()[0];
          xy2 =  grinding()[1];

          line(xyz.x, xyz.y, xy2.x, xy2.y);
        }
      }
    }
  }

  PVector[] grinding()
  {
    PVector [] location = new PVector[2];
    PVector loc = new PVector();
    PVector loc2 = new PVector();

    //if (lock != true)
    //{
    for (int i = 0; i < getNumberOfVectors(); i++) 
    {
              ratio = 1/(getPetals(i)-1);

      radius.get(i).x = cos(theta/ratio)*vectors.get(i).x; 
      radius.get(i).y = sin(theta/ratio)*vectors.get(i).y;
      radius2.get(i).x = cos(phi/ratio)*vectors.get(i).x;
      radius2.get(i).y = sin(phi/ratio)*vectors.get(i).y;
      location[0] = loc.add(radius.get(i));
      location[1] = loc2.add(radius2.get(i));
    }
    //}
    return location;
  }

  /* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~  
   G E T  &  S E T   M E T H O D S    
   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

  float getConnect(int gear)
  {
    return connect.get(gear);
  }

  void setConnect(int gear, int petal)
  {
    connect.set(gear, petal);
  }

  /* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~  
   O V E R R I D E   M E T H O D S    
   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

  void addVectors()
  {
    super.addVectors();
    connect.append(int(random(3, 10)));
    radius2.add(new PVector());
  }

  void deleteVectors(int del)
  { 
    super.addVectors();
    connect.remove(del);
    radius2.remove(del);
  }
}