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

class Mouse {

  // Instance Variables
  private PVector pos;
  private PVector vel;
  private PVector acc;
  private int health;
  private PVector c;
  private DNA dna;
  private int size;

  // Initialization
  private void init(PVector p, DNA genes) {
    this.pos(p);
    this.vel(null);
    this.acc(null);
    this.health(DEF_MOUSE_HEALTH);
    this.dna = genes;
    this.size(this.dna.read(MouseGenes.SIZE));

  }
  // Constructors
  Mouse() {
    init(DEF_MOUSE_POS, new DNA(MouseGenes.NUM_GENES));
  }

  Mouse(PVector p) {
    init(p, new DNA(MouseGenes.NUM_GENES));
  }

  Mouse(DNA genes) {
    init(DEF_MOUSE_POS, genes);
  }

  Mouse(PVector p, DNA genes) {
    init(p, genes);
  }


  // Size
  int size() {return this.size;}
  private void size(float size_dna) {
    this.size = int(size_dna * 16)+8;
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

  // Move
  void move() {
    this.vel.add(this.acc);
    this.pos.add(this.vel);
    this.acc.set(new PVector(0,0));
    this.vel.mult(0.8);
  }

  // Calculate direction based on velocity
  private PVector direction() {
    PVector direction = this.vel().copy();
    direction.normalize();
    return direction;
  }

  // Calculates the outline of the mouse
  private PVector[] calculateOutline() {
    PVector[] points = new PVector[4];
    PVector top = new PVector(0, -2*this.size);
    PVector bot = new PVector(0, 2*this.size/3);
    PVector left = new PVector(-this.size, 5*this.size/3);
    PVector right = new PVector(this.size, 5*this.size/3);
    return new PVector[]{top, left, bot, right};
  }  


  // Checks if an given index is in the consumption zone
  boolean inConsumptionZone(int x, int y){ 
    PVector foodPos = new PVector(x, y);
    if (PVector.sub(this.pos, foodPos).mag() < 2*this.size) return true;
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
    int xl = int(this.pos.x - 2*this.size);
    int xr = int(this.pos.x + 2*this.size);
    int yu = int(this.pos.y - 2*this.size);
    int yb = int(this.pos.y + 2*this.size);
    return new int[]{xl,xr,yu,yb};
  }

  // Draws the zone in which food is eaten
  void drawConsumptionZone(){
    noStroke();
    fill(0, 255, 0, 50);    
    ellipse(this.pos.x, this.pos.y, 2*this.size*2, 2*this.size*2);
  }

  // Draw Object
  void draw() {

    // Get Outline of Shape
    PVector[] points = this.calculateOutline();

    // Draw Shape
    noStroke();
    fill(255-this.health, this.health, 0);
    pushMatrix();
    translate(this.pos.x, this.pos.y);
    rotate(this.direction().heading()+radians(90));
    beginShape();
    for (PVector p : points) 
      vertex(p.x, p.y);
    endShape();
    popMatrix();

  }

}