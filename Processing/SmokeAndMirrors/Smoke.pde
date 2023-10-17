// from Particle_System import *
// from Smoke_Particle import *
// from stats import *
class Smoke(Particle_System) {

  private int age;
  private PVector center;
  private ArrayList<Smoke_Particle> particles;
  private int size;
  private int spawnrate;
  private boolean working;
  private int lifespan;
  private PImage img;
  Smoke(PVector pos_vector) {
    this.age = 0;
    this.center = new PVector(pos_vector.x,pos_vector.y);
    this.particles = new ArrayList<Smoke_Particle>();
  //     self.size = 200
  //     self.spawnrate = 1
  //     self.working = True
  //     self.lifespan = 300
  //     self.img = loadImage("sb_mask_256.png")
  //     imageMode(CORNER)
  //     image(self.img,width/2,height/2,self.size,self.size)
  //     self.img = get(width/2,height/2,self.size,self.size)
  //     background(0)
  }
  
  // def update(self):
  //     self.run()
  //     self.draw_()
  //     self.kill()
  //     self.spawn()
  // def draw_(self,color_type):
  //     for particle in self.particles:
  //         particle.draw_(color_type)    
  // def spawn(self):
  //     for i in range(1):
  //         if self.age % self.spawnrate == 0 and self.working:
  //             mag = self.size /2
  //             adjustX = random(-mag,mag)
  //             adjustY = random(-mag,mag)
  //             self.particles.append(Smoke_Particle(mouseX + adjustX,mouseY + adjustY,self.img))
  //     self.age += 1
          
  
  // def kill(self):
  //     global lifespan
  //     for i in range(0,len(self.particles)):
  //         if self.particles[i].age >= lifespan:
  //             self.particles.pop(i)
  //             self.kill()
  //             break
              

  
  // def __len__(self):
  //     return len(self.particles)
}