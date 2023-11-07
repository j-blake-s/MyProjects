

Food f;
Mouse m;
void setup() {

  fullScreen();
  background(0);
  m = new Mouse(new PVector(width/2, height/2));
}

void draw() {

  background(0);
  m.draw();
  m.drawBoundingBox();
}