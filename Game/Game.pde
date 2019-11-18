Capture cam;
Board board;
List<Player> players = new ArrayList<Player>();
boolean win = false;

int activePlayer; //0 = blue, 1 = red, 2 = green, 3 = yellow
boolean TokenSelected = false;

void setup() {
  qrSetup();
  diceSetup();
  board = new Board(cam.width, cam.height);
  setupPlayers();
  activePlayer = 0; //<>//
  play();
}

void setupPlayers() {
  players.add(new Player(#0000FF, new Point2D_F64(0, 0)));
  players.add(new Player(#ff0000, new Point2D_F64(0, board.sizeY-2*board.tokenSize)));
  players.add(new Player(#00ff00, new Point2D_F64(board.sizeX-2*board.tokenSize, board.sizeY-2*board.tokenSize)));
  players.add(new Player(#ffff00, new Point2D_F64(board.sizeX-2*board.tokenSize, 0)));
}

void play() {
  while (!win) { //multithreading??? //<>//
    int roll = rollDice(); //<>//
    println("roll " + roll);
    if (players.get(activePlayer).hasTokenOnBoard()) { //<>//
      while(!TokenSelected){ //waiting for player to select token
      }
      Token token = selectToken();
      board.moveToken(token, players.get(activePlayer), roll);
      nextPlayer();
    } else if (roll == 6) { //<>//
      board.newToken(players.get(activePlayer)); //<>//
    } else {
      nextPlayer();
    }
  }
}

Token selectToken() {
  println("Choosing a token to place on board");
  Player player = players.get(activePlayer);
  for (Player p : players) {
    if (p != player) {
      for (Token t : p.tokens) {
        if (collisionRectRect((float)player.user.get(0).x, (float)player.user.get(0).y, (float)(player.user.get(1).y -player.user.get(0).x), (float) (player.user.get(3).y - player.user.get(0).x), (float)t.position.x, (float)t.position.y, (float)board.tokenSize, (float)board.tokenSize))
        {
          TokenSelected = true;
          return t;
        }
      }
    }
  }
  return new Token(#000000, new Point2D_F64(0,0));
}

void nextPlayer() {
  activePlayer = ((activePlayer+1)%4);
}

void win() {
  win = (players.get(activePlayer).tokens.length == 0);
}

void draw() {
  qrDraw();
  drawGameState();
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
