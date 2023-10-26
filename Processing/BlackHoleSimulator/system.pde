class System{
  ArrayList<Particle> particles = new ArrayList<Particle>(0); 
  System(){
    
  }
  
  void addParticle(Particle p){
    particles.add(p);
  }
  
  void removeParticle(Particle p){
    particles.remove(particles.indexOf(p));
  }
  
  void run(){
    for (int i = 0; i < size(); i++){
      for(int j = 0; j < size();j++){
        if (i != j){
          Particle p1 = particles.get(i);
          Particle p2  = particles.get(j);
          if (p1.getType().equals("DYNAMIC")){
              p1.applyForce(p2.gravity(p1,g));
          }
          
        }
      }
    }
    for(Particle particle : particles){
        particle.run();
    }
  }
  
  void run(System blackholes){
    for (int i = 0; i < size(); i++){
      for(int j = 0; j < size();j++){
        if (i != j){
          Particle p1 = particles.get(i);
          Particle p2  = particles.get(j);
          if (p1.getType().equals("DYNAMIC")){
              p1.applyForce(p2.gravity(p1,g));
          }
          
        }
      }
      for (int j = 0; j < blackholes.size(); j++){
          Particle p1 = particles.get(i);  
          Particle p2 = blackholes.get(j);
          Boolean active = false;
          if (p2.contains(p1) && p1.type.equals("DYNAMIC") && active){
              removeParticle(p1);
          }
          p1.applyForce(p2.gravity(p1,g));
      }
    }
    for(Particle particle : particles){    
        particle.run();
    }
  }
  
  ArrayList<Particle> getParticles(){
      return particles;
  
  
  }
  
  Particle get(int index){
    return particles.get(index);
  }
  int size(){
    return particles.size();
  }
  

  
 


}
