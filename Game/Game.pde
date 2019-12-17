Capture cam; //<>// //<>// //<>// //<>// //<>// //<>// //<>//
Board board;
List<Player> players = new ArrayList<Player>();
boolean win = false;
boolean next = false;
boolean TokenSelected = false;
boolean diceRolled = false;

int activePlayer; //0 = blue, 1 = red, 2 = green, 3 = yellow


void setup() {
  board = new Board(1280, 720);
  qrSetup();
  diceSetup();
  setupPlayers();
  activePlayer = 0;  
  //play();
}

void setupPlayers() {
  players.add(new Player(#FF0000, 0));
  players.add(new Player(#FFCC00, 1));
  players.add(new Player(#00FF00, 2));
  players.add(new Player(#0000FF, 3));
}

void play() {
  if (!win) {
    if (!detectShake && !diceRolled) {
      rollDice();
    } else if (diceRolled) {
      textSize(board.tokenSize);
      fill(players.get(activePlayer).Color);
      text(diceCount, board.size/2, board.size/2); 
      //if (players.get(activePlayer).hasTokenOnBoard()) {    
       if(true){        ///just for testing
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
    //rect((float)player.homePosition.x-5, (float)player.homePosition.y-5, board.tokenSize*2+10, board.tokenSize*2+10);
  }
}

//Triggers illigaleAgumentexeption: Index out of bounds if qr code wasn't previously detected
Token selectToken() {
  //println("Choosing a token to place on board");
  Player player = players.get(activePlayer);

  for (Token t : player.tokens) {
    PVector u = new PVector((float)player.user.x, (float)player.user.y); //<>//
    PVector tt = new PVector((float)path1[t.position][0]*height/15, (float)path1[t.position][1]*height/15);
    //println("player: " +u.x + "," + u.y);
    
    //u.add(new PVector(360,360));
    switch(player.playernumber) {
    case 0: 
      break;
    case 1: 
      tt.rotate(radians(-90));
      break;
    case 2: 
      tt.rotate(radians(-180));
      break;
    case 3:  
      tt.rotate(radians(-270));
      break;
    }
    tt.add(360,360);

    
    println("Token: " + tt.x + ","+ tt.y);
    println("Player: " + u.x +" , " + u.y);
    if (distance(new Point2D_F64(u.x,u.y), new Point2D_F64(tt.x,tt.y)) < board.tokenSize) {
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
  return new Token(#000000, 0);
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
  
  if (board.initialized) {
    drawGameState();
    play();
  }
  qrDraw();
}

void drawGameState() {

  board.draw();
  drawTokens();
}

void drawTokens() {
  for (Player p : players) {
    stroke(p.Color);
    for (Token t : p.tokens) {
      t.draw();
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

Point2D_F64 divide(Point2D_F64 p, float f) {
  return new Point2D_F64(p.x/f, p.y/f);
}
Point2D_F64 multiply(Point2D_F64 p, float fx,float fy) {
  return new Point2D_F64(p.x*fx, p.y*fy);
}

float distance(Point2D_F64 a, Point2D_F64 b) {
  Point2D_F64 d = subtractPoint_2D(a, b);
  return sqrt((float)d.x * (float) d.x + (float)d.y * (float)d.y);
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
