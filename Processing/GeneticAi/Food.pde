


int DEF_SIZE = 10;
class Food {

  // Instance Variables
  private int x = 0;
  private int y = 0;
  private int power;
  private PVector c;
  private int size;


  // Initialization
  void init(int aX, int aY, int p, int s) {
    x(aX);
    y(aY);
    power(p);    
    size(s);
  }

  // Constructors
  Food() {
    init(width/2, height/2, 0, 0);
  }

  Food(int aX, int aY) {
    init(aX, aY, 0, 0);
  }

  Food(int aX, int aY, int p) {
    init(aX, aY, p, 0);  
  }

  Food(int aX, int aY, int p, int s) {
    init(aX, aY, p, s);  
  }

  Food(Food f) {
    init(f.x(), f.y(), f.power(), f.size());
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
  int power() { return this.power; }
  void power(int p) {
    if (p < 0) this.c = new PVector(255, 0, 0);         // Red
    else if (p > 0) this.c = new PVector(0, 255, 0);    // Green
    else this.c = new PVector(150, 150, 150);           // Gray
    this.power = p;
  }

  int size() { return this.size; }
  void size(int s) {
    if( s >= 1) this.size = s;
    else this.size = DEF_SIZE;
  }

  // Draw Object
  void draw() {
    noStroke();
    fill(this.c.x, this.c.y, this.c.z);
    ellipse(this.x, this.y, this.size, this.size);
  }
}