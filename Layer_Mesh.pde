class Mesh extends Spiro
{
  PVector prev = new PVector();
  PVector next = new PVector();
  PVector normal = new PVector();
  PVector xy2 = new PVector();
  // stuff for vertexCirle
  float thetaR, phiR;
  int resolution = 16;
  PVector radius = new PVector(5, 5, 5);
  PVector circle = new PVector();
  PVector ring = new PVector();

  Mesh()
  {
    super(0);
    density = 500;
    fill = true;
    stroke = false;
  }

  void lighting()
  {
    directionalLight(204, 204, 204, .5, 0, -1);
    //ambientLight(50, 102, 102);
    emissive(0, 26, 51);
  }

  void display()
  {
    lighting();
    displayStyle();
    pushMatrix();
    translate(-width/2, -height/2); 
    beginShape(TRIANGLE_STRIP); 

    for (int t = 0; t < density; t++)
    {   
      if (lock != true)
      {
        xyz = grinding(t)[0]; 
        xy2 = grinding(t+1)[0];

        for (int v = 0; v < resolution; v++) {

          vertex(meshBuild(getNormal(t, xyz), xyz).get(v).x, meshBuild(getNormal(t, xyz), xyz).get(v).y, meshBuild(getNormal(t, xyz), xyz).get(v).z);

          vertex(meshBuild(getNormal(t+1, xy2), xy2).get(v).x, meshBuild(getNormal(t+1, xy2), xy2).get(v).y, meshBuild(getNormal(t+1, xy2), xy2).get(v).z);
        }
      }
    }
    endShape();
    popMatrix();
  }


  ArrayList<PVector> meshBuild(PVector n, PVector pLoc)
  { 
    pushMatrix();
    translate(pLoc.x, pLoc.y);  
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

  PVector getNormal(int t, PVector pLoc)
  {
    if (lock != true)
    {
      prev = new PVector();
      next = new PVector();
      normal = new PVector();

      prev = grinding(t-1)[0]; //b
      next = grinding(t+1)[0]; // c

      PVector ab = PVector.sub(next, pLoc);
      PVector ac = PVector.sub(prev, pLoc);

      normal.x = ab.y;
      normal.y = ab.x;           

      //if (PVector.dot(normal, ac) > 0)
      //{
      //  normal.mult(-1);
      //}
    }
    return normal;
  }
}