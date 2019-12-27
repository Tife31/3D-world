class Cube
{
  int type;
  float scale = 1.0;
  color colour;
  PImage cubeTex;
  Object obj = null;

  Cube()
  {
    float random = random(1);
     if (random < 0.04)
    {
      //draw a red box.
      colour = color(3, 75, 97);
      type = 0;
      obj = new Boat();
      scale = 3.5;
      cubeTex = wave;
    } 
    else if (random < 0.08)
    {
      //draw a red box.
      colour = color(3, 75, 97);
      type = 0;
      obj = new Buoy();
      scale = 2.5;
      cubeTex = wave;
    } 
    else if (random < 0.8)
    {
      //draw as a blue cube represent obstacles.

      colour = color(188, 95, 106);
      type = 1;
      
      cubeTex = wave;
    } 
    else if (random < 0.9)
    {
      //scale(1, 2.5);
      colour = color(204, 138, 77);
      type = 2;
      cubeTex = wave;
    } 
    else
    {
      //fill(0);
      colour = color(154, 27, 39);
      type = 3;
      //scale = random(1.2, 3.0);
      cubeTex = wave;
    }
    

    
  }

  void drawShape()
  {
    scale(1, scale, 1);
    drawCube();
  }
  
    void drawTextureShape(PImage tex)
  {
    if(obj==null)
    {
      //scale(1, 1, 1);
      scale(1, scale, 1);
    }
    
    drawTexture(tex);
  }
}
