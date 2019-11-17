Capture cam;

int boardSizeX = 1280;
int boardSizeY = 720;
int tokenSize = 100;

List<Player> players = new ArrayList<Player>();
boolean win = false;

int activePlayer; //0 = blue, 1 = red, 2 = green, 3 = yellow

void setup() {

  qrSetup();
  //diceSetup();
  
  boardSizeX = cam.width;
  boardSizeY = cam.height;
  setupPlayers();
  activePlayer = 0;
}

void setupPlayers(){
  players.add(new Player(#0000FF, new Point2D_F64(0,0)));
  players.add(new Player(#ff0000, new Point2D_F64(0,boardSizeY-2*tokenSize)));
  players.add(new Player(#00ff00, new Point2D_F64(boardSizeX-2*tokenSize,boardSizeY-2*tokenSize)));
  players.add(new Player(#ffff00, new Point2D_F64(boardSizeX-2*tokenSize,0)));
}

void play(){
 while(!win){
  int roll = rollDice();
  if(players.get(activePlayer).hasTokenOnBoard()){
      chooseToken();
  }else if(roll == 6){
    setToken();
  } else {
    nextPlayer();
  }
 }
}

void setToken(){
  println("Setting a new token on the board");
}

void chooseToken(){
  println("Choosing a token to place on board");
}

void nextPlayer(){
  activePlayer = ((activePlayer+1)%4);
}

void draw(){
  
  qrDraw();
  drawGameState();
}

void drawGameState(){
      drawTokens();
}

void drawTokens(){
  for (Player p : players) {
   stroke(p.Color);
    for (Token t : p.tokens){
      rect((float)t.position.x,(float)t.position.y,tokenSize,tokenSize);
    }
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
