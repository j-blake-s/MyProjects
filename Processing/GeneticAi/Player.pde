Mouse player;
boolean[] keys = new boolean[]{false, false, false, false};
int moveSize = 3;

void keyPressed() {
  // keyCode == w
  if (keyCode == 87) {
    keys[0] = true;
  }

  // keyCode == a
  if (keyCode == 65) {
    keys[1] = true;
  }

  // keyCode == s
  if (keyCode == 83) {
    keys[2] = true;
  }

  // keyCode == d
  if (keyCode == 68) {
    keys[3] = true;
  }
}


void keyReleased() {
  // keyCode == w
  if (keyCode == 87) {
    keys[0] = false;
  }

  // keyCode == a
  if (keyCode == 65) {
    keys[1] = false;
  }

  // keyCode == s
  if (keyCode == 83) {
    keys[2] = false;
  }

  // keyCode == d
  if (keyCode == 68) {
    keys[3] = false;
  }
}


void movePlayer() {

  // keyCode == w
  if (keys[0]) {
    PVector v = player.acc();
    v.y -= moveSize;
    player.acc(v);
  }

  // keyCode == a
  if (keys[1]) {
    PVector v = player.acc();
    v.x -= moveSize;
    player.acc(v);
  }

  // keyCode == s
  if (keys[2]) {
    PVector v = player.acc();
    v.y += moveSize;
    player.acc(v);
  }

  // keyCode == d
  if (keys[3]) {
    PVector v = player.acc();
    v.x += moveSize;
    player.acc(v);
  }
}