//0: 1.123128381664825
//1: 0.08236322374051114
//2: 0.4997687412115857
//3: 0.13875459222126144


var MAXSPEEDVAR = 2;
var foodEaten = 0;
var poisonEaten = 0;
function Vehicle(x,y,dna){
	this.pos = createVector(x,y);
	this.vel = createVector(random(-2,-1,1,2),random(-2,-1,1,2));
	this.pVel = createVector(0,0);
	this.acc = createVector(0,0);
	this.r = 8
	this.health = 1;
	this.score = 0;
	this.timeToDepletion = 4;
	this.dna = [];
	if (dna == null){
		for (var i =0; i < 6;i++){
			this.dna[i] = random(1);
		}
	}
	else{
		this.dna = dna;
	}

	this.randomDNA = function(numGenes){
		for (var i =0; i < numGenes;i++){
			this.dna[i] = random(1);
		}
	}
	this.expressGenes = function(){

		this.foodAttraction = (this.dna[0] * 4) - 2; //How attracted to food it is

		this.poisonAttraction = (this.dna[1] * 4) - 2;//How attracted to poison it is

		this.foodPerception = (this.dna[2] * (49 * this.r)) + this.r;//How far it can perceive food

		this.poisonPerception  = (this.dna[3] * (49 * this.r)) + this.r;//How far can it perceive poison

		//this.maxSpeed = MAXSPEEDVAR;
		this.maxSpeed = this.dna[4] * 5;
		
		this.maxForce = 1;
	}

	this.dead = function(){
		if (this.health <= 0){
			return true;
		}
	}
	
	this.clone = function(){
		var childDNA = [];

		for (var i = 0; i < this.dna.length;i++){
			if (random(1) < mut_chance){
				childDNA[i] = this.dna[i] * random(0.8,1.2);
			}
			else{
				childDNA[i] = this.dna[i];
			}
	
		}
		var child = new Vehicle(random(d,width-d),random(d,height-d),childDNA);
		child.expressGenes();
		return child;
	

	}	
	this.boundaries = function(){

		var desired = null;
		if (this.pos.x < d){
			desired = createVector(this.maxSpeed,this.vel.y);
		}
		else if (this.pos.x > width){
			desired = createVector(-this.maxSpeed,this.vel.y);
		}

		if (this.pos.y < d ){
			desired = createVector(this.vel.x, this.maxSpeed);
		}
		else if (this.pos.y > height-d){
			desired = createVector(this.vel.x,-this.maxSpeed);
		}	

		if (desired !== null){
			desired.normalize();
			desired.mult(this.maxSpeed);
			var steer = p5.Vector.sub(desired,this.vel);
			steer.limit(this.maxForce * 5);
			this.applyForce(steer);
		}
	}
	this.eat = function(list,perception){
		var closest = -1;
		var record = 9999999;
		var deletable = [];
		for(var i = 0 ;i < list.length;i++){	
			var temp = list[i];
			var d = temp.pos.dist(this.pos);
			if (abs(d) < record && abs(d) < perception){
				closest = i;
				record = d;

			}
		}
		if (abs(record) < this.r){
			if (list[closest].type() == "POISON"){
				poisonEaten += 1;
				this.health -= (1/10);
				if (this.score > 0){
					this.score -= 1;
				}
			}	
			else{
				foodEaten += 1;
				this.health += (1/10);
				this.score += 1;
			}
			list.splice(closest,1);
		}
		else if (closest != -1){
			var temp = list[closest];
			if (temp.type() == "POISON"){
				
				this.seek(list[closest].pos,this.poisonAttraction);	
				//list[closest].draw();
			}
			else{
				//console.log("NOOOOO");
				this.seek(list[closest].pos,this.foodAttraction);	
				//list[closest].draw();
			
			}
		}
		else{
			this.vel.mult(1);
		}
	
	}

	this.seek = function(target,scalar){
		var sep = p5.Vector.sub(target,this.pos);
		sep.setMag(this.maxSpeed);
		var steer = p5.Vector.sub(sep,this.vel);
		steer.limit(this.maxForce);
		steer.mult(scalar);
		this.applyForce(steer);
	}

	this.applyForce = function(force){
		this.acc.add(force);
	}
	this.move = function() {
		this.boundaries();
		this.vel.add(this.acc);
		this.vel.limit(this.maxSpeed);
		this.pos.add(this.vel);
		this.acc.mult(0);
		this.health -= (1 / (this.timeToDepletion * 60));
	}

	this.draw = function(){

		// Color based on health
		var green = color(0, 255, 0);
	  	var red = color(255, 0, 0);
	  	var col = lerpColor(red, green, this.health)
	  	
	  	// Draw a triangle rotated in the direction of velocity
	  	var theta = this.vel.heading() + PI / 2;
	  	push();
	  	translate(this.pos.x, this.pos.y);
	  	rotate(theta);

	  	// Draw the vehicle itself
		fill(col);
		stroke(col);
		beginShape();
		vertex(0, -this.r * 2);
	  	vertex(-this.r, this.r * 2);
		vertex(this.r, this.r * 2);
		endShape(CLOSE);
		pop();

		if (debug){
			push();
			translate(this.pos.x,this.pos.y);
			//Draw Attractiveness Lines
			var temp = createVector(this.vel.x,this.vel.y);


			//Food Attraction
			strokeWeight(4);
			stroke(green);
			temp.normalize();
			temp.mult(this.foodAttraction * 50);
			line(0,0,temp.x,temp.y);


			//Poison Attraction
			strokeWeight(2);
			stroke(red);
			temp.normalize();
			temp.mult(this.poisonAttraction * 50);
			line(0,0,temp.x,temp.y);


		

			//Food Perception Shell
			stroke(green);
			noFill();
			ellipse(0,0,this.foodPerception*2);

			//Poison Perception Shell
			stroke(red);
			noFill();
			ellipse(0,0,this.poisonPerception*2);

			

			pop();
		}

	
	}




}