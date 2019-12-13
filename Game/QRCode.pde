import processing.video.*;
import boofcv.processing.*;
import java.util.*;
import georegression.struct.shapes.Polygon2D_F64;
import georegression.struct.point.Point2D_F64;
import boofcv.alg.fiducial.qrcode.QrCode;


SimpleQrCode detector;
int activeTokenIndex = 5;

void BoardSetup(){
  
}

void qrSetup() {
  // Open up the camera so that it has a video feed to process
  initializeCamera(640, 480); //laptop webcam: 1280, 720
  surface.setSize(2*board.sizeX, board.sizeY);


  detector = Boof.detectQR();
}

void qrDraw() {
  if (cam.available() == true) {
    cam.read();
    
    List<QrCode> found = detector.detect(cam);
    
    if(!board.initialized){
    PImage img;
     img = loadImage("../Assets/board.png");
     img.resize(board.sizeX,board.sizeY);

    image(img, 0, 0);
    } else {
      //clear();
    }
    
    // Configure the line's appearance
    noFill();
    strokeWeight(5);
    stroke(255, 0, 0);
    

    for ( QrCode qr : found ) {
      //println("message             "+qr.message);

      switch(qr.message) {
        
      case "blue": players.get(0).user = subtractPoint_2D(getCenter(qr.bounds),new Point2D_F64(board.inCameraPosition.get(0).x,board.inCameraPosition.get(0).y));
        stroke(0, 0, 255);
        break;
      case "red": players.get(1).user = subtractPoint_2D(getCenter(qr.bounds),new Point2D_F64(board.inCameraPosition.get(0).x,board.inCameraPosition.get(0).y));
          stroke(255, 0, 0);
        break;
      case "green": players.get(2).user = subtractPoint_2D(getCenter(qr.bounds),new Point2D_F64(board.inCameraPosition.get(0).x,board.inCameraPosition.get(0).y));
        stroke(0, 255, 0);
        break;
      case "yellow": players.get(3).user = subtractPoint_2D(getCenter(qr.bounds),new Point2D_F64(board.inCameraPosition.get(0).x,board.inCameraPosition.get(0).y));
        stroke(255, 255, 0);
        break;    
      case "board": board.inCameraPosition = qr.bounds;
        board.initialized = true;
        break;
      default: 
        stroke(0, 0, 0);
      }
      // Draw a line around each detected QR Code
      beginShape();
      for ( int i = 0; i < qr.bounds.size(); i++ ) {
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

Point2D_F64 getCenter(Polygon2D_F64 poly){
  return divide(subtractPoint_2D(poly.get(0),poly.get(2)),2);
}
