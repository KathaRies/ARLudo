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
  initializeCamera(1280, 720);
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

    for ( QrCode qr : found ) {
      //println("message             "+qr.message);

      switch(qr.message) {
      case "blue": players.get(0).user = qr.bounds;
        stroke(0, 0, 255);
        break;
      case "red": players.get(1).user = qr.bounds;
          stroke(255, 0, 0);
        break;
      case "green": players.get(2).user = qr.bounds;
        stroke(0, 255, 0);
        break;
      case "yellow": players.get(3).user = qr.bounds;
        stroke(255, 255, 0);
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
