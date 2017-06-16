class Lines extends Spiro
{ 
  IntList connect = new IntList();
  ArrayList<PVector> circ2 = new ArrayList<PVector>();
  PVector xy2 = new PVector();

  Lines()
  {       
    super(1);

    fill = false;
    stroke = true;

    properties.append("connect");

    for (int i = 0; i < numberOfGears; i++) 
    {
      addProperties();
    }
  }


  /* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   D E F A U L T   M E T H O D S
   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

  void display() 
  {
    displayStyle();  

    for (int i = 0; i < getNumberOfGears(); i++) 
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

    for (int i = 0; i < getNumberOfGears(); i++) 
    {
      ratio = 1/(getPetals(i)-1);
      circ.get(i).x = cos(theta/ratio)*vectors.get(i).x; 
      circ.get(i).y = sin(theta/ratio)*vectors.get(i).y;
      circ2.get(i).x = cos(phi/ratio)*vectors.get(i).x;
      circ2.get(i).y = sin(phi/ratio)*vectors.get(i).y;
      location[0] = loc.add(circ.get(i));
      location[1] = loc2.add(circ2.get(i));
    }
    return location;
  }

  /* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~  
   P R O P E R T I E S ~~~~  L T Y P E      
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
   P R O P E R T I E S ~~~~ O V E R R I D E      
   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

  void addProperties()
  {
    super.addProperties();
    connect.append(int(random(3, 10)));
    circ2.add(new PVector());
  }

  void deleteProperties(int del)
  { 
    super.deleteProperties(del);
    connect.remove(del);
    circ2.remove(del);
  }
}  