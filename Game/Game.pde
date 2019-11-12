Capture cam;

Point2D_F64[][] tokens = new Point2D_F64[4][4];
int boardSizeX = 1280;
int boardSizeY = 720;
int tokenSize = 100;

int activePlayer = 0; //1 = blue, 2 = red, 3 = green, 4 = yellow

void setup() {

  qrSetup();
  boardSizeX = cam.width;
  boardSizeY = cam.height;
  setupPlayers();
}

void setupPlayers(){
  setupTokens(new Point2D_F64(0,0),0);
  setupTokens(new Point2D_F64(0,boardSizeY-2*tokenSize),1);
  setupTokens(new Point2D_F64(boardSizeX-2*tokenSize,boardSizeY-2*tokenSize),2);
  setupTokens(new Point2D_F64(boardSizeX-2*tokenSize,0),3);
}

void setupTokens(Point2D_F64 playerPosition, int playerIndex){
  tokens[playerIndex][0] = addPoint_2D (playerPosition,new Point2D_F64(0,0)); 
      drawToken(tokens[playerIndex][0]);
      tokens[playerIndex][1] = addPoint_2D(playerPosition, new Point2D_F64(0 ,tokenSize)); 
      drawToken(tokens[playerIndex][1]);
      tokens[playerIndex][2] = addPoint_2D(playerPosition,new Point2D_F64(tokenSize,0)); 
      drawToken(tokens[playerIndex][2]);
      tokens[playerIndex][3] = addPoint_2D(playerPosition,new Point2D_F64(tokenSize,tokenSize)); 
      drawToken(tokens[playerIndex][3]);
}

void draw(){
  
  qrDraw();
  drawGameState();
}

void drawGameState(){
  for(int player = 0; player<4; player++){
    for(int token = 0; token<4; token ++){
      setColor(player+1);
      if(token == activeTokenIndex && player == activePlayer){
        stroke(255,255,255);
      } 
      drawToken(tokens[player][token]);
    }
  }
  
}

void drawToken(Point2D_F64 t){
  rect((float)t.x,(float)t.y,tokenSize,tokenSize);
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

Point2D_F64 addPoint_2D(Point2D_F64 a, Point2D_F64 b){
  return new Point2D_F64(a.x + b.x, a.y + b.y);
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
