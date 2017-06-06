class Spiro extends Layer 
{

  Spiro() 
  {
    super(9, 25000);
    fill = true;
    stroke = false;
  }

  void display() 
  {
    displayStyle();  
    for (int t = 0; t < Density; t++)
    {   
      xyz = grinding(t);
      ellipse(xyz.x, xyz.y, lineX, lineY);
    }
  }

  PVector grinding(float t)
  {
    PVector loc = new PVector();
    for (int i = 0; i < gears.size(); i++) 
    {
      theta = (TAU/Density)*t;      
      float ratio = 1/float(petals.get(i)-1);
      gears.get(i).x = cos(theta/ratio)*radii.get(i).x; 
      gears.get(i).y = sin(theta/ratio)*radii.get(i).y;
      loc.add(gears.get(i));
    }
    return loc;
  }
}