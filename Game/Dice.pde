import websockets.*;
import tramontana.library.*;
import boofcv.factory.background.*;

Tramontana t;
float roll = 0;
float pitch = 0;
float yaw = 0;
boolean detectShake;
int shakeCount = 0;

int diceCount = 0;

void diceSetup() {
  t = new Tramontana(this, "192.249.31.35");
  t.subscribeAttitude(5);
  detectShake = true;
}

void rollDice(){
  detectShake = true;
  shakeCount = 0;
}

void onAttitudeEvent(String ipAddress, float newRoll, float newPitch, float newYaw)
{
  if(detectShake){
    if( abs(pitch-newPitch) > 0.5){ // abs(roll-newRoll) > 2 || abs(yaw-newYaw) > 5){
      println(abs(roll-newRoll) +" " + abs(pitch-newPitch) + " " + newYaw);
      shakeCount++;
      //t.setColor(1.0,0.0,0.0,1.0);
    } //else t.setColor(1.0,0.0,1.0,1.0);
    roll = newRoll;
    pitch = newPitch;
    yaw = newYaw;
  
    if(shakeCount > 10){
      //t.setColor(0.0,1.0,1.0,1.0);
      shakeCount = 0;
      detectShake = false;
      diceCount = int(random(1,7));
      diceRolled = true;
      println("roll " + diceCount);
    }
    
  }
}
