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
  
  Player(int c, Point2D_F64 p){
    Color = c;
    homePosition = p;
    tokens[0] = new Token(Color,addPoint_2D (homePosition,new Point2D_F64(0,0))); 
    tokens[1] = new Token(Color,addPoint_2D(homePosition, new Point2D_F64(0 ,tokenSize))); 
    tokens[2] = new Token(Color,addPoint_2D(homePosition,new Point2D_F64(tokenSize,0))); 
    tokens[3] = new Token(Color,addPoint_2D(homePosition,new Point2D_F64(tokenSize,tokenSize))); 
  }
  
  boolean hasTokenOnBoard(){
    for (Token t : tokens){
      if(t.onBoard) return true;
    }
    return false;
  }
  
  
}
