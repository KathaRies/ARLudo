Capture cam; //<>// //<>// //<>// //<>// //<>// //<>//
Board board;
List<Player> players = new ArrayList<Player>();
boolean win = false;
boolean next = false;
boolean TokenSelected = false;
boolean diceRolled = false;

int activePlayer; //0 = blue, 1 = red, 2 = green, 3 = yellow


void setup() {
  board = new Board(1000, 1000);
  qrSetup();
  //diceSetup();
  
  setupPlayers();
  activePlayer = 0;
  //play();
}

void setupPlayers() {
  players.add(new Player(#0000FF, new Point2D_F64(0, 0)));
  players.add(new Player(#ff0000, new Point2D_F64(0, board.sizeY-2*board.tokenSize)));
  players.add(new Player(#00ff00, new Point2D_F64(board.sizeX-2*board.tokenSize, board.sizeY-2*board.tokenSize)));
  players.add(new Player(#ffff00, new Point2D_F64(board.sizeX-2*board.tokenSize, 0)));
}

void play() {
  if (!win) {
    if (!detectShake && !diceRolled){
      rollDice();
    }else if (diceRolled) {
      textSize(board.tokenSize);
      text(diceCount, board.sizeX/2, board.sizeY/2); 
      if(players.get(activePlayer).hasTokenOnBoard()) {    //////////////////just for testing
        Token token = new Token();
        if (!TokenSelected) { //waiting for player to select token
          token = selectToken();
        } else {
          board.moveToken(token, players.get(activePlayer), diceCount);
          win();
          nextPlayer();
        }
      } else if (roll == 6) {
        board.newToken(players.get(activePlayer));
      } else {
        nextPlayer();
      }
    } 
      Player player = players.get(activePlayer);
      rect((float)player.homePosition.x-5, (float)player.homePosition.y-5, board.tokenSize*2+10, board.tokenSize*2+10);
    
  }
}

//Triggers illigaleAgumentexeption: Index out of bounds if qr code wasn't previously detected
Token selectToken() {
  //println("Choosing a token to place on board");
  Player player = players.get(activePlayer);
    
      for (Token t : player.tokens) {
        if(distance(player.user,t.position) < board.tokenSize) {
          TokenSelected = true;
          println("token selected");
          return t;
        }
        //corner order defined by QR code not actually how it is in the picture -> doesn't fit often
        /*rect((float)player.user.get(1).x, (float)player.user.get(1).y, (float)player.user.getSideLength(0), (float) player.user.getSideLength(1));
        if (collisionRectRect((float)player.user.get(1).x, (float)player.user.get(1).y, (float)player.user.getSideLength(0), (float) player.user.getSideLength(1), (float)t.position.x, (float)t.position.y, (float)board.tokenSize, (float)board.tokenSize))
        {
          TokenSelected = true;
          println("token selected");
          return t;
        } */
      }
    //}
  //}
  return new Token(#000000, new Point2D_F64(0, 0));
}

void nextPlayer() {
  if (next) {
    activePlayer = ((activePlayer+1)%4);
    diceRolled = false;
    next = false;
    TokenSelected = false;
    println("next player is player" + activePlayer);
  }
}

void mouseClicked() {
  next = true;
}


void win() {
  win = (players.get(activePlayer).tokens.length == 0);
}

void draw() {
  qrDraw();
  if(board.initialized){
  drawGameState();
  play();
  }
}

void drawGameState() {
  drawTokens();
  board.draw();
}

void drawTokens() {
  for (Player p : players) {
    stroke(p.Color);
    for (Token t : p.tokens) {
      rect((float)t.position.x, (float)t.position.y, board.tokenSize, board.tokenSize);
    }
  }
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

Point2D_F64 addPoint_2D(Point2D_F64 a, Point2D_F64 b) {
  return new Point2D_F64(a.x + b.x, a.y + b.y);
}
Point2D_F64 subtractPoint_2D(Point2D_F64 a, Point2D_F64 b) {
  return new Point2D_F64(a.x - b.x, a.y - b.y);
}

Point2D_F64 divide(Point2D_F64 p, float f){
  return new Point2D_F64(p.x/f, p.y/f);
}

float distance(Point2D_F64 a, Point2D_F64 b){
  Point2D_F64 d = subtractPoint_2D(a,b);
  return sqrt((float)d.x * (float) d.x + (float)d.y * (float)d.y);
}

void initializeCamera( int desiredWidth, int desiredHeight ) {
  String[] cameras = Capture.list();
  println(cameras[0] + " secondd: " + cameras[1]);

  if (cameras.length == 0) {
    println("There are no cameras available for capture.");
    exit();
  } else {
    cam = new Capture(this, desiredWidth, desiredHeight);
    //cam = new Capture(this, desiredWidth, desiredHeight, "HD WebCam");
    cam.start();
  }
}
