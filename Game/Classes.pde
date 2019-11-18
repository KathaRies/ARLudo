class Token {
  boolean onBoard;
  int Color;
  Point2D_F64 position;
  
  Token(int c, Point2D_F64 p){
    Color = c;
    onBoard = false;
    position = p;
  }
}

class Player{
  int Color;
  Token[] tokens = new Token[4];
  Point2D_F64 homePosition;
  Polygon2D_F64 user; //position of the QR code of that player
  
  Player(int c, Point2D_F64 p){
    Color = c;
    homePosition = p;
    tokens[0] = new Token(Color,addPoint_2D (homePosition,new Point2D_F64(0,0))); 
    tokens[1] = new Token(Color,addPoint_2D(homePosition, new Point2D_F64(0 ,board.tokenSize))); 
    tokens[2] = new Token(Color,addPoint_2D(homePosition,new Point2D_F64(board.tokenSize,0))); 
    tokens[3] = new Token(Color,addPoint_2D(homePosition,new Point2D_F64(board.tokenSize,board.tokenSize))); 
  }
  boolean hasTokenOnBoard(){
    for (Token t : tokens){
      if(t.onBoard) return true;
    }
    return false;
  }
}

class Board{
  int sizeX = 1280;
  int sizeY = 720;
  int tokenSize = 100;
  
  Board(int width, int hight){
    sizeX = width;
    sizeY = hight;
  }
  
  void draw(){
    //draw the whole game board
  }
  
  void moveToken(Token token,Player player, int diceRoll){
    //if(endzone) player.tokens.delete(token)
    //if(player.tokens.empty()) win = true
    println("moved token");
  }
  
  void newToken(Player player){ //<>//
    println("setting new token on board");
    //setToken
  }
  
  private void setToken(Token token, Point2D_F64 position ){ //<>//
    //if(collision with other token) battle(a , b) //idea number board for easy checks
    //else token.position = position;
  }
  
}
