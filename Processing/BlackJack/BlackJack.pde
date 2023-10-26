class Stack {
    
  private ArrayList<Card> cards;

  Stack() {
    cards = new ArrayList<Card>();
  }
      
  Card pop() {
    if (this.cards.size() == 0)
      return null;
    else {
      Card temp = this.cards.get(this.cards.size() - 1);
      this.cards.remove(this.cards.size() - 1);
      return temp;
    }
  }
        
  Card peek() {
    if (this.cards.size() == 0)
      return null;
    else
      return this.cards.get(this.cards.size() - 1);
  }

  Card randomPop() {
    int rIdx = int(random(this.cards.size()));
    Card temp = this.cards.get(rIdx);
    this.cards.remove(rIdx);
    return temp;
  } 

  void push(Card c) {
    this.cards.add(c);
  }

  int size() {
    return this.cards.size();
  }
}      


class Card {

  private int points;
  private String suit;
  private String rank;
  private boolean change;

  Card(int pointValue, String aSuit, String aRank) {
    this.points = pointValue;
    this.suit = aSuit;
    this.rank = aRank;
    this.change = false;
  }

  Card(int pointValue, String aSuit, String aRank, boolean doChange) {
    this.points = pointValue;
    this.suit = aSuit;
    this.rank = aRank;
    this.change = doChange;
  }

  // Getters
  int points() {
    return this.points;
  }

  String rank() {
    return this.rank;
  }

  String suit() {
    return this.suit;
  }

  boolean equals(Card that) {
    return this.points == that.points();
  }

  boolean changes() {
    return this.change;
  }
}


class Deck {
  /*  
  
    The value of the cards reflect the rules of Blackjack:
      - Non-face cards are worth their number (2-10)
      - Face cards are worth 10
      - Aces are worth 11 or 1
  
  */

  private Stack cards;
  
  Deck() {
    this.cards = new Stack();
    String[] suits = new String[]{"S","C","H","D"};
    String[] ranks = new String[]{"J","Q","K"};
    for (String suit : suits) {

      // Add cards 2-10
      for (int i = 0; i < 9; i++) {
        this.cards.push(new Card(i+2, suit, ""+(i+2) ));
      }
      
      // Add Jack, Queen, King
      for (String rank : ranks) {
        this.cards.push(new Card(10, suit, rank));
      }

      // Add Ace
      this.cards.push(new Card(11, suit, "A", true));
    }
  
  }
      
  void shuffle() {
    Stack temp = new Stack();
    while (this.cards.size() > 0) temp.push(this.cards.randomPop());
    while (temp.size() > 0) this.cards.push(temp.pop());        
  }

  Card draw() {
    return this.cards.pop();
  }
  
  int size() {
    return this.cards.size();
  }
}


class Player {

  private ArrayList<Card> hand;
  private int money;
  private int score;

  Player() {
    this.hand = new ArrayList<Card>();
    this.money = 2000;
    this.score = 0;
  }

  void addCard(Card c) {
    // if card.pointValue() == 11:
    //    askUser()
    this.hand.add(c);
    this.score += c.points();
  }

  void emptyHand() {
    this.hand = new ArrayList<Card>();
    this.score = 0;
  }

  void deposit(int amount) {
    this.money += amount;
  }

  void withdraw(int amount) {
    if (amount > this.money)
      this.money = 0;
    else
      this.money -= amount;
  }

  int balance() {
    return this.money;
  }

  ArrayList<Card> hand() {
    return this.hand;
  }

  int score() {
    return this.score;
  }
}
    
        
class Button {

  private int left;
  private int right;
  private int top;
  private int bottom;
  private String text;
  private int text_size;

  Button(int x, int y, int w, int h) {
    this.left = x;
    this.right = x + w;
    this.top = y;
    this.bottom = y + h;
    this.text = "";
    this.text_size = 0;
  }
  
  void setText(String t) {
    this.text = t;
  }

  void setTextSize(int s) {
    textSize(s);
  }

  boolean in(int x, int y) {
    if (x > this.left && x < this.right && y > this.top && y < this.bottom)
      return true;
    else 
      return false;
  }

  void draw() {
    rectMode(CORNERS);
    stroke(0);
    fill(255);
    rect(this.left,this.top,this.right,this.bottom);
    rectMode(CORNER);
    textSize(this.text_size);
    fill(0);
    textAlign(CENTER);
    text(this.text, (this.right+this.left)/2, (this.bottom+this.top+this.text_size)/2 );
  }
}

