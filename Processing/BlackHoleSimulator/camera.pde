///////////////////////////////////////////////////////////
/*
This script handles the camera movement and allows
the user to press the keys to move the camera.
*/
//////////////////////////////////////////////////////////




Boolean[] eyeKeys = {false,false,false,false};
Boolean[] centerKeys = {false,false,false,false};

float yzAngle = 0;
float xzAngle = 0;
float roomRadius = 2000;
float cameraRadius = 2400;
PVector eye = new PVector(0,0,roomRadius);
PVector center = new PVector(960,540,0);
PVector up = new PVector(0,1,0);



//////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////

void updateCamera(){
  updateAngle();
  //updateCenter();
  calcPos();
  camera(eye.x + 960,eye.y + 540,eye.z,center.x,center.y,center.z,up.x,up.y, up.z);
   
}

void updateCenter(){
  int mag = 10;
  if (centerKeys[0]){
      center.x -= mag;
      
  }
  else if (centerKeys[1]){
      center.y -= mag;
  }
  else if (centerKeys[2]){
      center.x += mag;
  }
  else if (centerKeys[3]){
      center.y += mag;
  }


}

//////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////

void keyPressed(){
  if (keyCode >= 37 && keyCode <= 40){
      updateKeys(keyCode,true);
  }
  
  if (keyCode == 65 || keyCode == 68 || keyCode == 83 || keyCode == 87 ){
       updateCenterKeys(keyCode, true);
  }
  if (keyCode == 32){
      if (play){
        play = false;
      }  
      else{
         play = true;
      }
  
  }

}


void keyReleased(){
   if (keyCode >= 37 && keyCode <= 40){
       updateKeys(keyCode,false);
    }
    if (keyCode == 65 || keyCode == 68 || keyCode == 83 || keyCode == 87 ){
       updateCenterKeys(keyCode, false);
    }
}

void mouseWheel(MouseEvent event){
      float e  = event.getCount();
      cameraRadius += e*40;

}

//////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////

void updateKeys(int code,Boolean value){
  int index = code - 37;
  eyeKeys[index] = value;
}

void updateCenterKeys(int code,Boolean value){
  int index = -1;
  switch (code){
    case 65:
       index = 0;
       break;
    case 87:
       index = 1;
       break;
    case 68:
       index = 2;
       break;
    case 83:
       index = 3;
       break;
  }
  if (index != -1){
     centerKeys[index] = value;
  }
}

//////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////

void updateAngle(){
  
    float dx = 0.02;
    float dy = 0.02;
    if (eyeKeys[0]){ //LEFT
      xzAngle -= dx;
    }
    if (eyeKeys[1]){ //UP
      yzAngle += dy;
    }
    if (eyeKeys[2]){ //RIGHT
      xzAngle += dx;
    }
    if (eyeKeys[3]){ //DOWN
      yzAngle -= dy;
    }
}

//////////////////////////////////////////////////////////////////////////////////
  //////////////////////////////////////////////////////////////////////////////////
  //////////////////////////////////////////////////////////////////////////////////

void calcPos(){
  
  float y =  cameraRadius * -sin(yzAngle);
  float temp = sqrt(sq(cameraRadius) - sq(y));
  float z = cos(xzAngle) * temp;
  float x = sin(xzAngle) * temp;
  eye = new PVector(x,y,z);
  

}

//////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////


void grid(){
  float r = roomRadius;
  stroke(255);
  line(960-r,540 + r, r ,960-r,540 + r,-r); //Bottom Left Line
  line(960+r,540 + r, r ,960+r,540 + r,-r); //Bottom Right Line
  line(960-r,540 - r, r ,960-r,540 - r,-r); //Top Left Line
  line(960+r,540 - r, r ,960+r,540 - r,-r); //Top Right Line
  line(960-r,540 + r, -r ,960+r,540 + r,-r); //Front Bottom Line
  line(960-r,540 - r, -r ,960+r,540 - r,-r); //Front Top Line
  line(960-r,540 + r, r ,960+r,540 + r,r); //Back Bottom Line
  line(960-r,540 - r, r ,960+r,540 - r,r); //Back Top Line
  line(960-r,540 + r, -r ,960-r,540 - r,-r); //Front Left Support
  line(960+r,540 + r, -r ,960+r,540 - r,-r); //Front Right Support
  line(960-r,540 + r, r ,960-r,540 - r,r); //Back Left Support
  line(960+r,540 + r, r ,960+r,540 - r,r); //Back Right Support
  
  
}
