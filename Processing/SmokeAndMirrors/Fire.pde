class Fire {
  
  // Instance Variables
  private ArrayList<Smoke> pClusters;
  private int age;
  private int spread_rate;
  private int spread_amount;
  private String color_type;

  // Constructor
  Fire(PVector init_center) {
    this.pClusters = new ArrayList<Smoke>(); 
    this.pClusters.add(new Smoke(init_center));
    this.age = 0;
    this.spread_rate = 200;
    this.spread_amount = 2;
    this.color_type = "RED-ORANGE";
  }

  // Get size of clusters
  int size() {
    return this.pClusters.size(); 
  }

  // Update all clusters
  void update() {
    this.spawn();
    this.run();
    this.draw_();
    this.kill();
    this.age += 1;
    //this.spread();
  }

  void spawn() {
    for (Smoke cluster : this.pClusters) {
      cluster.spawn();
    }
  }

//   def spread(self):
//     for particle_cluster in self.particle_clusters:  
//     if particle_cluster.age == self.spread_rate:
//       temp = particle_cluster.center
//         mag = 600
//         adjust = mag /2
//         for i in range(int(random(2) + 1)):
//           if particle_cluster.working:
            
//             x= temp.x + (random(mag) - adjust)
//             while(x <= 0 or x >= width):
//                x= temp.x + (random(mag) - adjust)
//             y = temp.y + (random(mag) - adjust)
//             while(y <= 0 or y >= height):
//               y = temp.y + (random(mag) - adjust)
              
              
//             temp_smoke = Smoke(PVector(x,y))
//             temp_smoke.lifespan = random(101,400)
//             self.particle_clusters.append(temp_smoke)
    
  void kill() {
    for (Smoke cluster : this.pClusters) {
      cluster.kill();
    }
  }
  
  void applyForce(PVector force) {
    for (Smoke cluster : this.pClusters) {
      cluster.applyForce(force);
    }
  }

  void run() {
    for (Smoke cluster : this.pClusters) {
      cluster.run();
    }
  }

  void draw_() {
    for (Smoke cluster : this.pClusters) {
      cluster.draw_(this.color_type);
    }
  }
}








    
