import processing.video.*;
import boofcv.processing.*;
import java.util.*;
import georegression.struct.shapes.Polygon2D_F64;
import georegression.struct.point.Point2D_F64;
import boofcv.alg.fiducial.qrcode.QrCode;


SimpleQrCode detector;
int activeTokenIndex = 5;

void qrSetup() {
  // Open up the camera so that it has a video feed to process
  initializeCamera(1280,720);
  surface.setSize(cam.width, cam.height);


  detector = Boof.detectQR();
}

void qrDraw() {
  if (cam.available() == true) {
    cam.read();

    List<QrCode> found = detector.detect(cam);

    image(cam, 0, 0);

    // Configure the line's appearance
    noFill();
    strokeWeight(5);
    stroke(255, 0, 0);

    for( QrCode qr : found ) {
      println("message             "+qr.message);
     int playerId = 0;
      
      switch(qr.message){
        case "blue": playerId = 1;
                     checkTokenCollision(1,qr.bounds);
                            stroke(0,0,255);
                            break;
        case "red": playerId = 2;
                            stroke(255,0,0);
                            break;
        case "green": playerId = 3;
                            stroke(0,255,0);
                            break;
        case "yellow": playerId = 4;
                            stroke(255,255,0);
                            break;      
        default: playerId = 0;
                 stroke(0,0,0);
      }
     // Draw a line around each detected QR Code
      beginShape();
      for( int i = 0; i < qr.bounds.size(); i++ ) {
          Point2D_F64 p = qr.bounds.get(i);
          vertex( (int)p.x, (int)p.y );
      }
      // close the loop
      Point2D_F64 p = qr.bounds.get(0);
      vertex( (int)p.x, (int)p.y );
      endShape();
    }
  }
}

boolean checkTokenCollision(int player, Polygon2D_F64 user){
  
  //for(int i = 0; i < 4; i++){
  //  if(collisionRectRect((float)user.get(0).x, (float)user.get(0).y, (float)(user.get(1).y -user.get(0).x), (float) (user.get(3).y -user.get(0).x), (float)tokens[player][i].x,(float)tokens[player][i].y,(float)tokenSize,(float)tokenSize)){
  //    activeTokenIndex = i;
  //    return true;
  //  }
  //}
    return false;
}

boolean collisionRectRect(float r1x, float r1y, float r1w, float r1h, float r2x, float r2y, float r2w, float r2h) {

  // are the sides of one rectangle touching the other?

  if (r1x + r1w >= r2x &&    // r1 right edge past r2 left
      r1x <= r2x + r2w &&    // r1 left edge past r2 right
      r1y + r1h >= r2y &&    // r1 top edge past r2 bottom
      r1y <= r2y + r2h) {    // r1 bottom edge past r2 top
        return true;
  }
  return false;
}
