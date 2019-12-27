float startXPos = 0.0, destXPos = 0.0, startYPos = 0.0, destYPos = 0.0;
float move =0.0;
float fov = PI/3.0;
float buoyY =0.0;

int pressTime, currTime, objectStartTime;
int view = 0; // 0 is ortho, 1 is perspective. 
int countRow = 0;
int counTcOL =0;
int worldZ;
int clicked = 0;

char roDirection = ' ';
boolean pressed =false;
boolean exploded = false;

ArrayList <Cube[]> world  = new ArrayList<Cube[]>();
Cube[] objects = new Cube[10]; // the list of objects
Plane plane;

final int WIDTH = 15;
final float  MOVE = 1.0;//length of a cube.
final float BOUND_DIST =0.4;
final float DURATION = 100.0;
final float OBJ_DURATION =1000.0;


PImage wood, stone, wave;
PShape boatShape;
PShape buoyShape;


void setup()
{
  size(1000, 1000, P3D);
  ortho(-10, 10, 10, -10, -10, 14); // everything will look the same size. 
  //plane = new Plane(0, 1.5, 0);
  textureMode(NORMAL); // you want this!
  wood = loadImage("assets/woodTexture.png");
  stone = loadImage("assets/StoneFloorTexture.png");
  wave = loadImage("assets/wave.png");
  
  boatShape = loadShape("assets/boat.obj");
  boatShape.setTexture(wood);
  
  buoyShape = loadShape("assets/buoy.obj");
  buoyShape.setTexture(wood);
  
  plane = new Plane(0, 2, 0);
  worldZ =0;

  for (int i =0; i< 40; i++)
  {
    addRow();
  }
}

void addRow()
{
  Cube [] row =  new Cube[WIDTH];
  for (int j = 0; j<row.length; j ++ )
  {
    Cube newCube = new Cube();
    if (j-7 == 7 || j-7 == -7) //make it the rock
    {
      newCube.scale = random(1.2, 3.0);
      ;
    }
    row[j] = newCube;
  }
  world.add(row);
}

void draw()
{
  //plane.z -= .1;



  if (!isColliding())
  {
    plane.z -= .1;
  } else if (!exploded)
  {
    //explode function, which creates a particle system.

    explode();
    exploded = true;
  }

  if (plane.z + 20 < worldZ)
  {
    addRow();

    world.remove(0);
    worldZ-=1;
  }




  lerp(destXPos, startXPos, destYPos, startYPos);



  drawEverything();
}

float objectLerp(float destPosX, float startPosX)
{
  currTime = millis();
  float t = (currTime - objectStartTime) / OBJ_DURATION;
  float cosT = 1 - (cos(t * 2 * PI) + 1) / 2;
  float x = (destPosX * cosT) + startPosX * (1 - cosT);
  println("   t=" + t);
  if (objectStartTime + OBJ_DURATION < currTime)
  {
    objectStartTime = currTime;
    println("curr time greater    x=" + x);
  }
  return x;
}

void lerp(float destPosX, float startPosX, float destPosY, float startPosY)
{
  //println("lerping");
  currTime = millis();
  //println("Current Time: " + currTime + " planex: " + plane.x);
  if (pressTime + DURATION > currTime)
  {
    //println("still going on ");
    float t = (currTime - pressTime) / DURATION;
    float x = (destPosX * t) + startPosX * (1 - t);
    float y = (destPosY * t) + startPosY * (1 - t);
    plane.x = x;
    plane.y = y;

    if (roDirection == 'l')
    {
      //rotateZ(radians(20));
      plane.rotateZ = 20;
    } else if (roDirection == 'r')
    {
      plane.rotateZ = -20;
    } else if (roDirection == 'u')
    {
      plane.rotateX = 20;
    } else if (roDirection == 'd')
    {
      plane.rotateX = -20;
    }
  } else
  {
    clicked =0;
    plane.rotateZ = 0; 
    plane.rotateX = 0;
  }
}



void explode()
{
  plane.ps.origin = new PVector(plane.x, plane.y, plane.z);
  plane.ps.addParticles();
  // Draw the plane's   explosive particles
  exploded = false;
  println("plane X: " + plane.x + " plane Y: " +  plane.y + " plane Z: " + plane.z );
  println("particleSystem X: " + plane.ps.origin.x + " particleSystem Y: " +  plane.ps.origin.y + " particleSystem Z: " + plane.ps.origin.z );
  // plane = null; // stop referring to it.
}

boolean isColliding()
{
  boolean result = false;
  //get the position of the plane. find that position in the array
  int i, k, m, o;
  int j, l, n, p;
  float planeLeft = (plane.x + 0.5) - BOUND_DIST;
  float planeRight = (plane.x + 0.5) + BOUND_DIST;
  float planeFront = plane.z - BOUND_DIST;
  float planeBack = plane.z + BOUND_DIST;

  //for the front left corner of the bounding box
  i = (int)(- planeFront + worldZ);
  j = (int)(planeLeft + 7);

  //for the front right corner of the bounding box.
  k = (int)(- planeFront + worldZ);
  l = (int)(planeRight + 7);

  //for the back left corner of the bounding box.
  m = (int)(-planeBack + worldZ);
  n = (int)(planeLeft + 7);

  //for the back right corner of the bounding box.
  o = (int)(- planeBack + worldZ);
  p = (int)(planeRight + 7);

  // get the cubes that it could be colliding with 
  Cube frontLeftCube = world.get(i)[j]; 
  Cube frontRightCube = world.get(k)[l]; 
  Cube backLeftCube = world.get(m)[n]; 
  Cube backRightCube = world.get(o)[p]; 

  result = frontLeftCube.scale/2 > plane.y -0.01 || 
    frontRightCube.scale/2 > plane.y -0.01 ||
    backLeftCube.scale/2 > plane.y -0.01 || 
    backRightCube.scale/2 > plane.y -0.01;

  return result;
}

void keyPressed()
{
  //pressed = true;
  if (clicked == 0 && !exploded) {
    if (key== ' ')
    {

      view = view == 1  ? 0 : 1;
      //println(view);
    } else if (key == 'w')
    {
      clicked = 1;
      pressTime = millis();
      //println("pressed Time: " + pressTime);
      startXPos = destXPos;
      destXPos = startXPos;
      startYPos = plane.y;
      destYPos = startYPos + MOVE;
      roDirection = 'u';
    } else if (key == 'a')
    {
      if(plane.x > -6.5)
      {
        clicked = 1;
        pressTime = millis();
        // println("pressed Time: " + pressTime);
        startXPos = destXPos;
        destXPos = startXPos - MOVE;
        startYPos = plane.y;
        destYPos = startYPos;
        roDirection = 'l';
      }
      //rotateZ(radians(-20));
    } else if (key == 'd')
    {
      if(plane.x < 6.5)
      {
        clicked = 1;
        pressTime = millis();
        //println("pressed Time: " + pressTime);
        startXPos = destXPos;
        destXPos = startXPos + MOVE;
        startYPos = plane.y;
        destYPos = startYPos;
        roDirection = 'r';
      }
    } else if (key == 's')
    {
      clicked = 1;
      pressTime = millis();
      // println("pressed Time: " + pressTime);
      startXPos = destXPos;
      destXPos = startXPos;
      startYPos = plane.y;
      destYPos = startYPos- MOVE;
      roDirection = 'd';
    }
  }
}