Deck deck;
Player human;

int scene_num  = 0;
Button intro_button;
Button begin_button;
Button end_button;
Player dealer = new Player();
Player player = new Player();
Button finish_bet_button;
Button increment_button;
Button decrement_button;
Button hit_button;
Button stay_button;
int bet = 500;
boolean bool = false;
int count = 0;

void setup() {
  deck = new Deck();
  deck.shuffle();
  human = new Player();

  fullScreen();
  background(0,100,50);

  intro_button = new Button(width/2-125,height/2-50, 225, 50);
  begin_button = new Button(width/2-100,height/2-100, 150, 50);
  end_button = new Button(width/2-100,height/2-40, 150, 50);
  increment_button = new Button(width/2-155,height/2-40, 150, 35);
  decrement_button = new Button(width/2+10,height/2-40, 150, 35);
  finish_bet_button = new Button(width/2-155, height/2, 315, 35);
  stay_button = new Button(width/2 + 30, height/2, 150, 50);
  
  PImage img = loadImage("Back.png");
  for (int i = 0; i < 50; i++)
    image(img, 50 - (i/8.0), 400, 150, 200);
}
        
void draw() {
  if (scene_num == 0)      scene_0();
  else if (scene_num == 1) scene_1();
  else if (scene_num == 2) scene_2();
  else if (scene_num == 3) scene_3();
  else if (scene_num == 4) scene_4();
  else if (scene_num == 5) scene_5();
  else if (scene_num == 6) end_scene();
}

void mouseClicked() {
  if (scene_num == 0 && intro_button.in(mouseX, mouseY)) scene_num = 1;
  
  else if (scene_num == 1) {
    if (begin_button.in(mouseX, mouseY))    scene_num = 2;
    else if (end_button.in(mouseX,mouseY))  scene_num = 6;
  }

  else if (scene_num == 2) {
    if (increment_button.in(mouseX,mouseY)) bet += 100;
    else if (decrement_button.in(mouseX,mouseY)) bet -= 100;
    else if (finish_bet_button.in(mouseX,mouseY)) {
      player.withdraw(bet);
      scene_num = 3;
      for (int i = 0; i < 2; i++) {
        player.addCard(deck.draw());
        dealer.addCard(deck.draw());
      }
    }
  }

  else if (scene_num == 3) {
    if (hit_button.in(mouseX, mouseY)) {
      player.addCard(deck.draw());
      if (player.score() > 21) scene_num = 5;
    }
  }

  else if (stay_button.in(mouseX, mouseY)) scene_num = 4;
}
    
        
   
void scene_0() {
  background(0, 100, 50);
  textSize(40);
  fill(255);
  textAlign(CENTER);
  text("Welcome to BlackJack", width/2, 476);
  intro_button = new Button(width/2-125,height/2-50, 225, 50);
  intro_button.setText("Begin!");
  intro_button.setTextSize(25);
  intro_button.draw();
}

void scene_1() {
  background(0,100,50);
  draw_deck();
  draw_money();
  
  begin_button = new Button(width/2-100,height/2-100, 150, 50);
  begin_button.setText("Start Game");
  begin_button.setTextSize(25);
  begin_button.draw();
  
  end_button = new Button(width/2-100,height/2-40, 150, 50);
  end_button.setText("Quit");
  end_button.setTextSize(25);
  end_button.draw();
}

    

void scene_2() {  
  background(0, 100, 50);
  draw_deck();
  draw_money();
  
  if (bet < 100) bet = 0;
  else if (bet > player.balance()) bet = player.balance();
  textSize(30);
  fill(0);
  text("Your bet:", width/2, height/2-120);
  
  Button new_button = new Button(width/2-100,height/2-100, 200, 50);
  new_button.setText(""+bet);
  new_button.setTextSize(35);
  new_button.draw();
  
  increment_button = new Button(width/2-155,height/2-40, 150, 35);
  increment_button.setText("+100");
  increment_button.setTextSize(25);
  increment_button.draw();
  
  decrement_button = new Button(width/2+10,height/2-40, 150, 35);
  increment_button.setText("+100");
  decrement_button.setTextSize(25);
  decrement_button.draw();
  
  finish_bet_button = new Button(width/2-155, height/2, 315, 35);
  finish_bet_button.setText("Bet");
  finish_bet_button.setTextSize(25);
  finish_bet_button.draw();
}

