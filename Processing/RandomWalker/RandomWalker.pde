PVector[] colors = {

  new PVector(255,   0,   0),   // RED 
  new PVector(  0, 255,   0),   // GREEN
  new PVector(  0,   0, 255),   // BLUE
  new PVector(232,  60, 200),   // MAGENTA
  new PVector(122, 255, 243),   // TEAL

};


int BACKGROUND_COLOR = 0;
ArrayList<Walker> walkers;


void different_backgrounds() {
  int[] colors = {0, 60, 127, 155, 200, 255};
  int cl = colors.length;
  noStroke();
  for (int i = 0; i < cl; i++) {
    fill(colors[i]);
    rect(i*width/cl,0, (i+1)*width/cl, height);
  }
}

void setup() {
  fullScreen();
  // different_background();
  background(BACKGROUND_COLOR);
  walkers = new ArrayList<Walker>();
}

void draw() {
  
  for (Walker w : walkers) {
    w.draw();
    w.move();
  }

}

void mouseClicked() {
  walkers.add(new Walker(mouseX, mouseY, chooseRandom(colors)));
}


PVector chooseRandom(PVector[] vecs){
  int i = int(random(vecs.length));
  return vecs[i];
}

PVector randomRGB() {
  int r = int(random(256));
  int g = int(random(256));
  int b = int(random(256));
  return new PVector(r,g,b);
}