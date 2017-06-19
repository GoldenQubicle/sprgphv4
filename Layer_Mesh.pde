class Mesh extends Spiro
{
  PVector prev = new PVector();
  PVector next = new PVector();
  PVector normal = new PVector();

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

        xyz = grinding(t)[0];
        
        float h = xyz.heading();
        //prev = grinding(t-1)[0];
        //next = grinding(t+1)[0];
        //float anglePrev = PVector.angleBetween(xyz, prev);
        //float angleNext = PVector.angleBetween(xyz, next);

        meshBuild(h);
      }
    }
    popMatrix();
  }


  void meshBuild(float h)
  {     

    pushMatrix();
    translate(xyz.x, xyz.y);        
    //rotateX(-h);
    rotateY(-h);
    //rotateX(p);
    //rotateY(-n);
    //rotateZ(p);
    vertexCirle();
    popMatrix();
  }


  void vertexCirle()
  {
    PVector circle = new PVector();
    PVector radius = new PVector(2.5, 2.5);
    float theta;
    int resolution = 16;
    beginShape(); 
    for (int i = 0; i < resolution; i++)
    {
      rotateX(90);
      theta = (TAU/resolution)*i;
      circle.x = cos(theta)*radius.x;
      circle.y = sin(theta)*radius.y;
      vertex(circle.x, circle.y);
    }

    endShape(CLOSE);
  }
}