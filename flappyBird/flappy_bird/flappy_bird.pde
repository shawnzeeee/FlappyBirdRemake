 int mode;
int playerY;
float topWall1X;
float wallHeight1;
float bottomWall1, bottomWall1H; 
float topWall2X;
float wallHeight2;
float bottomWall2, bottomWall2H;
float acs;
float fps;
int score, previousScore, bestScore;
boolean obj1score, obj2score;
boolean jump;
boolean spaceKey;
float size;
float sizeInc;
void setup(){
  mode = 1;
  playerY = 300;
  size(1280,720);
  //spaceKey = false;
  acs = 5;
  jump = false;
  fps = 60;
  obj1score = false;
  obj2score = false;
  previousScore = 0;
  topWall1X = width; //X coordinate of the first top wall
  wallHeight1 = random(50,500); // height of the first top wall
  bottomWall1 = wallHeight1 +100; //height of the bottom wall
  bottomWall1H = 625 - bottomWall1; //length of the bottom wall to the ground
  
  topWall2X = width + 500;
  wallHeight2 = random(50,400);
  bottomWall2 = wallHeight2 +100;
  bottomWall2H = 625 - bottomWall2;
  size = 50;
  sizeInc = 8;
  score = 0;
  bestScore = 0;
}

void draw(){
//  frameRate(fps);
  if (mode == 1){
   menuSelection(); 
  }
  if (mode == 2){
   playerJump();
   moveObjects();
  }
  if (mode != 1){
   drawAssets(); 
   keepScore();
  }
    if (mode == 3){
   gameOver();   //reset variables 
   fps = 60;


  }
//  println ("acs  "+ acs + "  playerY   " + playerY + "  jump  " + jump);
}

void menuSelection(){
  background (0);
  textSize(size);
  text("Play",size/2 + width/2 -200,height/2);
  size += sizeInc;
  sizeInc -= 0.25;
  if (size < 50){
   sizeInc = 8; 
  }
  println(size + "   " + sizeInc); 
  if (mousePressed){
   mode = 2; 
  }
}

void drawAssets(){
  background(#0805FF);
  fill (#05FF17);
  rect(0,625,width,95); // background
  
  fill (0);
  ellipse(200,playerY,50,50); //player
  
  rect (topWall1X,0,50,wallHeight1); //the top wall of the first obstacle
  rect (topWall1X,bottomWall1,50,bottomWall1H); //the bottom wall of the first obstacle
  
  rect (topWall2X,0,50,wallHeight2); //the top wall of the second obstacle
  rect (topWall2X,bottomWall2,50,bottomWall2H); //the bottom wall of the second obstacle
}

void playerJump(){
  if(spaceKey == true){
    acs = 5;
  }
      playerY -= acs;
      acs -= 0.5;
     
   if (playerY > 600){ //if the player touches the ground then it's game over
    mode = 3;
  }
   if ((playerY > 0 && playerY - 25 < wallHeight1 && 225 > topWall1X && 225 < topWall1X + 50)||(playerY < 625 && playerY + 25 > bottomWall1 && 225 > topWall1X && 225 < topWall1X + 50)){ //if the player touches the first set of walls, then it's game over
    mode = 3; 
   }
   if ((playerY > 0 && playerY - 25 < wallHeight2 && 225 > topWall2X && 225 < topWall2X + 50)||(playerY < 625 && playerY + 25 > bottomWall2 && 225 > topWall2X && 225 < topWall2X + 50)){ //if the player touches the first set of walls, then it's game over
    mode = 3; 
   } 
   if (225 >= topWall1X && obj1score == false){
     score += 1;
     obj1score = true;
     }
 
   
   if (225 >= topWall2X && obj2score == false){
        score += 1;
        obj2score = true;
  }
}


void moveObjects(){
  topWall1X -= 5;
  if (topWall1X < -75){
    obj1score = false;
    topWall1X = random (width,width + 600);
    wallHeight1 = random(50,400);
    bottomWall1 = wallHeight1 + 100;
    bottomWall1H = 625 - bottomWall1;
  }
  topWall2X -= 5;
  if (topWall2X < -75){
    obj2score = false;
    fps += 5;
   topWall2X = topWall1X + 700; 
   wallHeight2 = random(50,400);
   bottomWall2 = wallHeight2 + 100;
   bottomWall2H = 625 - bottomWall2;
  }
}
void gameOver(){
   if (score > bestScore){
      bestScore = score;    
    }
  if(playerY < 625){
   playerY += 10; 
  }
  if(playerY > 600){
  
    previousScore = score;
    background(255);
      textSize (100);
  text("Game Over",200,300);
  text("Score  " + score,200,400);
  text("Your Best  " + bestScore,200,500);
 if (mousePressed){
   playerY = 300;
   acs = 5;
   jump = false;
  topWall1X = width;
  wallHeight1 = 200;
  bottomWall1 = wallHeight1 + 100;
  bottomWall1H = 625 - bottomWall1;
  
  topWall2X = width + 500;
  wallHeight2 = 400;
  bottomWall2 = wallHeight2 + 100;
  bottomWall2H = 625 - bottomWall2; 
  obj1score = false;
  obj2score = false;
  previousScore = 0;
    mode = 1;
    score = 0;
  }
  }
}
void keepScore(){
  textSize(50);
 text(previousScore + "    " + score,100,100);
}
void keyPressed(){
  if (key == ' '){
   spaceKey = true; 
  }
}

void keyReleased(){
  if (key == ' '){
   spaceKey = false; 
  }
}