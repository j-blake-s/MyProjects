


ArrayList<Walker> walkers;
void setup() {
  fullScreen();
  background(255);
  walkers = new ArrayList<Walker>();
}

void draw() {
  
  for (Walker w : walkers) {
    w.draw();
    w.move();
  }

}


void mouseClicked() {
  walkers.add(new Walker(mouseX, mouseY));
}