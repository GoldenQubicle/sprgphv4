class Spiro extends Layer {


  Spiro() {
    super(13, 50000);
  }

  void display() {
    for (int t = 0; t < Density; t++) {   
      xyz = grinding(t);
      noStroke();
      fill(cFill);
      ellipse(xyz.x, xyz.y, lx, ly);
    }
  }

  PVector grinding(float t) {
    PVector loc = new PVector();
    for (int i = 0; i < gears.size(); i++) {
      theta = (TAU/Density)*t;
      float ratio = 1/float(petals.get(i)-1);
      gears.get(i).x = cos(theta/ratio)*radii.get(i).x; 
      gears.get(i).y = sin(theta/ratio)*radii.get(i).y;
      loc.add(gears.get(i));
    }
    return loc;
  }
}