class Mesh extends Spiro
{
   ArrayList<PVector> vectorPath = new ArrayList<PVector>();  
  ArrayList<PVector> vertexR0ng = new ArrayList<PVector>(); 
  ArrayList<PVector> vertexR1ng = new ArrayList<PVector>(); 
  PVector n0rm, n1rm;

  // stuff for vertexCirle
  int resolution = 16;
  PVector radius = new PVector(5, 5, 5);

  Mesh()
  {
    super(3);
    density = 500;
    fill = true;
    stroke = false;

    for (int i = 0; i < numberOfGears; i++) 
    {
      addGears();
    }

    // setting up first 3 vector path points
    for (int i = 0; i < 3; i++)
    {
      PVector xyz = new PVector();
      xyz = grinding(i)[0]; 
      vectorPath.add(xyz);
    }
  }

  void lighting()
  {
    directionalLight(204, 204, 204, .5, 0, -1);
    //ambientLight(50, 102, 102);
    emissive(128, 26, 51);
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
        n0rm = getNormal(vectorPath.get(0), vectorPath.get(1));
        n1rm = getNormal(vectorPath.get(1), vectorPath.get(2));

        vertexR0ng = getVertexRingPos(n0rm, vectorPath.get(0));
        vertexR1ng = getVertexRingPos(n1rm, vectorPath.get(1));

        for (int v = 0; v < resolution; v++) {          
          vertex(vertexR0ng.get(v).x, vertexR0ng.get(v).y, vertexR0ng.get(v).z);
          vertex(vertexR1ng.get(v).x, vertexR1ng.get(v).y, vertexR1ng.get(v).z);
        }

        vectorPath.set(0, vectorPath.get(1));
        vectorPath.set(1, vectorPath.get(2));
        vectorPath.set(2, grinding(t)[0]);
      }
    }
    endShape(CLOSE);
    popMatrix();
  }

  ArrayList<PVector> getVertexRingPos(PVector normal, PVector pLoc)
  { 
    pushMatrix();
    translate(pLoc.x, pLoc.y);  
    pushMatrix();
    rotate(-normal.heading());
    pushMatrix();
    rotateY(PI/2);
    rotateX(PI/2);
    ArrayList<PVector> vertexRingPos = new ArrayList<PVector>(recordPosition(vertexCirle()));
    popMatrix();
    popMatrix();
    popMatrix();
    return vertexRingPos;
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

  PVector getNormal(PVector current, PVector next)
  {
    PVector normal = new PVector();
    PVector delta = PVector.sub(next, current);
    normal.x = delta.y;
    normal.y = delta.x;               
    return normal;
  }

  ArrayList<PVector> vertexCirle()
  {
    ArrayList<PVector> ring = new ArrayList<PVector>();
    for (int i = 0; i < resolution; i++)
    {     
      float thetaR = (TAU/resolution)*i;
      PVector circle = new PVector();
      circle.x = cos(thetaR)*radius.x;
      circle.y = sin(thetaR)*radius.y;
      circle.z = radius.z;
      ring.add(circle);
    }
    return ring;
  }

  PVector getMeshRadius()
  {
    return radius;
  }

  void setMeshRadius(float x, float y, float z)
  {
    radius.x = x;
    radius.y = y;
    radius.z = z;
  }
}