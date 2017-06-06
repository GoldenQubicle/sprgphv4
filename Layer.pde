class Layer 
{
  PVector xyz = new PVector();
  ArrayList<PVector> gears = new ArrayList<PVector>();
  ArrayList<PVector> radii = new ArrayList<PVector>();
  IntList petals = new IntList();
  int numberOfGears;
  color cFill, cStroke;
  float Density, lineX, lineY, strokeWidth, theta;  
  boolean stroke, fill;

  Layer(int gN, float density)
  {
    numberOfGears = gN;
    Density = density;
    lineX = 1;
    lineY = 1;
    strokeWidth = 1;
    
    cFill = color(random(155, 255), random(155, 255), random(155, 255));
    cStroke = color(random(155, 255), random(155, 255), random(155, 255));

    for (int i = 0; i < numberOfGears; i++) 
    {
      gears.add(i, new PVector());
      radii.add(i, new PVector(random(5, 25), random(5, 25)));
      petals.set(i, int(random(3, 11)));
    }
  }


  void displayStyle() 
  {
    lineWidthHeight(lineX, lineY);
    strokeWidth(strokeWidth);
    colorFillStroke(fill, stroke, cFill, cStroke);
  }

  void lineWidthHeight(float lx, float ly)
  {
    lineX = lx;
    lineY = ly;
  }

  void strokeWidth(float sw) 
  {
    strokeWidth = sw;
    strokeWeight(strokeWidth);
  }

  void colorFillStroke(boolean f, boolean s, color fi, color st)
  {
    fill = f;
    stroke = s;
    cFill = fi;
    cStroke = st;

    if (fill != true) 
    {
      noFill();
    } else 
    {
      fill(cFill);
    }
    
    if (stroke != true) 
    {
      noStroke();
    } else 
    {
      stroke(cStroke);
    }
  }

  int getNumberOfGears() 
  {
    return numberOfGears;
  }

  // layer needs to have display method in order for derived classes to override it =) 
  void display() 
  {
  }
}