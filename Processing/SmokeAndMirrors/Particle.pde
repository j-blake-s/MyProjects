class Particle {

  // Instance Variables
  private int age;
  public PVector pos;
  public PVector vel;
  public PVector acc;
  public float mass;

  // Initialization function
  private void init(float px, float py, float vx, float vy, float ax, float ay) {
    this.age = 0;
    this.pos = new PVector(px,py);
    this.vel = new PVector(vx,vy);
    this.acc = new PVector(ax,ay);
    this.mass = 1.0;
  }

  // Constructors
  Particle() {init(0,0,0,0,0,0);}
  Particle(float x, float y) {init(x,y,0,0,0,0);}
  Particle(float px, float py, float vx, float vy) {init(px,py,vx,vy,0,0);}
  Particle(float px, float py, float vx, float vy, float ax, float ay) {init(px,py,vx,vy,ax,ay);}

  // Apply force to particle
  void apply_force(PVector force) {
    this.acc.add(PVector.div(force,this.mass));
  }

  // Default Draw Operation
  // Draws small white circle to canvas
  void draw_() {
    fill(255);
    ellipse(this.pos.x, this.pos.y, 20, 20);   
  }

  // Updates particle according to its p,v,a vectors
  // Sets acceleration to 0
  void update_vectors() {
    this.vel.add(this.acc);
    this.pos.add(this.vel);
    this.acc.mult(0);
  }

  // Update movement vectors and draw to screen
  void run() {
    this.update_vectors();
    this.draw_();
    this.age += 1;
  }

  int get_age() {return this.age;}
  void set_age(int a) {this.age = a;}
 }
