class Layer 
{
  PVector xyz = new PVector();
  ArrayList<PVector> gears = new ArrayList<PVector>();
  ArrayList<PVector> radius = new ArrayList<PVector>();
  IntList petals = new IntList();
  int numberOfGears;
  color cFill, cStroke;
  float density, lineX, lineY, strokeWidth, theta;  
  boolean stroke, fill;
  StringList types = new StringList("SPIRO", "TEST");
  String type;


  private Layer(int gN, float d, int t)
  {
    type = types.get(t);

    numberOfGears = gN;
    density = d;
    lineX = 1;
    lineY = 1;
    strokeWidth = 1;

    cFill = color(random(155, 255), random(155, 255), random(155, 255));
    cStroke = color(random(155, 255), random(155, 255), random(155, 255));

    for (int i = 0; i < numberOfGears; i++) 
    {
      gears.add(i, new PVector());
      radius.add(i, new PVector(random(5, 25), random(5, 25)));
      petals.set(i, int(random(3, 11)));
    }
  }

  void newVectors()
  {
    gears.add(new PVector());
    radius.add(new PVector(random(5, 25), random(5, 25)));
    petals.append(int(random(3, 11)));
  }

  void deleteVectors(int del)
  {
    gears.remove(del);
    radius.remove(del);
    petals.remove(del);
  }

  String getType()
  {
    return type;
  }

  float getPetals(int gear)
  {
    return petals.get(gear);
  }

  void setPetals(int gear, int petal)
  {
    petals.set(gear, petal);
  }

  PVector getRadius(int gear)
  {
    return radius.get(gear);
  }

  void setRadius(int gear, PVector xy)
  {
    radius.set(gear, xy);
  }

  int getNumberOfGears() 
  {
    return numberOfGears;
  }

  void setNumberOfGears(int gear)
  {
    numberOfGears=gear;
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

  // layer needs to have display method in order for derived classes to override it =) 
  void display() 
  {
  }
}