class Spiro extends Layer 
{

  Spiro() 
  {
    super(3, 25000, 0);
    fill = true;
    stroke = false;
  }

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
    if (Lock != true)
    {
      for (int i = 0; i < getNumberOfGears(); i++) 
      {
        theta = (TAU/density)*t;      
        float ratio = 1/float(petals.get(i)-1);
        gears.get(i).x = cos(theta/ratio)*radius.get(i).x; 
        gears.get(i).y = sin(theta/ratio)*radius.get(i).y;
        loc.add(gears.get(i));
      }
    }
    return loc;
  }
}