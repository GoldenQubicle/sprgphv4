class Gears
{
  PVector vector; 
  int petals, connect;

  Gears(String lType)
  {
    vector = new PVector(random(5, 25), random(5, 25));

    switch(lType)
    {

    case "SPIRO":
      petals = int(random(3, 11));
      break;

    case "LINES":
      petals = int(random(3, 11));      
      connect = int(random(3, 11));
      break;

    case "SPIRO3D":
      petals = int(random(3, 11));
      break;

    case "MESH":
      petals = int(random(3, 11));
      break;
    }
  }
}