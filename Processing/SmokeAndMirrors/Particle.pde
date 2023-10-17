 class Particle {

   // Instance Variables
   private PVector pos;
   private PVector vel;
   private PVector acc;

   // Constructor
   Particle(int x, int y) {
     this.pos = new PVector(x,y);
     this.vel = new PVector(0,0);
     this.acc = new PVector(0,0);
   }

   void applyForce(PVector force) {
     this.acc.add(force);
   }
  
   PVector position() {
     return this.pos;
   }

   PVector velocity() {
     return this.vel;
   }

   PVector acceleration() {
     return this.acc;
   }

   void run() {
     this.vel.add(this.acc);
     this.pos.add(this.vel);
     this.acc.mult(0);
   }

   void draw_() {
     fill(255);
     ellipse(this.pos.x, this.pos.y, 20, 20);   
   }
 }
