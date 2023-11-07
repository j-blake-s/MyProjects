

Food[][] grid; 

void setFood(int x, int y) {
  grid[x][y] = new Food(x,y,1,10);
}

void setup() {

  fullScreen();
  background(0);
  player = new Mouse(new PVector(width/2, height/2));
  grid = new Food[width][height];
}

void draw() {

  background(0);
  movePlayer();  
  for (Food[] row : grid) {
    for (Food f : row) {
      if (f != null) f.draw();
    }
  }
  player.move();
  player.drawFoodSearchArea();
  player.draw();
  player.drawBoundingBox();
  //setFood(100,300);


}