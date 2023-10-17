class SmokeParticle {

  // Instance Variables
  private int age;
  private PVector pos;
  private PVector vel;
  private PVector acc;
  private int size;
  private PImage img;

  // Constructors
  SmokeParticle(int x, int y, PImage image) {
    this.age = 0;
    this.pos = new PVector(x, y);
    this.vel = this.initial_vel();
    this.acc = new PVector(0,0);
    this.size = 25;
    this.img = img;
  }
      
  PVector initial_vel() {
    float vx = randomGaussian() * 0.5;
    float vy = randomGaussian() * 0.5 - 1.4;
    return new PVector(vx, vy);
  }

  void draw_(String color_type) {
    int opacity = 100;
    int ratio = 20;
    
    if (color_type.equals("RED-ORANGE"))
      tint(1.5 * ratio, 0.5 * ratio, 1 * ratio, opacity);
    else if (color_type.equals("BLUE-WHITE"))
      tint(1 * ratio, 1  * ratio, 2  * ratio, opacity);
    else if (color_type.equals("GREEN"))
      tint(1  * ratio, 1  * ratio, 0  * ratio, opacity);
    else if (color_type.equals("ORANGE"))
      tint(1 * ratio, 0.5  * ratio, 0 * ratio, opacity);
    else
      noLoop();

    // fill(200,40,0,100-self.age)
    imageMode(CENTER);
    blendMode(SCREEN);
    // tint(255,0,0)
    noStroke();
    // ellipse(self.pos.x,self.pos.y, self.size/4,self.size/4)
    // image(self.img,self.pos.x,self.pos.y);
    this.age += 1;
  }
 }
