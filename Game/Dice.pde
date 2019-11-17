import websockets.*;
import tramontana.library.*;
import boofcv.factory.background.*;

Tramontana t;
float roll;
float pitch;
float yaw;

int diceCount = 0;

void diceSetup() {
  t = new Tramontana(this, "192.249.31.61");
  t.subscribeAttitude(5);
}

float r = 0.2;
float b = 0.5;
float g = 1.0;


int rollDice(){
  detectShake = true;
  
  while(detectShake){
  }
  return diceCount;
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
      diceCount = int(random(1,7));
      print("roll " + diceCount + "\n");
    }
  }
}