void scene_2_half() {
  background(0, 100, 50);
  draw_deck();
  draw_money();
  draw_bet();
  display_player_cards();
  display_dealer_cards(false);
  
  if (player.hand().size() == 2) {
    if (count > 0) {
      textSize(30);
      fill(255);
      text("What do you want your ace to be?", width/2, height/2);
      
      Button one_button = new Button(width/2-160,height/2+60, 150, 50);
      one_button.setText("1");
      one_button.setTextSize(25);
      one_button.draw();
      
      Button eleven_button = new Button(width/2+10,height/2+60, 150, 50);
      eleven_button.setText("11");
      eleven_button.setTextSize(25);
      eleven_button.draw();
    }
  }
}
          
      
    
    
void scene_3() {
  
  background(0,100,50);
  draw_deck();
  draw_money();
  draw_bet();
  display_player_cards();
  display_dealer_cards(false);
  display_score();
  
  hit_button = new Button(width/2 - 130, height/2, 150, 50);
  hit_button.setText("Hit");
  hit_button.setTextSize(25);
  hit_button.draw();
  
  stay_button = new Button(width/2 + 30, height/2, 150, 50);
  stay_button.setText("Stay");
  stay_button.setTextSize(25);
  stay_button.draw();

}

void scene_4() {
  if (dealer.score() < 17) dealer.addCard(deck.draw());
  else scene_num = 5;
}

void scene_5() {
    
  if (count == 0) {
    background(0, 100, 50);
    draw_deck();
    draw_money();
    draw_bet();
    display_player_cards();
    display_dealer_cards(true);
    display_score();
    textSize(20);
    fill(255);
    text("Dealer's score: " + dealer.score(), width/2+20, height/2-200);
  }

  count += 1;

  if (count == 5) {
    if (dealer.score() == 21 || player.score() > 21 || (player.score() <= dealer.score() && !(dealer.score() > 21))) {
      fill(255);
      textSize(30);
      text("You lost!", width/2,height/2);  
      bet = 0;
    }

    else {
      fill(255);
      textSize(30);
      text("You win!", width/2, height/2);  
      bet = bet * 2;
    }

  }

  else if (count > 200) {
      player.deposit(bet);
      scene_num = 1;
      count = 0;
      bet = 500;
      player.emptyHand();
      dealer.emptyHand();
      deck = new Deck();
      deck.shuffle();
  }

}
            
void draw_deck() {
  PImage img = loadImage("Back.png");
  noStroke();
  fill(0, 0, 0, 110);
  rect(58, 403, 150, 200);
  for (int i = 0; i < 50; i++) image(img, 50-(i/8.0), 400, 150, 200);
}

void draw_money() {
  fill(0);
  textSize(30);
  text("Your money", width-200, height/2-70);
  Button new_button = new Button(width-300, height/2-50, 200, 50);
  new_button.setText(""+player.balance());
  new_button.setTextSize(30);
  new_button.draw();
}

void draw_bet() {
  fill(0);
  textSize(30);
  text("Your bet", width-200, height/2+80);
  Button new_button = new Button(width-300, height/2+100, 200, 50);
  new_button.setText(""+bet);
  new_button.setTextSize(30);
  new_button.draw();
}

void display_player_cards() {
  ArrayList<Card> temp = player.hand();
  for (int i = 0; i < temp.size(); i++) {
    String pathname = temp.get(i).rank() + temp.get(i).suit() + ".png";
    PImage img = loadImage(pathname);
    image(img, width/2 - (25 * (temp.size() + 1)) + (i * 50), height - 300, 150, 200); 
  }
}
void display_dealer_cards(boolean b) {
  ArrayList<Card> temp = dealer.hand();
  for (int i = 0; i < temp.size(); i++) {
    if (i == 0 && bool == false) {
      String pathname = "Back.png";
      PImage img = loadImage(pathname);
      image(img, width/2 - (25 * (temp.size() + 1)), 40, 150, 200);  
    }
    else {
      String pathname = temp.get(i).rank() + temp.get(i).suit() + ".png";
      PImage img = loadImage(pathname);
      image(img, width/2 - (25 * (temp.size() + 1)) + (i * 50), 40, 150, 200);
    }
  }
}

void display_score() {
  textSize(20);
  fill(255);
  text("Your score: " + player.score(), width/2+20, height-350);
}

void end_scene() {
  exit();
}      
    
    
    

    
