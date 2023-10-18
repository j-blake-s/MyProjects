 class Smoke {

  // Instance Variables
  public int age;
  private PVector center;
  private int size;
  private int spawnrate;
  private boolean working;
  private int lifespan;
  private PImage img;
  private ArrayList<SmokeParticle> particles;

  // Declare some default values
  private void init() {
    this.age = 0;
    this.spawnrate = 1;
    this.working = true;
    this.lifespan = 300;
    this.img = loadImage("sb_mask_256.png");
  }

  // Constructor
  Smoke(float x, float y, int size) {
    init();
    this.particles = new ArrayList<SmokeParticle>();
    this.center = new PVector(x, y);
    this.size = size;
  }

  // Sets a new center
  void set_center(float x, float y) {
    this.center = new PVector(x,y);
  }

  // Get size of particles
  int size() {
    return this.particles.size();
  }

  // Kill old particles
  private void kill() {
    for (int i = 0; i < this.particles.size(); i++) {
      if (this.particles.get(i).get_age() >= lifespan) {
        this.particles.remove(i);
        return; // Only 1 needs to be removed
      }
    }
  }

  // Spawn new particles
  private void spawn() {
    float mag = this.size / 2.0;
    float adjustX = random(-mag, mag);
    float adjustY = random(-mag, mag);
    this.particles.add(new SmokeParticle(this.center.x + adjustX, this.center.y + adjustY, this.img, this.size));
  }

  // Draw particles
  void draw_(String color_type) {
    for (SmokeParticle particle : this.particles)
      particle.draw_(color_type); 
  }

  // Apply force to particles
  void apply_force(PVector force) {
    for (SmokeParticle particle : this.particles) particle.apply_force(force);
  }

  // Run all particles
  void run(String color_type) {
    // Kill old particles
    this.kill();

    // Move remaining particles
    for (SmokeParticle particle : this.particles) particle.update_vectors();
    
    // Spawn new particles
    if ((this.age % this.spawnrate == 0) && this.working)
      this.spawn();
    
    // Draw all particles
    for (SmokeParticle particle : this.particles) particle.draw_(color_type);

    for (SmokeParticle particle : this.particles) particle.set_age(particle.get_age() + 1);
  }
 }
