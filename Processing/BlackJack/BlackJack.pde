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
    return this.points
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
        this.cards.push(new Card(i+2,suit,""+(i+2)))
      }
      
      // Add Jack, Queen, King
      for (String rank : ["J","Q","K"]) {
        this.cards.push(new Card(10, suit, rank))
      }

      // Add Ace
      this.cards.push(new Card(11, suit, "A", True)) 
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

  void add_card(Card c) {
    // if card.pointValue() == 11:
    //    askUser()
    this.hand.add(c);
    this.score += c.value();
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

  ArraytList<Card> hand() {
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
    this.textSize(s);
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
    text(this.text, (this.right+this.left)/2.0, (this.bottom+this.top+this.text_size)/2.0 );
  }
}

########################################################################################################################################################

Deck deck;
Player human;

int scene_num  = 0;
int intro_button = 0;
int begin_button = 0;
int end_button = 0;
Player dealer = new Player();
Player player = new Player();
int finish_bet_button = 0;
int increment_button = 0;
int decrement_button = 0;
int hit_button = 0;
int stay_button = 0;
int bet = 500;
boolean bool = False;
int count = 0;

void setup() {
  deck = new Deck();
  deck.shuffle();
  human = new Player();

  fullScreen();
  background(0,100,50);

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

def mouseClicked():
    global scene_num
    global intro_button
    global begin_button
    global end_button
    global bet
    global finish_bet_button
    global increment_button
    global decrement_button
    global hit_button
    global stay_button

    global player
    global dealer
    global deck
    global count
    if scene_num == 0:
        if intro_button.inside(mouseX,mouseY):
            scene_num = 1
    elif scene_num == 1:
        if begin_button.inside(mouseX,mouseY):
            scene_num = 2
        elif end_button.inside(mouseX,mouseY):
            scene_num = 6
    elif scene_num == 2:
        if increment_button.inside(mouseX,mouseY):
            bet += 100
        elif decrement_button.inside(mouseX,mouseY):
            bet -= 100
        elif finish_bet_button.inside(mouseX,mouseY):
            player.decrement_money(bet)
            scene_num = 3
            for i in range(2):
                player.add_card(deck.draw_())
                dealer.add_card(deck.draw_())
                
    elif scene_num == 3:
        if hit_button.inside(mouseX,mouseY):
            player.add_card(deck.draw_())
            if player.score() > 21:
                scene_num = 5
        elif stay_button.inside(mouseX,mouseY):
            scene_num = 4
        
            
    
        
   
def scene_0():
    global intro_button
    background(0,100,50)
    textSize(40)
    fill(255)
    textAlign(CENTER)
    text("Welcome to BlackJack",width/2,476)
    intro_button = Button(width/2-125,height/2-50,225,50)
    intro_button.set_text("Begin!",25)
    intro_button.draw_()
    
def scene_1():
    global begin_button
    global player
    global end_button
    background(0,100,50)
    draw_deck()
    draw_money()
        
    begin_button = Button(width/2-100,height/2-100,150,50)
    begin_button.set_text("Start Game",25)
    begin_button.draw_()
    
    end_button = Button(width/2-100,height/2-40,150,50)
    end_button.set_text("Quit",25) 
    end_button.draw_()
    

    

def scene_2():
    global bool
    global bet
    global finish_bet_button
    global increment_button
    global decrement_button
    global player
    
    background(0,100,50)
    draw_deck()
    draw_money()
        

    
    
    if bet < 100 :
        bet = 0
    elif bet > player.money():
        bet = player.money()
    textSize(30)
    fill(0)
    text("Your bet:",width/2,height/2-120)
    new_button = Button(width/2-100,height/2-100,200,50)
    new_button.set_text(bet,35)
    new_button.draw_()
    
    increment_button = Button(width/2-155,height/2-40,150,35)
    increment_button.set_text("+100",25)
    increment_button.draw_()
    
    decrement_button = Button(width/2+10,height/2-40,150,35)
    decrement_button.set_text("-100",25)
    decrement_button.draw_()
    
    finish_bet_button = Button(width/2-155,height/2,315,35)
    finish_bet_button.set_text("Bet",25)
    finish_bet_button.draw_()
def scene_2_half():
    global player
    global dealer
    global bet
    global deck
    global hit_button
    global stay_button
    global count
    global eleven_button
    global one_button
    background(0,100,50)
    draw_deck()
    draw_money()
    draw_bet()
    display_player_cards()
    display_dealer_cards(False)
    
    if len(player.hand()) == 2:
        if count > 0:
            textSize(30)
            fill(255)
            text("What do you want your ace to be?",width/2,height/2)
            
            one_button = Button(width/2-160,height/2+60,150,50)
            one_button.set_text("1",25)
            one_button.draw_()
            
            eleven_button = Button(width/2+10,height/2+60,150,50)
            eleven_button.set_text("11",25)
            eleven_button.draw_()
            
            
            
        
    
    
def scene_3():
    global player
    global dealer
    global bet
    global deck
    global hit_button
    global stay_button
    background(0,100,50)
    draw_deck()
    draw_money()
    draw_bet()
    display_player_cards()
    display_dealer_cards(False)
    
    
    display_score()
    
    hit_button = Button(width/2 - 130,height/2, 150,50)
    hit_button.set_text("Hit",25)
    hit_button.draw_()
    
    stay_button = Button(width/2 + 30,height/2, 150,50)
    stay_button.set_text("Stay",25)
    stay_button.draw_()
def scene_4():
    global dealer 
    global deck
    global scene_num
    global count
    if dealer.score() < 17:
        dealer.add_card(deck.draw_())
    else:
        scene_num = 5
def scene_5():

    global player
    global dealer
    global bet
    global deck
    global hit_button
    global stay_button
    global count
    global scene_num
    
    if count == 0:
        background(0,100,50)
        draw_deck()
        draw_money()
        draw_bet()
        display_player_cards()
        display_dealer_cards(True)
        display_score()
        textSize(20)
        fill(255)
        text("Dealer's score: " + str(dealer.score()), width/2+20,height/2-200)
    count += 1
    if count == 5:
        if dealer.score() == 21 or player.score() > 21 or (player.score() <= dealer.score() and not dealer.score() > 21):
            fill(255)
            textSize(30)
            text("You lost!",width/2,height/2)  
            bet = 0
        else:
            fill(255)
            textSize(30)
            text("You win!",width/2,height/2)  
            bet = bet * 2
    elif count > 200:
        player.increment_money(bet)
        scene_num = 1
        count = 0
        bet = 500
        player.clear_hand()
        dealer.clear_hand()
        deck = Deck()
        deck.shuffle_()
    
            
            
    
            
    
    
    
    

    
def draw_deck():
    img = loadImage("Back.png")
    noStroke()
    fill(0,0,0,110)
    rect(58,403,150,200)
    for i in range(50):
        image(img, 50-i/8,400,150,200)
        
def draw_money():
    fill(0)
    textSize(30)
    text("Your money",width-200,height/2-70)
    new_button = Button(width-300,height/2-50,200,50)
    new_button.set_text(player.money(),30)
    new_button.draw_()
    
def draw_bet():
    global bet
    fill(0)
    textSize(30)
    text("Your bet",width-200,height/2+80)
    new_button = Button(width-300,height/2+100,200,50)
    new_button.set_text(bet,30)
    new_button.draw_()
    
def display_player_cards():
    global player
    temp = player.hand()
    for i in range(len(temp)):
        pathname = temp[i].rank() + temp[i].suit() + ".png"
        img = loadImage(pathname)
        image(img, width/2- (25 * (len(temp) + 1)) + (i * 50), height - 300,150,200) 
        
def display_dealer_cards(bool):
    global dealer
    temp = dealer.hand()
    for i in range(len(temp)):
        if i == 0 and bool == False:
            pathname = "Back.png"
            img = loadImage(pathname)
            image(img, width/2- (25 * (len(temp) + 1)), 40,150,200)  
        else:
            pathname = temp[i].rank() + temp[i].suit() + ".png"
            img = loadImage(pathname)
            image(img, width/2- (25 * (len(temp) + 1)) + (i * 50), 40,150,200)  
            
def display_score():
    global player

    textSize(20)
    fill(255)
    text("Your score: " + str(player.score()), width/2+20,height-350)
            
def end_scene():
    exit()
        
    
    
    

    
