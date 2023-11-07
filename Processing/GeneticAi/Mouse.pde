

// Global Settings
PVector DEF_POS = new PVector(0,0);
int mouseSize = 24;

class Mouse {

  // Instance Variables
  private PVector pos;
  private PVector vec;
  private PVector acc;


  // Initialization
  void init(PVector p) {
    pos(p);
    vec(null);
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
  PVector pos() {return this.pos;}
  void pos(PVector p) {
    if (p == null) this.pos = DEF_POS.copy();
    else this.pos = p.copy();
  }

  // Velocity
  PVector vec() {return this.vec;}
  void vec(PVector v) {
    if (v == null) this.vec = new PVector(0, 0);
    else this.vec = v.copy();
  }

  // Acceleration
  PVector acc() {return this.acc;}
  void acc(PVector a) {
    if (a == null) this.acc = new PVector(0, 0);
    else this.acc = a.copy();
  }

  // Calculate direction based on cursor position
  private PVector direction() {
    PVector direction = PVector.sub(new PVector(mouseX, mouseY), this.pos);
    direction.normalize();
    return direction;
  }

  private PVector[] calculateOutline() {

    PVector[] points = new PVector[4];

    // Calculate direction based on cursor position
    PVector heading = this.direction();
    heading.mult(mouseSize);

    // Get vector perpendicular to heading
    PVector s = heading.rotate(radians(-90)).copy();
    heading.rotate(radians(90));
    
    // Calculate the outline of the shape
    PVector top = PVector.add(this.pos, PVector.mult(heading,2));
    PVector bot = PVector.sub(this.pos, PVector.mult(heading,0.666));
    PVector left = PVector.sub(bot, PVector.sub(heading,s));
    PVector right = PVector.sub(bot, PVector.add(heading,s));
  
    return new PVector[]{top, left, bot, right};
  } 

  // Draw Object
  void draw() {


    // Get Outline of Shape
    PVector[] points = this.calculateOutline();

    // Draw Shape
    noStroke();
    fill(255, 0, 0);
    beginShape();
    for (PVector p : points) 
      vertex(p.x, p.y);
    endShape();

  }

  void drawBoundingBox() {

    noFill();
    stroke(255);
    PVector[] points = this.calculateOutline();

    pushMatrix(); // Save State of Screen
    translate(this.pos.x, this.pos.y);    
    rotate(this.direction().heading());


    PVector a = PVector.sub(points[3], points[1]);
    PVector b = PVector.sub(points[3], this.pos);
    
    // rect(abs(points[1].x-this.pos.x), 0, sizeX, sizeY);
    rect(-a.x/2, -b.y/2, a.mag(), b.mag());
    ellipse(-a.x/2, -b.y/2, 5, 5);

    // sizeX = (points[3].x - points[1].x) / 2;
    // sizeY = this.pos.y - points[0].y;
    // rect(this.pos.x - (sizeX/2), points[0].y, sizeX, sizeY);
    rotate(-this.direction().heading());
    popMatrix(); // Load State of Screen

    



  }

}