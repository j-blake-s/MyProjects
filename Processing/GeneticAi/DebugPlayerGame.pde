class DebugGame {

  private Mouse player;
  private FoodPop food;
  private FoodPop poison;

  private int clock = 0;
  private float moveSize = 2;

  private Nest mice;

  DebugGame() {
    background(0);
    this.mice = new Nest();
    DNA dna = new DNA(MouseGenes.NUM_GENES);
    dna.write(MouseGenes.SIZE, 0);
    this.player = new Mouse(new PVector(width/2, height/2), dna);
    this.food = new FoodPop(width, height, 15);
    this.poison = new FoodPop(width, height, -15);



    for (int i = 0; i < 15; i++) {
      this.mice.add(new Mouse(new PVector(int(random(width)), int(random(height)))));
    }

    for (int i = 0; i < 100; i++) {
      this.food.randSpawn();
    }

    for (int i = 0; i < 100; i++) {
      this.poison.randSpawn();
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
      clock = (clock + 1) % 60;
      background(0);

      if (clock % 30 == 0) {
        this.food.randSpawn();
        this.poison.randSpawn();
      }

      this.movePlayer();  
      this.player.move();
      this.playerEats();

      fill(255);
      textSize(64);
      text(""+this.player.health(), 100, 100);
      
      this.food.draw();
      this.poison.draw();

      this.player.drawConsumptionZone();
      this.player.draw();

      // Draw mice
      this.mice.draw();
    }
  }


  private void playerEats() {
    int[] range = this.player.foodRange();
    for (int i = range[0]; i <= range[1]; i++) {
      for (int j = range[2]; j <= range[3]; j++) {
        if (this.player.inConsumptionZone(i, j)) {
          this.player.eat(this.food.eat(i,j));
          this.player.eat(this.poison.eat(i,j));
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