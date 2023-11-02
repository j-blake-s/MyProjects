var parents = [];
var popSize = 20;
var debug = true;
var children = [];
var foods = [];
var poisons = [];
var timer = 0;
var d = 100;
var play = true;
var mut_chance = 50;
var gen_time = 1;
var foodSize = 600;
var poisonSize= 600;
mut_chance /= 100;

var frames = 60;
var reduceFrame = false;
var increaseFrame = false; 
var frameDx = 1;

function setup() {
	createCanvas(1600,900);
	background(0);
  for(var i = 0; i < popSize;i++){
    var dude = new Vehicle(random(d,width-d),random(d,height-d),null);
    dude.expressGenes();
    parents.push(dude);
  }

	for (var i = 0; i < foodSize/4; i++){
		foods.push(new food(random(d,width-d),random(d,height-d)));
	}
	for (var i = 0; i <  poisonSize; i++){
		poisons.push(new poison(random(d,width-d),random(d,height-d)));
	}
  frameRate(frames);
	
}

function draw() {

  if (increaseFrame) {
    frames += frameDx;
    frames = min(60, frames);
  }

  if (reduceFrame) {
    frames -= frameDx;
    frames = max(10, frames);
  }


  frameRate(frames);
  if (parents.length == 0){
    for(var i = 0; i < popSize;i++){
      var dude = new Vehicle(width/2,height/2,null);
      dude.expressGenes();
      parents.push(dude);
    } 
  }
  
  background(0);
  stroke(255);
  fill(255);
  textSize(32);
  text("Frames: " + frames, 100, 100);
  drawAgents();
  drawDots();

  if (play){
    runAgents();
    updateDots();


    if (timer % (gen_time*60) == 0){
      for (var i = parents.length-1; i >= 0;i--){
        var dude = parents[i];
        if (dude.score >=  gen_time * dude.r/1.5){
          parents.push(dude.clone());  
        }
        else if (dude.score >=  gen_time * dude.r/3){
          if (random(1) < 0.125){
            parents.push(dude.clone()); 
          }
        }
        else{
          if (random(1) < 0.03125){
            parents.push(dude.clone());  
          }
        }
        dude.score = 0;
      }
    }
    timer += 1;


  }


}
function keyPressed(){
  if (keyCode == 37) {
    reduceFrame = true;
  }

  if (keyCode == 39) {
    increaseFrame = true;
  }

  if (keyCode == 32){
    debug = (debug ==  false);
  }
  if (keyCode == 80){
    play = (play == false);
  }

}

function keyReleased() {
  if (keyCode == 37) {
    reduceFrame = false;
  }

  if (keyCode == 39) {
    increaseFrame = false;
  }
}

function updateDots(){
  if (random(1) < (foodSize/600) && foods.length < foodSize){
    foods.push(new food(random(d,width-d),random(d,height-d)));
  }

  if (random(1) < (poisonSize/600) && poisons.length < poisonSize){
    poisons.push(new poison(random(d,width-d),random(d,height-d)));
  }

 

}
function drawAgents(){
  for (var i = parents.length-1; i >= 0;i--){
    parents[i].draw();
  }
}
function runAgents(){

  for (var i = parents.length-1; i >= 0;i--){
    var dude = parents[i];
    dude.eat(foods,dude.foodPerception);
    dude.eat(poisons,dude.poisonPerception);
    dude.move();
    if (dude.dead()){
      parents.splice(i,1);
    }
  }
}



function drawDots(){
  for (var i =0;i<foods.length;i++){
    foods[i].draw();
  }
  for (var i =0;i<poisons.length;i++){
    poisons[i].draw();
  }
}
