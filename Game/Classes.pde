class Token {
  boolean onBoard;
  int Color;
  int position=0;
  int sq_size= height/15;
  int Playernumber;
  
  Token(){
    Color = #000000;
     
    onBoard = false;
  }
  
  Token(int c, int playernumber){
    Color = c;
    onBoard = false;
    Playernumber = playernumber;
  }
  
  void draw(){
    fill(0,255,0);
  //println("token draw now");
  pushMatrix();
  translate(360,360);
 
  switch(Playernumber) {
    case 0: 
    break;
    
    case 1: 
    rotate(radians(90));
    break;
    
    case 2: 
    rotate(radians(180));
    break;
    
    case 3: 
    rotate(radians(270));
    break;
    }
    translate(-360,-360);
  
  fill(Color);
  stroke(255);
  strokeWeight(2);
  ellipse(path1[position][0]*sq_size+24,path1[position][1]*sq_size+24,sq_size,sq_size);
  popMatrix();
  
}
}

class Player{
  color Color;
  Token[] tokens = new Token[4];
  //Point2D_F64 homePosition;
  Point2D_F64 user; //position of the QR code of that player
  int playernumber;
  Player(color c, int pno){
    Color = c;
    playernumber = pno;
    tokens[0] = new Token(Color,playernumber); 
    tokens[1] = new Token(Color,playernumber); 
    tokens[2] = new Token(Color,playernumber); 
    tokens[3] = new Token(Color,playernumber); 
     user = new Point2D_F64();
    }
  
  boolean hasTokenOnBoard(){
    for (Token t : tokens){ //<>// //<>//
      if(t.onBoard) return true;
    }
    return false;
  }
}

class Board{
  int size = 720;
  int tokenSize = 100;
  Point2D_F64 inCameraPosition;
  float scaleX = 1.0;
  float scaleY = 1.0;
  boolean initialized = false;
  
  Board(int width, int hight){
    size = hight;
    initialized = false;
  }
  
  void setTransform(Polygon2D_F64 qr){
    inCameraPosition = new Point2D_F64(qr.get(0).x,qr.get(0).y);
  }
  
  Point2D_F64 Camera2Board(Point2D_F64 p){
    return new Point2D_F64((p.x-inCameraPosition.x)*scaleX, (p.y-inCameraPosition.y)*scaleY);
  }
  
  //drawing the base game board
  void draw(){
    stroke(0);
    strokeWeight(1);
    //println("the board should draw now");
    int sq_size= height/15; 
    rectMode(CENTER);
    rect(0,0,sq_size*15,sq_size*15);
    for(int i=0;i<15;i++){
      for(int j=0;j<15;j++){
      rectMode(CORNER);
        gridboxclr(i,j,1,1,4);
      }
    }
    gridboxclr(0,0,6,6,4);
    gridboxclr(9,0,6,6,4);
    gridboxclr(9,9,6,6,4);
    gridboxclr(0,9,6,6,4);
    gridboxclr(6,6,3,3,4);
    
    for(int k=0;k<24;k++){
      gridboxclr(ramp[k][1],ramp[k][2],1,1,ramp[k][0]);
    }
    
  }
  
  
  void gridboxclr(int w, int h, int l, int b, int clr)
  {
    color c=#000000;
    switch(clr) {
  case 0: 
    c=color(255,0,0);  // Does not execute
    break;
  case 1: 
    c=#FFCC00;  // Prints "One"
    break;
    case 2: 
    c=color(0,255,0);  // Prints "One"
    break;
    case 3: 
    c=color(0,0,255);  // Prints "One"
    break;
    case 4: 
    c=color(255,255,255);  // Prints "One"
    break;
    }
    
    int sq_size= height/15;
    fill(c);
    rect(w*sq_size,h*sq_size,l*sq_size,b*sq_size);
  }
  
  void moveToken(Token token, int diceRoll){
    //if(token.position==path1.length){
    //  player.tokens.delete(token);}
    //if(player.tokens.empty()) win = true
    for(int i=0;i<diceRoll;i++){
      token.position++;
      token.draw(); //<>//
      double time=millis();
      while(millis()<time+1000){}
      }
    println("moved token");
  } //<>//
  
  void newToken(Player player){ //<>//
    //println("setting new token on board");
    //setToken
  }
  
  private void setToken(Token token, Point2D_F64 position ){ //<>//
    //if(collision with other token) battle(a , b) //idea number board for easy checks
    //else token.position = position;
  }
  
}


int [][] ramp = { 
    //red
                  {0,1,6},
                  {0,1,7},
                  {0,2,7},
                  {0,3,7},
                  {0,4,7},
                  {0,5,7},
     //yellow     
                  {1,8,1},
                  {1,7,1},
                  {1,7,2},
                  {1,7,3},
                  {1,7,4},
                  {1,7,5},
     //GREEN     
                  {2,9,7},
                  {2,10,7},
                  {2,11,7},
                  {2,12,7},
                  {2,13,7},
                  {2,13,8},                  
     //BLUE     
                  {3,7,9},
                  {3,7,10},
                  {3,7,11},
                  {3,7,12},
                  {3,7,13},
                  {3,6,13},
                  };

  int [][] path1 = { 
                  {2,2},
                  {1,6},
                  {2,6},
                  {3,6},
                  {4,6},  
                  {5,6},  
                  {6,5},  
                  {6,4},  
                  {6,3},  
                  {6,2},  
                  {6,1},  
                  {6,0},  
                  {7,0},  
                  {8,0},  
                  {8,1},  
                  {8,2},  
                  {8,3},  
                  {8,4},  
                  {8,5},  
                  {9,6},  
                  {10,6},  
                  {11,6},  
                  {12,6},  
                  {13,6},  
                  {14,6},
                  {14,7},  
                  {14,8},  
                  {13,8},
                  {12,8},
                  {11,8},
                  {10,8},
                  {9,8},
                  {8,9},
                  {8,10},
                  {8,11},
                  {8,12},
                  {8,13},
                  {8,14},
                  {7,14},
                  {6,14},
                  {6,13},
                  {6,12},
                  {6,11},
                  {6,10},
                  {6,9},
                  {5,8},
                  {4,8},
                  {3,8},
                  {2,8},
                  {1,8},
                  {0,8},
                  {0,7},
                  {1,7},
                  {2,7},
                  {3,7},
                  {4,7},
                  {5,7},
                  {0,0},
                  
  };