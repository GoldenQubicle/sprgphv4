class Mesh extends Spiro
{
  PVector prev = new PVector();
  PVector next = new PVector();
  PVector normal = new PVector();

  // stuff for vertexCirle
  float thetaR, phiR;
  int resolution = 12;
  PVector radius = new PVector(2.5, 2.5, 2.5);
  PVector circle = new PVector();
  PVector ring = new PVector();



  Mesh()
  {
    super(0);
    density = 500;
    fill = false;
    stroke = true;
  }

  void display()
  {
    displayStyle();
    pushMatrix();
    translate(-width/2, -height/2); 

    for (int t = 0; t < density; t++)
    {   
      if (lock != true)
      {
        xyz = grinding(t)[0]; // a

        // calculate normal
        prev = grinding(t-1)[0]; //b
        next = grinding(t+1)[0]; // c

        PVector ab = PVector.sub(next, xyz);
        PVector ac = PVector.sub(prev, xyz);

        normal.x = ab.y;
        normal.y = ab.x;           

        if (PVector.dot(normal, ac) > 0)
        {
          normal.mult(-1);
        }


        meshBuild(normal);
      }
    }
    popMatrix();
  }

  /* 2106 NOTE
  so yeah, in order to actually make a mesh, Id need to have two 'rings' so to speak
  or in other words, if I simply pass in the vertex cirlce per vector point, its going to connect the ring with itself
  there're couple of presumed solutions to this
  1) turn each cirle into a Pshape, store those and call methods - however, PShape creations slows things down dramatically
  2) have the vertexCirlce return a PVector array, store those inside another array, loop over it cleverly, i.e. alternating between two rings
  3) draw the vertices dynamically inside the density loop
  
  atm, option two seems to make the most sense because option one is slow as heck, and option three could very well end up with double vertices per ring
   
   */


  void meshBuild(PVector n)
  { 
    pushMatrix();
    translate(xyz.x, xyz.y);  
    pushMatrix();
    rotate(-n.heading());
    vertexCirle();    
    popMatrix();
    popMatrix();
  }


  void vertexCirle()
  {
    pushMatrix();
    rotateY(PI/2);
    rotateX(PI/2);
    beginShape(); 
    for (int i = 0; i < resolution; i++)
    {     
      theta = (TAU/resolution)*i;
      circle.x = cos(theta)*radius.x;
      circle.y = sin(theta)*radius.y;
      vertex(circle.x, circle.y);
    }
    endShape(CLOSE);
    popMatrix();
  }
}