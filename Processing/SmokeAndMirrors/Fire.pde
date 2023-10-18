class Fire {
  
  // Instance Variables
  private ArrayList<Smoke> clusters;
  private int age;
  // private int spread_rate;
  // private int spread_amount;
  public String color_type;

  // Declare default values
  private void init() {
    this.age = 0;
    // this.spread_rate = 200;
    // this.spread_amount = 2;
    this.color_type = "RED-ORANGE";
    this.clusters = new ArrayList<Smoke>(); 
  }

  // Constructor
  Fire(float x, float y, int size) {
    init();
    this.clusters.add(new Smoke(x, y, size));
  }

  // Get size of clusters
  int size() {
    return this.clusters.size(); 
  }

  // Sets the centers of all of the smoke clusters
  void set_center(float x, float y) {
     for (Smoke cluster : this.clusters) cluster.set_center(x, y);
  }

  // Apply a force vector to all smoke clusters
  void apply_force(PVector force) {
    for (Smoke cluster : this.clusters) cluster.apply_force(force);
  }

  // Run all smoke clusters
  void run() {
    for (Smoke cluster : this.clusters) cluster.run(this.color_type);
    this.age += 1;
    //this.spread();
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
    