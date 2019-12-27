class ParticleSystem
{
  color colour;
  PVector origin;
  ArrayList<Particle> particles;
  //ArrayList<Fuel> fuelParticles;

  ParticleSystem(PVector position, color colour)
  {
    origin = position.copy();
    particles = new ArrayList<Particle>(); 
   // fuelParticles = new ArrayList<Fuel>();
    this.colour = colour;
  }

  void addParticles() 
  {
    println("Added Particles");
    for (int i=0; i < 5000; i++)
    {
      particles.add(new Particle(origin, colour));
    }
  }


}
