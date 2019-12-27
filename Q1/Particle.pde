class Particle
{
  //each particle has its own state 
 color colour;
 int size; 
 int lastTime;// the time particle had moved. 
 int startTime;
 PVector position;
 PVector velocity;
 int lifespan;
 final float GRAVITY = 0.01;
 float speedX;
 float speedY;
 float speed;
 float angle;
 
 Particle(PVector origin, color colour)
 {
    //deceleration = new PVector(0, random(0.0, 0.05));
    position = origin.copy(); //should start from the origiin. 
    lifespan = 2000;
    startTime = millis();
    lastTime = startTime;
    speed = random(0.0, 1.0);
    angle = random(0, 360);
    speedX = speed * cos(angle);
    speedY = speed * sin(angle);
    this.colour = colour;
    velocity = new PVector(speedX, speedY, speed);

  }
  

  // Method to display
  void display() {
    //resetMatrix();
    stroke(255, 255);
    fill(colour);
    push();
    translate(position.x, position.y, position.z);
    scale(.1);
    
    beginShape(TRIANGLES);
    vertex(0, 1);
    vertex(1, -1);
    vertex(-1, -1);
    endShape();
    pop();
  }
  
}  

  
