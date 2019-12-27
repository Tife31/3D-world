



void drawEverything()
{

  clear();
  if (view== 0 )
  {
    resetMatrix();
    ortho(-10, 10, 10, -10, -10, 14); // everything will look the same size. 
    rotateX(radians(50));
    rotateY(radians(-50));
  } else if (view == 1)
  {
    resetMatrix();
    //frustum(-1, 1, 1, -1, 1, 50);
    //rotateX(radians(-50));
    perspective(fov, float(width)/float(height), 1, 50);
    scale(1, -1);
    translate(0, -0.9, -5 );
  } 
  //else
  //{
  //  resetMatrix();
  //  rotateZ(radians(plane.rotateZ));
  //  rotateX(radians(plane.rotateX));
  //  perspective(fov, float(width)/float(height), 1, 50);
  //  scale(1, -1);
  //  //frustum(-1, 1, 1, -1, 1, 50);
  //}
  //if()

  translate(-plane.x, -plane.y, -plane.z); //Camera, NOT plane


  drawBoard();
  plane.drawPlane();
  drawExplosion();
  
  //pushMatrix();
  //translate(0,0, -20);
  //scale(0.3);
  //shape(buoyShape, 0, 7);
  //popMatrix();
  
  
  //println("pz: " + plane.z);
  //pushMatrix();
  //translate(-1, bouyY, -25);
  //scale(0.5);

  //fill(120, 5, 5);
  //bouy.drawShape();
  //popMatrix();


}

void drawBoard()
{

  for (int i =0; i< world.size(); i++)
  {
    for (int j = 0; j<world.get(i).length; j ++ )
    {
      //scale()

      //resetMatrix();
      push();
      Cube cube = world.get(i)[j]; 
      fill(cube.colour);
      translate(j-7, 0, -i+worldZ);
      scale(0.5);
      if (j-7 == 7 || j-7 == -7) //make it the rock
      {
        //cube.scale = random(1.2, 3.0);
        cube.cubeTex = stone;
      }
      else if(cube.obj instanceof Buoy)
      {
        pushMatrix();
        translate(0, objectLerp(1.4, 1.7), 0);
        scale(0.3);
        shape(buoyShape, 0, 0);
        popMatrix();
      }
      else if(cube.obj instanceof Boat)
      {
        pushMatrix();
        translate(0, 1.5, 0);
        rotateZ(objectLerp(-0.1, 0.1));
        scale(0.3);
        shape(boatShape, 0, 0);
        popMatrix();
      }
      cube.drawTextureShape(cube.cubeTex);
      pop();
    }
  }
}

void drawExplosion()
{
  for (int b = plane.ps.particles.size()-1; b >= 0; b--) 
  {
    Particle h = plane.ps.particles.get(b);
    //println("particles exist");
    if (h.startTime + h.lifespan > millis())
    {
      int now = millis();

      float elapsedTime =( now - h.lastTime) / 1000.0;
      h.velocity.y -= h.GRAVITY;
      h.lastTime = now;
      float distX = elapsedTime * h.velocity.x;
      float distY = elapsedTime * h.velocity.y;
      float distZ = elapsedTime * h.velocity.z;
      h.position.x += distX;
      h.position.y += distY;
      h.position.z += distZ;
      h.display();
      // println("pz: " + plane.z + "  z: " + h.position.z);
    } else
    {
      //println("particle killed");
      plane.ps.particles.remove(b);
    }
  }
  //if(exploded)
  //{
  //  plane = null;
  //}
}
void drawCube()
{
  beginShape(QUADS);

  //fill(255,0,0);
  vertex(-1, -1, 1);
  vertex(-1, 1, 1);
  vertex(1, 1, 1);
  vertex(1, -1, 1);

  //fill(0,255,0);
  vertex(1, -1, 1);
  vertex(1, -1, -1);
  vertex(1, 1, -1);
  vertex(1, 1, 1);

  // fill(0,0,255);
  vertex(1, -1, -1);
  vertex(-1, -1, -1);
  vertex(-1, 1, -1);
  vertex(1, 1, -1);

  //fill(0,255,255);
  vertex(-1, -1, -1);
  vertex(-1, -1, 1);
  vertex(-1, 1, 1);
  vertex(-1, 1, -1);

  // fill(255,0,255);
  vertex(-1, 1, 1);
  vertex(1, 1, 1);
  vertex(1, 1, -1);
  vertex(-1, 1, -1);

  // fill(255,255,0);
  vertex(1, -1, 1);
  vertex(-1, -1, 1);
  vertex(-1, -1, -1);
  vertex(1, -1, -1);
  endShape();
}


