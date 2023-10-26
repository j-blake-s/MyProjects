float speedOfLight = 20;
float change = 1;
 int path_limit = 200;
 int rate = 1;

class Particle{
    PVector pos = new PVector(0,0,0);
    PVector vel = new PVector(0,0,0);
    PVector acc = new PVector(0,0,0);
    PVector pAcc = new PVector(0,0,0);
    PVector jerk = new PVector(0,0,0);
    ArrayList<float[]> path = new ArrayList<float[]>(0);
    int age = 0;
    float mass;
    float radius;
    String type;
    Particle(float x,float y,float z){
         pos.set(x,y,z);
         vel.set(0,0,0);
         acc.set(0,0,0);
         radius = 20;
         mass = pMass;
         type = "DYNAMIC";
    }
    
    Particle(float x,float y,float z,String t){
         pos.set(x,y,z);
         vel.set(0,0,0);
         acc.set(0,0,0);
         radius = 20;
         mass = pMass;
         type = t;
    }
    

    void run(){
      drawPath();
      if (type.equals("DYNAMIC")|| play){
        move();
        draw_();
      }
    }
    

    void draw_(){
      if (type.equals("FIXED")){
        fill(0,140,0,100);
      }
      else{
        fill(255);
      }
      noStroke();
      pushMatrix();
      translate(pos.x,pos.y,pos.z);
      sphere(radius);
      popMatrix();
    }
    
    void move(){
      jerk = new PVector(acc.x - pAcc.x,acc.y - pAcc.y,acc.z - pAcc.z);
     
      //noLoop();
      pAcc.x = acc.x;
      pAcc.y = acc.y;
      pAcc.z = acc.z;
      vel.add(acc);
      //vel.normalize();
      //vel.mult(speedOfLight);
      pos.add(vel);
      bounce();
      acc.mult(0);
      age += 1;
    }
    
    
    void bounce(){
      if (pos.x < -roomRadius/2){
        vel.x = abs(vel.x) * 0.95 + 1;
      }
      else if (pos.x > 3 *  roomRadius / 2){
        vel.x = -abs(vel.x)  * 0.95 - 1;
      }
      
      if (pos.y < -roomRadius + 500 ){
        vel.y = abs(vel.y)  * 0.95 + 1;
      }
      else if (pos.y >  1.25 * roomRadius){
          vel.y = -abs(vel.y)  * 0.95 - 1;
      }
      
      if (pos.z > roomRadius){
          vel.z = -abs(vel.z)  * 0.95 - 1 ;
      }
      else if (pos.z <  -roomRadius){
          vel.z = abs(vel.z)  * 0.95 + 1;
      }
    
    }
    
    
    String getType(){
      return type;
    }
     Boolean contains(Particle p){
          float xSep = p.getPos().x - pos.x;
          float ySep = p.getPos().y - pos.y;
          float zSep = p.getPos().z - pos.z;
          PVector dist = new PVector(xSep,ySep,zSep);
          if (dist.mag() < radius + p.getRadius()){
            return true;
          }
          else{
            return false;
          }
      
      }
      
    void drawPath(){
       for (int i = 0; i < path.size() - 1;i++){
           //stroke(path.get(i)[3] + noise(change/3) * 100,path.get(i)[5] + noise(change/2) * 100,path.get(i)[4] + noise(change) * 100);
           stroke(path.get(i)[3],path.get(i)[5],path.get(i)[4]);
           line(path.get(i)[0],path.get(i)[1],path.get(i)[2],path.get(i+1)[0],path.get(i+1)[1],path.get(i+1)[2]);
       }
       float newMag = acc.mag();

       if (age % rate  == 0){
         if (newMag > 0.7){
           int ratio = 100;
           //int ratio = 100;
           //int ratio = 6;
           //float[] vertex = {pos.x,pos.y,pos.z,newMag * ratio,255 - (newMag * ratio),newMag* ratio};
           float num = (newMag * ratio) + noise(change) * 100;
           float[] vertex = {pos.x,pos.y,pos.z,num,255 - num,255 - num};
           path.add(vertex);
           if (path.size() >= path_limit){
             path.remove(0);
           }
         }

         
       }
       age += 1; 
    }
     
    void applyForce(PVector force){
          acc.add((force.x/mass),(force.y/mass),(force.z/mass));
     }
    
    PVector gravity(Particle p,float g_constant){
          //Formula for gravity is Gm1m2 / r^2
          PVector pPos = p.getPos();
          float x_sep = pPos.x - pos.x;
          float y_sep = pPos.y - pos.y;
          float z_sep = pPos.z - pos.z;
          PVector sep = new PVector(x_sep,y_sep,z_sep);
          float force = g_constant * p.getMass() * mass / sq(sep.mag());
          sep.normalize();
          sep.mult(-force);
          return sep;    
      }
      
    float getRadius(){
      return radius;
    }
    PVector getPos(){
       return pos;
    }
      
    PVector getVel(){
       return vel;
    }
    
    PVector getAcc(){
       return acc;
    }
    
    float getMass(){
      return mass;
    }


}
