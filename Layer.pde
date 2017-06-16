class Layer 
{
  PVector xyz = new PVector();
  ArrayList<PVector> vectors = new ArrayList<PVector>();
  int numberOfGears;
  color cFill, cStroke;
  float density, lineX, lineY, strokeWidth, theta, phi, ratio;  
  boolean stroke, fill;
  String type;
  StringList properties = new StringList("vX", "vY");
  properties props = new properties();
  ;

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

  PVector getVectors(int gear)
  {
    if (animate == true)
    {
      return props.passBack().get(gear);
    } else {

      return vectors.get(gear);
    }
  }

  void setVectors(int gear, PVector xy)
  {
    vectors.set(gear, xy);
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
   P R O P E R T I E S ~~~~ O V E R R I D E      
   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

  void addProperties()
  {
    vectors.add(new PVector(random(5, 25), random(5, 25)));
    props.pass(vectors);
  }

  void deleteProperties(int del)
  {
    vectors.remove(del);
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

class properties 
{
  float vX, vY;

  properties()
  {
  }

  void pass( ArrayList<PVector> v)
  {
    for (int i = 0; i < v.size(); i++)
    {
       vX = v.get(i).x;
       vY = v.get(i).y;
    }
  }



  ArrayList<PVector> passBack()
  {
    ArrayList<PVector> v = new ArrayList<PVector>();
    for (int i = 0; i < layers.get(gui.layerSelected).getNumberOfGears(); i++)
    {
      PVector test = new PVector(vX, vY);
      v.add(test);
    }
    return v;
  }
}