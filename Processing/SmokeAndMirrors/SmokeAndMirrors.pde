float windX = 0;
float windY = 0;
float maxWind = 0.1;
float dt = maxWind/20;
int smoke_size = 200;
boolean[] keys_ = new boolean[]{false, false, false, false};

Fire fire;
void setup() {
  fullScreen(P2D);
  background(0);
  fire = new Fire(width/2, height/2, smoke_size);

  frameRate(120);
}

void draw() {
  background(50);
  tint(255);
  updateWind();
  drawWind(100,height-100,1000);
  fire.set_center(mouseX, mouseY);
  PVector forceOfWind = new PVector(windX,windY);
  fire.apply_force(forceOfWind);
  fire.run();


  
  fill(255);
  textSize(18);
  text("FRAMERATE: " + str(round(frameRate)), width - 200,30);
  // text("CLUSTERS " + str(fire.count()), width - 150,60);
}

  
void keyPressed() {
  // Keys (Arrows): Left, Up, Right, Down
  if (keyCode >= 37 && keyCode <= 40) keys_[keyCode - 37] = true;
  // Key (Num): 1
  else if (keyCode == 49) fire.color_type = "RED-ORANGE";
  // Key (Num): 2
  else if (keyCode == 50) fire.color_type = "BLUE-WHITE";
  // Key (Num): 3
  else if (keyCode == 51) fire.color_type = "GREEN";
  // Key (Num): 4
  else if (keyCode == 52) fire.color_type = "ORANGE";
}

void keyReleased() {
  // Keys (Arrows): Left, Up, Right, Down
  if (keyCode >= 37 && keyCode <= 40) keys_[keyCode - 37] = false;
}

void updateWind() {
  // if Left Arrow then push left
  if (keys_[0] && windX >= -maxWind) windX -= dt;
  // if Up Arrow then push up
  if (keys_[1] && windY >= -maxWind) windY -= dt;
  // if Right Arrow then push right
  if (keys_[2] && windX <= maxWind) windX += dt;
  // if Down Arrow then push down
  if (keys_[3] && windY <= maxWind) windY += dt;     

  windX = min(maxWind, max(-maxWind, windX));
  windY = min(maxWind, max(-maxWind, windY));
}

void drawWind(int x, int y, float s) {
  noFill();
  stroke(0,100,255);
  ellipse(x,y,maxWind*s*2,maxWind*s*2);
  PVector wind = new PVector(windX, windY);
  stroke(0,255,0);
  line(x,y,x+(wind.x*s),y);
  stroke(255,0,0);
  line(x,y,x,y+(wind.y*s));
  stroke(255);  
  wind.setMag(s*max(abs(wind.x),abs(wind.y)));
  line(x,y,x + (wind.x),y+(wind.y));
}