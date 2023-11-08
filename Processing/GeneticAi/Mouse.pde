

// Global Settings
PVector DEF_POS = new PVector(0,0);
int mouseSize = 8;
int searchAreaRadius = 3*mouseSize;

class Mouse {

  // Instance Variables
  private PVector pos;
  private PVector vel;
  private PVector acc;


  // Initialization
  void init(PVector p) {
    pos(p);
    vel(null);
    acc(null);
  }

  // Constructors
  Mouse() {
    init(DEF_POS);
  }

  Mouse(PVector p) {
    init(p);
  }

  // Position
  PVector pos() { return this.pos; }
  void pos(PVector p) {
    if (p == null) this.pos = DEF_POS.copy();
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

  // Calculate direction based on cursor position
  private PVector direction() {
    // PVector direction = PVector.sub(new PVector(mouseX, mouseY), this.pos);
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
    fill(255, 0, 0);
    pushMatrix();
    translate(this.pos.x, this.pos.y);
    rotate(this.direction().heading()+radians(90));
    beginShape();
    for (PVector p : points) 
      vertex(p.x, p.y);
    endShape();
    popMatrix();

  }

  // Draws the bounding boxes for the mouse
  void drawBoundingBox() {

    noFill();
    stroke(255);

    pushMatrix(); // Save State of Screen
    translate(this.pos.x, this.pos.y);    
    rotate(this.direction().heading()+radians(90));
    rect(-mouseSize, 0, 2*mouseSize, 5*mouseSize/3);
    rect(-mouseSize*0.5, -2*mouseSize,mouseSize,2*mouseSize);
    popMatrix(); // Load State of Screen

  }

  void drawFoodSearchArea(){
    
    noStroke();
    fill(0, 255, 0, 50);    
    for (int i = 0; i < searchAreaRadius*2; i++) {
      for (int j = 0; j < searchAreaRadius*2; j++) {
        rect(int(this.pos.x+j-searchAreaRadius),int(this.pos.y-searchAreaRadius+i), 1,1);
      }
    }
  }

  boolean inFoodSearchArea(int x, int y){ 
    if (abs(int(this.pos.x-x)) <= searchAreaRadius && 
        abs(int(this.pos.y-y)) <= searchAreaRadius) {
      return true;
    }
    return false;
  }

  void eat(Food f) {
    return;
  }

  int[] foodRange() {
    int xl = int(this.pos.x - searchAreaRadius);
    int xr = int(this.pos.x + searchAreaRadius);
    int yu = int(this.pos.y - searchAreaRadius);
    int yb = int(this.pos.y + searchAreaRadius);
    return new int[]{xl,xr,yu,yb};
  }

  void move() {
    this.vel.add(this.acc);
    this.pos.add(this.vel);
    this.acc.set(new PVector(0,0));
    this.vel.mult(0.8);
  }

}