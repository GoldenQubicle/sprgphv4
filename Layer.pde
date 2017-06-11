class Layer 
{
  PVector xyz = new PVector();
  ArrayList<PVector> vectors = new ArrayList<PVector>();
  int numberOfVectors;
  color cFill, cStroke;
  float density, lineX, lineY, strokeWidth, theta;  
  boolean stroke, fill;
  String type;

  private Layer(int vN, float d, int t)
  {
    type = layerTypes.get(t);
    numberOfVectors = vN;
    density = d;
    lineX = 1;
    lineY = 1;
    strokeWidth = 1;

    cFill = color(random(155, 255), random(155, 255), random(155, 255));
    cStroke = color(random(155, 255), random(155, 255), random(155, 255));

    for (int i = 0; i < numberOfVectors; i++) 
    {
      vectors.add(i, new PVector(random(5, 25), random(5, 25)));
    }
  }

  /* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   D E F A U L T   M E T H O D S
   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

  String getType()
  {
    return type;
  }

  PVector getVectors(int gear)
  {
    return vectors.get(gear);
  }

  void setVectors(int gear, PVector xy)
  {
    vectors.set(gear, xy);
  }

  int getNumberOfVectors() 
  {
    return numberOfVectors;
  }

  void setNumberOfVectors(int gear)
  {
    numberOfVectors=gear;
  }

  /* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   D I S P L A Y   M E T H O D S
   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

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

  /* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~  
   O V E R R I D E   M E T H O D S    
   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

  void display() 
  {
  }

  void addVectors()
  {
    vectors.add(new PVector(random(5, 25), random(5, 25)));
  }

  void deleteVectors(int del)
  {
    vectors.remove(del);
  }

  float getPetals(int gear)
  {
    return 0.0;
  }

  void setPetals(int gear, int petal)
  {
  }
}