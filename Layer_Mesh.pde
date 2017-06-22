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
    beginShape(TRIANGLE_STRIP); 

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
        for(PVector vert : meshBuild(normal))
        {
        vertex(vert.x, vert.y, vert.z);
        }

        //vertex(meshBuild(normal).x, meshBuild(normal).y);
      }
    }
    endShape();

    popMatrix();
  }


  ArrayList<PVector> meshBuild(PVector n)
  { 
    pushMatrix();
    translate(xyz.x, xyz.y);  
    pushMatrix();
    rotate(-n.heading());
    pushMatrix();
    rotateY(PI/2);
    rotateX(PI/2);

   ArrayList<PVector> drawMesh = new ArrayList<PVector>(recordPosition(vertexCirle()));
    popMatrix();
    popMatrix();
    popMatrix();
    return drawMesh;
  }

  ArrayList<PVector> recordPosition(ArrayList<PVector> ring )
  {
    ArrayList<PVector> vertexRing = new ArrayList<PVector>();
    for (PVector vertice : ring)
    {
      PVector ringLoc = new PVector();
      ringLoc.x = modelX(vertice.x, vertice.y, vertice.z);
      ringLoc.y = modelY(vertice.x, vertice.y, vertice.z);
      ringLoc.z = modelZ(vertice.x, vertice.y, vertice.z);
      vertexRing.add(ringLoc);
    }
    return vertexRing;
  }
  
  
  ArrayList<PVector> vertexCirle()
  {
    ArrayList<PVector> ring = new ArrayList<PVector>();
    for (int i = 0; i < resolution; i++)
    {     
      theta = (TAU/resolution)*i;
      circle = new PVector();
      circle.x = cos(theta)*radius.x;
      circle.y = sin(theta)*radius.y;
      circle.z = 0;
      ring.add(circle);
    }
    return ring;
  }
  
  
  
}