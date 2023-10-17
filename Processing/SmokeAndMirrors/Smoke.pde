 class Smoke extends ParticleSystem {

   // Instance Variables
   private int age;
   private PVector center;
   private ArrayList<SmokeParticle> particles;
   private int size;
   private int spawnrate;
   private boolean working;
   private int lifespan;
   private PImage img;

   // Constructor
   Smoke(PVector pos_vector) {
     this.age = 0;
     this.center = new PVector(pos_vector.x,pos_vector.y);
     this.particles = new ArrayList<SmokeParticle>();
     this.size = 200;
     this.spawnrate = 1;
     this.working = true;
     this.lifespan = 300;
     this.img = loadImage("sb_mask_256.png");
     imageMode(CORNER);
     image(this.img, width/2, height/2, this.size, this.size);
     this.img = get(width/2, height/2, this.size, this.size);
     background(0);
   }
  
   // Run all update methods
   void update() {
     this.run();
     this.draw_();
     this.kill();
     this.spawn();
   }


   // Draw particles
   void draw_(String color_type) {
     for (SmokeParticle particle : this.particles) {
       particle.draw_(color_type); 
     }
   }


   // Spawn new particles
   void spawn() {
     if ((this.age % this.spawnrate == 0) && this.working) {
       float mag = this.size / 2.0;
       float adjustX = random(-mag, mag);
       float adjustY = random(-mag, mag);
       // this.particles.append(new Smoke_Particle(mouseX + adjustX, mouseY + adjustY,this.img));
     }
     this.age += 1;
   }
  
   // Kill old particles
   void kill() {
     for (int i = 0; i < this.particles.size(); i++) {
       if (this.particles.get(i).age >= lifespan) {
         this.particles.remove(i);
         this.kill();
         break; // Maybe this is here?
       }
     }
   }
  
   // Get size of particles
   int size() {
     return this.particles.size();
   }
  
 }
