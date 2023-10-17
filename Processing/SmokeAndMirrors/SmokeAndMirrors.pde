//from Fire import *



float windX = 0.001;
float windY = 0.001;
float dt = 0.001;
boolean[] keys_ = new boolean[]{false, false, false, false};

Fire fire;
void setup() {
    fullScreen(P2D);
    background(0);
    fire = new Fire(PVector(width/2,height/2));
    frameRate(60);
}

void draw() {
    background(50);
    tint(255);
//     updateWind()
    PVector forceOfWind = new PVector(windX,windY);
//     fire.applyForce(forceOfWind)
//     fire.update()
    fill(255);
    text("FRAMERATE: " + str(frameRate), width - 150,30);
    // text("CLUSTERS " + str(fire.count()), width - 150,60);
}

    
void keyPressed() {

    // Keys (Arrows): Left, Up, Right, Down
    if (keyCode >= 37 && keyCode <= 40) {
        keys_[keyCode - 37] = true;
    }
    else if (keyCode == 49) {
        fire.color_type = "RED-ORANGE";
    }
    else if (keyCode == 50) {
        fire.color_type = "BLUE-WHITE";
    }
    else if (keyCode == 51) {
        fire.color_type = "GREEN";
    }
    else if (keyCode == 52) {
        fire.color_type = "ORANGE";
    }
    else {
        return;
    }
}


void keyReleased() {
    if (keyCode >= 37 && keyCode <= 40) {
        keys_[keyCode - 37] = false;
    }
}

// def updateWind():
//     global keys_
//     global windX
//     global windY
//     global dt
//     if keys_[0]:
//         windX -= dt
//     if keys_[1]:
//         windY -= dt
//     if keys_[2]:
//         windX += dt
//     if keys_[3]:
//         windY += dt
        
