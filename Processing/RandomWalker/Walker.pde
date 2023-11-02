int DEF_SIZE = 3;
int DEF_SPEED = 4;
PVector DEF_RGB = new PVector(0, 0, 0);
int DEF_OPACITY = 25;

class Walker {

  private int x;
  private int y;
  private PVector rgb;
  private int opacity;
  private int size;
  private int speed;

  void init(int px, int py, int aSize, int aSpeed, PVector aColor, int op) {

    this.size = aSize;
    this.speed = aSpeed;
    this.x = int(px / this.speed)*this.speed; // Force pixels onto grid
    this.y = int(py / this.speed)*this.speed; // Force pixels onto grid
    this.rgb = new PVector();
    this.rgb.set(aColor);
    this.opacity = op;
  }
  
  Walker(int px, int py) {
    init(px, py, DEF_SIZE, DEF_SPEED, DEF_RGB, DEF_OPACITY);
  }

  Walker(int px, int py, int aSize, int aSpeed) {
    init(px, py, aSize, aSpeed, DEF_RGB, DEF_OPACITY);
  }

  Walker(int px, int py, PVector aColor) {
    init(px, py, DEF_SIZE, DEF_SPEED, aColor, DEF_OPACITY);
  }

  Walker(int px, int py, PVector aColor, int op) {
    init(px, py, DEF_SIZE, DEF_SPEED, aColor, op);
  }

  Walker(int px, int py, int aSize, int aSpeed, PVector aColor) {
    init(px, py, aSize, aSpeed, aColor, DEF_OPACITY);
  }

  Walker(int px, int py, int aSize, int aSpeed, PVector aColor, int op) {
    init(px, py, aSize, aSpeed, aColor, op);
  }

  // Setters
  void c(int r, int g, int b) { this.rgb.set(r, g, b); }
  void opacity(int op) { this.opacity = op; }
  void speed(int aSpeed) { this.speed = aSpeed; }
  void size(int aSize) {this.size = aSize; }
  void pos(int px, int py) {
    this.x = int(px / this.size)*this.size;
    this.y = int(py / this.size)*this.size;
  }

  // Getters
  PVector c() { return this.rgb; }
  int opacity() { return this.opacity; }
  int speed() { return this.speed; }
  int size() { return this.size; }
  PVector pos() { return new PVector(x,y); }

  // Functional
  void move() {
    this.x += (int(random(3))-1)*this.speed;
    this.y += (int(random(3))-1)*this.speed;
  }

  void draw() {
    noStroke();
    fill(this.rgb.x, this.rgb.y, this.rgb.z, this.opacity);
    rect(this.x, this.y, this.size, this.size);
  }

}