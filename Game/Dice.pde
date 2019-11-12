import websockets.*;
import tramontana.library.*;
import boofcv.factory.background.*;

Tramontana t;
float roll;
float pitch;
float yaw;

void diceSetup() {
  size(480, 120);
  t = new Tramontana(this, "192.249.31.61");
  t.subscribeAttitude(5);
}

float r = 0.2;
float b = 0.5;
float g = 1.0;

//void mousePressed(){
//   startDiceRoll();   
//}



void startDiceRoll(){
  detectShake = true;
}

int shakeCount = 0;
boolean detectShake = true;

void onAttitudeEvent(String ipAddress, float newRoll, float newPitch, float newYaw)
{
  if(detectShake){
    if(newRoll > 0.3 | newPitch > 0.3 | newYaw > 0.3){
      shakeCount++;
     // t.setColor(1.0,0.0,0.0,1.0);
    } else //t.setColor(1.0,0.0,1.0,1.0);
  
    if(shakeCount > 5){
      //t.setColor(0.0,1.0,1.0,1.0);
      shakeCount = 0;
      detectShake = false;
      int roll = int(random(1,7));
      // t.showImage("http://www.kidsmathgamesonline.com/images/pictures/numbers600/number1.jpg");
      //t.showImage("C:/Users/katha/Documents/Uni/Semester-9/CultureTechnology/number1.png");
       t.showImage("/storage/emulated/0/DCIM/Camera/IMG_20191030_141123.jpg");

      print("roll " + roll + "\n");
    }
  }
}

void diceDraw() {
  background(255);
  fill(128);
  text("Hello Tramontana!",width/2-(textWidth("Hello Tramontana!")/2),height/2);
}
