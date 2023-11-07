


int foodSize = 10;
class Food {

  // Instance Variables
  private int x = 0;
  private int y = 0;
  private float power;
  private PVector c;


  // Initialization
  void init(int aX, int aY, float p) {
    x(aX);
    y(aY);
    power(p);    
  }

  // Constructors
  Food() {
    init(width/2, height/2, 0);
  }

  Food(int aX, int aY) {
    init(aX, aY, 0);
  }

  Food(int aX, int aY, float p) {
    init(aX, aY, p);  
  }

  Food(Food f) {
    init(f.x(), f.y(), f.power());
  }


  // X Position
  int x() { return this.x; }
  void x(int aX) {
    if (aX >= 0 || aX <= width) this.x = aX;
  }

  // Y Position
  int y() { return this.y; }
  void y(int aY) {
    if (aY >= 0 || aY <= height) this.y = aY;
  }

  // Power of Food
  float power() { return this.power; }
  void power(float p) {
    if (p < 0) this.c = new PVector(255, 0, 0);         // Red
    else if (p > 0) this.c = new PVector(0, 255, 0);    // Green
    else this.c = new PVector(150, 150, 150);           // Gray
    this.power = p;
  }


  // Draw Object
  void draw() {
    noStroke();
    fill(this.c.x, this.c.y, this.c.z);
    ellipse(this.x, this.y, foodSize, foodSize);
  }
}