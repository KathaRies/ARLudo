import processing.video.*;
import boofcv.processing.*;
import java.util.*;
import georegression.struct.shapes.Polygon2D_F64;
import georegression.struct.point.Point2D_F64;
import boofcv.alg.fiducial.qrcode.QrCode;


SimpleQrCode detector;
int activeTokenIndex = 5;
float resW = 1.0;
float resH = 1.0;
float res = 1.0;

void BoardSetup(){
  
}

void qrSetup() {
  // Open up the camera so that it has a video feed to process
  initializeCamera(640, 480); //laptop webcam: 1280, 720
  surface.setSize(2*board.size, board.size);
  detector = Boof.detectQR();
  resW = (float)board.size/640.0;
  resH = (float)board.size/480.0;
  
}

void qrDraw() {
  if (cam.available() == true) {
    cam.read();
    
    List<QrCode> found = detector.detect(cam);
    
    if(!board.initialized){
    PImage img;
     img = loadImage("../Assets/board.png");
     img.resize(board.size,board.size);

    image(img, 0, 0);
    }
      image(cam,board.size + 10,0);
    
    
    // Configure the line's appearance
    noFill();
    strokeWeight(5);
    stroke(255, 0, 0);
    

    for ( QrCode qr : found ) {
      println("message      "+qr.message); //<>//

      switch(qr.message) {
        
      case "blue":
      players.get(3).user =  board.Camera2Board(getCenter(qr.bounds));
        stroke(0, 0, 255);
        break;
      case "red": players.get(0).user =  board.Camera2Board(getCenter(qr.bounds));
          stroke(255, 0, 0);
        break;
      case "green": players.get(2).user =  board.Camera2Board(getCenter(qr.bounds));
        stroke(0, 255, 0);
        break;
      case "yellow": players.get(1).user = board.Camera2Board(getCenter(qr.bounds));
        stroke(255, 255, 0);
        break;    
      case "board": board.setTransform(qr.bounds); //<>//
        println(qr.bounds.get(0).x + ", " + qr.bounds.get(0).y);   
        //res = distance(qr.bounds.get(0),qr.bounds.get(2))/sqrt((2*(board.size*board.size)));
        board.scaleX = board.size/(float)qr.bounds.getSideLength(0);
        board.scaleY = board.size/(float)qr.bounds.getSideLength(1);
        background(255);
        board.initialized = true;
        break;
      default: 
        stroke(0, 0, 0);
      }
      
      
     // println("W: " + resW + "H: " + resH);
      // Draw a line around each detected QR Code
      beginShape();
      for ( int i = 0; i < qr.bounds.size(); i++ ) {
        Point2D_F64 p = board.Camera2Board(qr.bounds.get(i));
       vertex((float)p.x,(float)p.y) ;
        //vertex( (int)(p.x), (int)(p.y));
      }
      // close the loop
      Point2D_F64 p = board.Camera2Board(qr.bounds.get(0));
     // println("a: " + board.inCameraPosition.x + ","+board.inCameraPosition.y + "b: " + p.x +","+p.y + "x (b-a): " + (int)(p.x-board.inCameraPosition.x) + "," + (int)(p.y-board.inCameraPosition.y));
        vertex((float)p.x,(float)p.y) ;
        //vertex( (int)(p.x), (int)(p.y));
      endShape();
    }
  }
}

Point2D_F64 getCenter(Polygon2D_F64 poly){
  //println("center: " + addPoint_2D(divide(subtractPoint_2D(poly.get(0),poly.get(2)),2),poly.get(0)));
  return addPoint_2D(divide(subtractPoint_2D(poly.get(0),poly.get(2)),2),poly.get(0));
}
