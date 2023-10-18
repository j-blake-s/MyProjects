class SmokeParticle extends Particle {

  // Instance Variables
  private int size;
  private PImage img;

  // Constructors
  SmokeParticle(float x, float y, PImage image, int size) {
    super(x,y);
    this.vel = this.random_vel();
    this.size = size;
    this.img = image;
  }

  // Getters and Setters
  int get_size() {return this.size;}
  void set_size(int s) {this.size = s;}

  // Get a random velocity for new smoke particle    
  private PVector random_vel() {
    float vx = randomGaussian() * 0.5;
    float vy = randomGaussian() * 0.5 - 1.4;
    return new PVector(vx, vy);
  }

  // Sets tint according to color type
  private void set_tint(String color_type) {set_tint(color_type, 20, 0);}
  private void set_tint(String color_type, int ratio, int opacity) {
    if (color_type.equals("RED-ORANGE")) tint(1.5 * ratio, 0.5 * ratio, 1 * ratio, opacity);
    else if (color_type.equals("BLUE-WHITE")) tint(1 * ratio, 1  * ratio, 2  * ratio, opacity);
    else if (color_type.equals("GREEN")) tint(1  * ratio, 1  * ratio, 0  * ratio, opacity);
    else if (color_type.equals("ORANGE")) tint(1 * ratio, 0.5  * ratio, 0 * ratio, opacity);
    else tint(1.5 * ratio, 0.5 * ratio, 1 * ratio, opacity); //RED-ORANGE
  }

  // Draws smoke visual to the screen
  void draw_(String color_type) {
    this.set_tint(color_type);
    imageMode(CENTER);
    blendMode(SCREEN);
    noStroke();
    image(this.img, this.pos.x, this.pos.y, this.size, this.size);
  }

  // Updates movement vectors
  void update_vectors() {
    super.update_vectors();
  }

  // Run the particle for a frame
  void run(String color_type) {
    this.update_vectors();
    this.draw_(color_type);
    super.set_age(super.get_age() + 1);
  }
}
