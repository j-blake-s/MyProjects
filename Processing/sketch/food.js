function food(x,y){
	this.pos = createVector(x,y);


	this.draw = function(){
		fill(0,255,0);
		noStroke();
		ellipse(this.pos.x,this.pos.y,10,10);


	}
	this.type = function(){
		return "FOOD";
	}
}


function poison(x,y){
	this.pos = createVector(x,y);
	this.draw = function(){
		fill(255,0,0);
		noStroke();
		ellipse(this.pos.x,this.pos.y,10,10);
	}
	this.type = function(){
		return "POISON";
	}
}	