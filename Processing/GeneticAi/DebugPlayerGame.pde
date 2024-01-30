class DebugGame {

  private Mouse player;
  private Food[][] grid;

  private float moveSize = 2;

  DebugGame() {
    background(0);
    this.player = new Mouse(new PVector(width/2, height/2));
    this.grid = new Food[width][height];

    for (int i = 0; i < width; i += 100) {
      for (int j = 0; j < height; j+= 100) {
        grid[i][j] = new Food(i,j,1,5);
      }
    }
  }


  void draw_() {
    
    // Pause screen
    if (Keyboard.toggled(Keys.P)) {
      fill(255);
      noStroke();
      textSize(256);
      textAlign(CENTER);
      text("PAUSED", width/2, height/2);
    }
    else {
      background(0);

      this.movePlayer();  
      this.player.move();
      this.playerEats();

      for (Food[] row : this.grid) {
        for (Food f : row) {
          if (f != null) f.draw();
        }
      }

      // println(this.player.vel);
      this.player.drawConsumptionZone();
      this.player.draw();
    }
  }


  private void playerEats() {
    int[] range = this.player.foodRange();
    for (int i = range[0]; i <= range[1]; i++) {
      for (int j = range[2]; j <= range[3]; j++) {
        if (i >= 0 && i < width && j >=0 && j < height &&
            grid[i][j] != null && 
            this.player.inConsumptionZone(i, j)
        ) {
          this.player.eat(grid[i][j]);
          grid[i][j] = null;
        }
      }
    }
  }

  private void movePlayer() {
    float moveX = 0;
    float moveY = 0;   
    if (Keyboard.pressed(Keys.W)) moveY -= moveSize;
    if (Keyboard.pressed(Keys.S)) moveY += moveSize;
    if (Keyboard.pressed(Keys.A)) moveX -= moveSize;
    if (Keyboard.pressed(Keys.D)) moveX += moveSize;
    this.movePlayer_(moveX, moveY);
  }  

  private void movePlayer_(float x, float y) {
    this.player.acc().add(new PVector(x,y));
  }

}