void drawTexture(PImage tex)
{
  beginShape(QUADS);

  //fill(255,0,0);
  texture(tex);
  vertex(-1, -1, 1, 0, 0 );
  vertex(-1, 1, 1, 0, 1 );
  vertex(1, 1, 1, 1, 1);
  vertex(1, -1, 1, 1, 0);

  //fill(0,255,0);
  //texture(texture0);
  vertex(1, -1, 1, 0, 1);
  vertex(1, -1, -1, 0, 0);
  vertex(1, 1, -1, 1, 0);
  vertex(1, 1, 1, 1, 1);

  // fill(0,0,255);
  //texture(texture0);
  vertex(1, -1, -1, 1, 0);
  vertex(-1, -1, -1, 0, 0);
  vertex(-1, 1, -1, 0, 1);
  vertex(1, 1, -1, 1, 1);

  //fill(0,255,255);
  //texture(texture0);
  vertex(-1, -1, -1, 0, 0);
  vertex(-1, -1, 1, 0, 1);
  vertex(-1, 1, 1, 1, 1);
  vertex(-1, 1, -1, 1, 0);

  // fill(255,0,255);
  vertex(-1, 1, 1, 0, 1);
  vertex(1, 1, 1, 1, 1);
  vertex(1, 1, -1, 1, 0);
  vertex(-1, 1, -1, 0, 0);

  // fill(255,255,0);
  vertex(1, -1, 1, 1, 1);
  vertex(-1, -1, 1, 0, 1);
  vertex(-1, -1, -1, 0, 0);
  vertex(1, -1, -1, 1, 0);
  endShape();
}

void drawBoat(PImage tex0)
{
  beginShape(QUADS);

  //fill(255,0,0);
  texture(tex0);
  vertex(-1, -1, 1, 0, 0 );
  vertex(-1, 1, 1, 0, 1 );
  vertex(1, 1, 1, 1, 1);
  vertex(1, -1, 1, 1, 0);

  //fill(0,255,0);
  //texture(texture0);
  vertex(1, -1, 1, 0, 1);
  vertex(1, -1, -1, 0, 0);
  vertex(1, 1, -1, 1, 0);
  vertex(1, 1, 1, 1, 1);

  // fill(0,0,255);
  //texture(texture0);
  vertex(1, -1, -1, 1, 0);
  vertex(-1, -1, -1, 0, 0);
  vertex(-1, 1, -1, 0, 1);
  vertex(1, 1, -1, 1, 1);

  //fill(0,255,255);
  //texture(texture0);
  vertex(-1, -1, -1, 0, 0);
  vertex(-1, -1, 1, 0, 1);
  vertex(-1, 1, 1, 1, 1);
  vertex(-1, 1, -1, 1, 0);

  // fill(255,0,255);
  vertex(-1, 1, 1, 0, 1);
  vertex(1, 1, 1, 1, 1);
  vertex(1, 1, -1, 1, 0);
  vertex(-1, 1, -1, 0, 0);

  // fill(255,255,0);
  vertex(1, -1, 1, 1, 1);
  vertex(-1, -1, 1, 0, 1);
  vertex(-1, -1, -1, 0, 0);
  vertex(1, -1, -1, 1, 0);
  endShape();
}
