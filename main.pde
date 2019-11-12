Capture cam;

Point2D_F64[][] tokens = new Point2D_F64[4][4];
int boardSizeX = 1280;
int boardSizeY = 720;

int currentPlayer = 0; //1 = blue, 2 = red, 3 = green, 4 = yellow

void setup() {
    qrSetup();
  
  
  for(int player = 0; player<4; player++){
    for(int token = 0; token<4; token ++){
      setColor(player+1);
      tokens[player][token] = new Point2D_F64((20 + 20*token%2) + 20*player,20*token%2+20*player); //adjust layout
      drawToken(tokens[player][token]);
    }
  }
  

}

void draw(){
  
  qrDraw();
  drawGameState();
}

void drawGameState(){
  for(int player = 0; player<4; player++){
    for(int token = 0; token<4; token ++){
      setColor(player+1);
      drawToken(tokens[player][token]);
    }
  }
  
}

void drawToken(Point2D_F64 t){
  rect((float)t.x,(float)t.y,(float)(t.x+50.0),(float)(t.y+50.0));
}

void setColor(int player){
  switch(player){
        case 1: stroke(0,0,255);
                break;
        case 2: stroke(255,0,0);
                break;
        case 3: stroke(0,255,0);
                break;
        case 4: stroke(255,255,0);
                break;      
        default: stroke(0,0,0);
      }
}

void initializeCamera( int desiredWidth, int desiredHeight ) {
  String[] cameras = Capture.list();

  if (cameras.length == 0) {
    println("There are no cameras available for capture.");
    exit();
  } else {
    cam = new Capture(this, desiredWidth, desiredHeight);
    cam.start();
  }
}
