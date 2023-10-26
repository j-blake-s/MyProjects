Boolean play = false;
System particles = new System();
System blackholes = new System();

//////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////


void setup(){
  size(1800,1000,P3D);
  background(0);
  frameRate(120);
  for (int i = 0; i <100; i++){
    Particle temp = new Particle(random(960-roomRadius,960 + roomRadius),random(540-roomRadius,540 + roomRadius),random(-roomRadius,roomRadius));  
    temp.getVel().set(random(-startSpeed ,startSpeed ),random(-startSpeed ,startSpeed ),random(-startSpeed ,startSpeed ));
    particles.addParticle(temp);
  }
  
  for (int i = 0; i < 16; i++){
      float mag = 1700;
      Particle temp = new Particle(960 + random(-mag,mag),540 + random(-mag,mag),random(-mag,mag),"FIXED");
      //temp.getVel().set(random(-startSpeed ,startSpeed ),random(-startSpeed ,startSpeed ),random(-startSpeed ,startSpeed ));
      temp.mass = 1000;
      temp.radius = 50;
      blackholes.addParticle(temp);
  }
  
  

}



//////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////



void draw(){
  
    lights();
    updateCamera();
    background(0);
    grid();
    particles.run(blackholes);
    if (play){
        blackholes.run();
    }
    change += 0.08;
    change %= 255;

}
  
  
  
 





//////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////


void showFPS(){
  stroke(255);
  fill(255);
  text("FPS: " + str(frameRate),width -200,100);

}


//////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////




void draw_sphere(float x, float y, float z, float radius){
  fill(255,0,0);
  pushMatrix();
  translate(x,y,z);
  noStroke();
  fill(255);
  lights();
  sphere(radius);
  popMatrix();


}



//////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////