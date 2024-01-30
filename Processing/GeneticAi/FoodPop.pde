// Manages instances of food objects
class FoodPop {
  private int globPower = 1;
  private int globSize = 8;
  private Food[][] grid;
  
  // Initilize empty grid
  void init(int w, int h, int p) {
    this.grid = new Food[w][h];
    this.globPower = p;
  }

  // Constructors
  FoodPop(int w, int h) {
    init(w,h, 0);
  }

  FoodPop(int w, int h, int power) {
    init(w,h, power);
  }
  // Accessors
  int width() { return this.grid.length; }
  int height() { return this.grid[0].length; }

  // Spawn Food Objects
  void randSpawn() {randSpawn(true);}
  void randSpawn(boolean force) {
    do {
      int rX = int(random(this.width()));
      int rY = int(random(this.height()));
      if (this.grid[rX][rY] == null) {
        this.grid[rX][rY] = new Food(rX, rY, this.globPower, this.globSize);
        return;
      }
    } while (force);
  }

  // Return Food Object at given index and also destroy it
  Food eat(int x, int y) {
    Food ret = null;
    if (this.isFood(x,y)) {
      ret = this.grid[x][y];
      this.grid[x][y] = null;
    }
    return ret;
  }

  // Check if given index is valid
  boolean isValid(int x, int y) {
    if (x >= 0 && x < this.width() && 
        y >= 0 && y < this.height()) return true;
    else return false;
  }

  // Check if given index contains a food object
  boolean isFood(int x, int y) {
    if (this.isValid(x,y) && this.grid[x][y] != null) 
      return true;
    else 
      return false;
  }

  // Draw Food Objects
  void draw() {
    for (int i = 0; i < this.width(); i++) {
      for (int j = 0; j < this.height(); j++) {
        if (this.grid[i][j] != null) this.grid[i][j].draw();
    }}
  }

  


}

