
DebugGame main;
void setup() {
  fullScreen();
  frameRate(60);
  main = new DebugGame();
}

void draw() {
  main.draw_();
}

void keyPressed() {
  Keyboard.keyPressed_(keyCode);
}

void keyReleased() {
  Keyboard.keyReleased_(keyCode);
}