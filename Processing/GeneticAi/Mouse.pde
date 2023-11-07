

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


  // Draw Object
  void draw() {


    fill(255);
    noStroke();
    ellipse(this.pos.x, this.pos.y, 5, 5);
    
    PVector r = PVector.sub(new PVector(mouseX, mouseY), this.pos);
    r.normalize();
    PVector s = new PVector(r.y, -r.x);
    r.mult(mouseSize);
    s.mult(3 * mouseSize / 4);

    

    PVector top = PVector.add(r, this.pos);
    PVector bot =  PVector.add(PVector.mult(r, -1), this.pos);
    PVector left = PVector.add(bot, PVector.mult(r, -3/4));
    left.add(s);

    stroke(155);
    fill(155);
    line(top.x, top.y, bot.x, bot.y);
    line(left.x, left.y, bot.x, bot.y);

    // PVector right = new PVector(this.pos.x+(3*mouseSize/4), this.pos.y+mouseSize+(3*mouseSize/4));
    
    // noStroke();
    // fill(255, 0, 0);

    // beginShape();
    // vertex(top.x, top.y);
    // vertex(left.x, left.y);
    // vertex(bot.x, bot.y);
    // vertex(right.x, right.y);
    // endShape();
  }

}