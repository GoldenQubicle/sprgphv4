class Spiro3D extends Spiro
{
  ArrayList<PVector> sphere = new ArrayList<PVector>();

  Spiro3D()
  {
    super(2);
    fill = false;
    stroke = true;
    
    gearProp.add("z");

    for (int i = 0; i < numberOfGears; i++) 
    {
      addGears();
    }
    density = 200;
  }
  
  /* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   D E F A U L T   M E T H O D S
   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

  void display()
  {
    lighting();
    displayStyle();

    pushMatrix();
    translate(-width/2, -height/2);

    beginShape(QUAD_STRIP);

    for (int t = 0; t < density; t++)
    {
      theta = (TAU/density)*t;
      for (int p = 0; p < density; p++)
      {
        phi = (TAU/density)*p;        
        if (lock != true)
        {          
          xyz = grinding()[0];
          //curveVertex(xyz.x, xyz.y, xyz.z);
          vertex(xyz.x, xyz.y, xyz.z);
        }
      }
    }

    endShape(CLOSE);

    popMatrix();
  }

  PVector [] grinding()
  {
    PVector [] location = new PVector[2];
    PVector loc = new PVector();

    for (int i = 0; i < getNumberOfGears(); i++) 
    {
      ratio = 1/(getPetals(i)-1);
      sphere.get(i).x = cos(theta/ratio)*sin(phi/ratio)*getGearVectors(i).x; 
      sphere.get(i).y = sin(theta/ratio)*sin(phi/ratio)*getGearVectors(i).y;
      sphere.get(i).z = cos(phi/ratio)*getGearVectors(i).z;
      location[0] = loc.add(sphere.get(i));
    }
    return location;
  }

 void lighting()
  {
    directionalLight(204, 204, 204, .5, 0, -1);
    //ambientLight(50, 102, 102);
    emissive(128, 26, 51);
  }
  
  /* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~  
   P R O P E R T I E S ~~~~  L T Y P E      
   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

  void setZDepth(int gear, float z)
  {
    gears.get(gear).vector.z = z;
  }

  /* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~  
   P R O P E R T I E S ~~~~ O V E R R I D E      
   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

  void addGears()
  {
    super.addGears();
    sphere.add(new PVector());
  }

  void deleteGears(int del)
  {
    super.deleteGears(del);
    sphere.remove(del);
  }
}