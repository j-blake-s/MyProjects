// Settings
int DEF_POP_SIZE = 8;
int DEF_POP_POWER = 0;

// Manages instances of food objects
class FoodPop {

  private int globPower;
  private int globSize;
  private int foodCount;
  private Food[][] grid;
  
  // Initilize empty grid
  void init(int w, int h, int p, int s) {
    this.grid = new Food[w][h];
    this.globPower = p;
    this.globSize = s;
    this.foodCount = 0;
  }

  // Constructors
  FoodPop(int w, int h) {
    init(w,h, DEF_POP_POWER, DEF_POP_SIZE);
  }

  FoodPop(int w, int h, int power) {
    init(w, h, power, DEF_POP_SIZE);
  }

  FoodPop(int w, int h, int power, int size) {
    init(w, h, power, size);
  }

  // Accessors
  int width() {return this.grid.length;}
  int height() {return this.grid[0].length;}
  int size() {return this.foodCount;}

  // Spawn Food Objects
  private void _addFood(int x, int y, int p, int s) {
    this.grid[x][y] = new Food(x,y,p,s);
    this.foodCount += 1;
  }

  void randSpawn() {randSpawn(true);}
  void randSpawn(boolean force) {
    do {
      int rX = int(random(this.width()));
      int rY = int(random(this.height()));
      if (this.grid[rX][rY] == null) {
        this._addFood(rX, rY, this.globPower, this.globSize);
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
      this.foodCount -= 1;
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

