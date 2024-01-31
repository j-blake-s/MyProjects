class MouseGenes {

  final static int NUM_GENES = 6;

  final static int GRN_ATTR = 0;
  final static int RED_ATTR = 1;
  final static int GRN_SEE = 2;
  final static int RED_SEE = 3;
  final static int MAX_SPD = 4;
  final static int SIZE = 5;

}

// Global Settings
PVector DEF_MOUSE_POS = new PVector(0,0);
int DEF_MOUSE_HEALTH = 150;
int mouseSize = 8;
int consumptionRadius = 2*mouseSize;

class Mouse {

  // Instance Variables
  private PVector pos;
  private PVector vel;
  private PVector acc;
  private int health;
  private PVector c;

  // Initialization
  private void init(PVector p) {
    pos(p);
    vel(null);
    acc(null);
    this.health(DEF_MOUSE_HEALTH);
  }

  // Constructors
  Mouse() {
    init(DEF_MOUSE_POS);
  }

  Mouse(PVector p) {
    init(p);
  }

  // Health
  int health() { return this.health; }
  void health(int h) {
    this.health = h;
    this.c = new PVector(255-this.health, this.health, 0);
  }

  // Position
  PVector pos() { return this.pos; }
  void pos(PVector p) {
    if (p == null) this.pos = DEF_MOUSE_POS.copy();
    else this.pos = p.copy();
  }

  // Velocity
  PVector vel() { return this.vel; }
  void vel(PVector v) {
    if (v == null) this.vel = new PVector(0, 0);
    else this.vel = v.copy();
  }

  // Acceleration
  PVector acc() { return this.acc; }
  void acc(PVector a) {
    if (a == null) this.acc = new PVector(0, 0);
    else this.acc = a.copy();
  }

  // Move Mouse
  void move() {
    this.vel.add(this.acc);
    this.pos.add(this.vel);
    this.acc.set(new PVector(0,0));
    this.vel.mult(0.8);
  }

  // Calculate direction based on cursor position
  private PVector direction() {
    PVector direction = this.vel().copy();
    direction.normalize();
    return direction;
  }

  private PVector[] calculateOutline() {
    PVector[] points = new PVector[4];
    PVector top = new PVector(0, -2*mouseSize);
    PVector bot = new PVector(0, 2*mouseSize/3);
    PVector left = new PVector(-mouseSize, 5*mouseSize/3);
    PVector right = new PVector(mouseSize, 5*mouseSize/3);
    return new PVector[]{top, left, bot, right};
  }  

  // Draw Object
  void draw() {

    // Get Outline of Shape
    PVector[] points = this.calculateOutline();

    // Draw Shape
    noStroke();
    fill(this.c.x, this.c.y, this.c.z);
    pushMatrix();
    translate(this.pos.x, this.pos.y);
    rotate(this.direction().heading()+radians(90));
    beginShape();
    for (PVector p : points) 
      vertex(p.x, p.y);
    endShape();
    popMatrix();

  }

  // Draws the zone in which food is eaten
  void drawConsumptionZone(){
    noStroke();
    fill(0, 255, 0, 50);    
    ellipse(this.pos.x, this.pos.y, consumptionRadius*2, consumptionRadius*2);
  }

  // Checks if an given index is in the consumption zone
  boolean inConsumptionZone(int x, int y){ 
    PVector foodPos = new PVector(x, y);
    if (PVector.sub(this.pos, foodPos).mag() < consumptionRadius) return true;
    else return false;
  }

  // Eat food and update health
  void eat(Food f) {
    if (f == null) return;
    else {
      this.health(this.health + f.power());
    }
  }

  // Returns range of indices to check for food
  int[] foodRange() {
    int xl = int(this.pos.x - consumptionRadius);
    int xr = int(this.pos.x + consumptionRadius);
    int yu = int(this.pos.y - consumptionRadius);
    int yb = int(this.pos.y + consumptionRadius);
    return new int[]{xl,xr,yu,yb};
  }


}