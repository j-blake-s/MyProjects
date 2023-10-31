int walkerSize = 6;
int moveSize = 3;
class Walker {

  private int x;
  private int y;
  
  void init(int px, int py) {
    this.x = px;
    this.y = py;
  }

  Walker() {
    init(0, 0);
  }

  Walker(int px, int py) {
    init(px, py);
  }


  void move() {
    this.x += (int(random(3))-1)*moveSize;
    this.y += (int(random(3))-1)*moveSize;
  }

  void draw() {
    noStroke();
    fill(0, 25);
    rect(this.x, this.y, walkerSize, walkerSize);
  }

}