 class ParticleSystem {
  
   // Instance Variables
   private ArrayList<Particle> particles;
  
   // Constructor
   ParticleSystem() {
     this.particles = new ArrayList<Particle>();
   }

   void run() {
     for (Particle particle : this.particles) {
       particle.run();
     }
   }

   void draw_() {
     for (Particle particle : this.particles) {
       particle.draw_();
     }
   }

   void applyForce(PVector force) {
     for (Particle particle : this.particles) {
       particle.applyForce(force);
     }
   }
 }
