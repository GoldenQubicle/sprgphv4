class Layer 
{
  PVector xyz = new PVector();
  ArrayList<PVector> vectors = new ArrayList<PVector>();
  ArrayList<Gears> gears = new ArrayList<Gears>();
  int numberOfGears;
  color cFill, cStroke;
  float density, lineX, lineY, strokeWidth, theta, phi, ratio;  
  boolean stroke, fill;
  String type;
  StringList properties = new StringList("x", "y");

  private Layer(int gN, float d, int t)
  {
    type = layerTypes.get(t);
    numberOfGears = gN;
    density = d;
    lineX = 1;
    lineY = 1;
    strokeWidth = 1;
    cFill = color(random(155, 255), random(155, 255), random(155, 255));
    cStroke = color(random(155, 255), random(155, 255), random(155, 255));
  }

  /* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   D E F A U L T   M E T H O D S
   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

  String getType()
  {
    return type;
  }

  PVector getGearVectors(int gear)
  {
    return gears.get(gear).vector ;
  }

  void setGearVectors(int gear, PVector xy)
  {
    gears.get(gear).vector.x = xy.x;
    gears.get(gear).vector.y = xy.y;
  }

  int getNumberOfGears() 
  {
    return numberOfGears;
  }

  void setNumberOfGears(int gears)
  {
    numberOfGears=gears;
  }


  /* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~  
   G E A R ~~~~ O V E R R I D E      
   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

  void addGears()
  {
    Gears newGear = new Gears(type);
    gears.add(newGear);
  }

  void deleteGears(int del)
  {
    gears.remove(del);
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
  void display() 
  {
  }
}