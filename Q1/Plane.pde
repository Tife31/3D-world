class Plane 
{
  float x, y, z;
  int rotateZ =0;
  int rotateX = 0;
   ParticleSystem ps;
  
  Plane(float x, float y,  float z)
  {
    this.x = x;
    this.y = y;
    this.z = z;
    ps = new ParticleSystem(new PVector(x, y, z), color(random(155, 255), random(155, 255), random(155, 255)));
    
  }
  
  void drawPlane()
  {
    if(!exploded)
    {
      pushMatrix();
      
      translate(x, y, z);
      rotateZ(radians(rotateZ));
      rotateX(radians(rotateX));
      rotateX(radians(-90));
      scale(0.7, 0.7, 0.5);
      partsPlane();
      popMatrix();
    }
    
  }
  
  void partsPlane()
  {
    pushMatrix();
    fill(255, 0, 0);
    translate(0,-1, 0);
    //rotateZ(radians(45));
    scale(0.5);
    drawCube();
    popMatrix();
    
    pushMatrix();
    scale(0.5, 0.5, -0.5);
    fill(70, 70, 70);
    
    beginShape(TRIANGLE);
    //texture(texture0);
    vertex(0, 1, 1);
    vertex(-1, -1, 1);
    vertex(1, -1, 1);
    
    vertex(0, 1, -1);
    vertex(-1, -1, -1);
    vertex(1, -1, -1);
    endShape();
    
    beginShape(QUADS);
    vertex(0, 1, 1);
    vertex(0, 1, -1);
    vertex(1, -1, -1);
    vertex(1, -1, 1);
    
    vertex(0, 1, 1);
    vertex(0, 1, -1);
    vertex(-1, -1, -1);
    vertex(-1, -1, 1);
    endShape();
    
    popMatrix();
    
    
  }
}
