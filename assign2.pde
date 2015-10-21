//You should implement your assign2 here.
final int GAME_START = 0;
final int GAME_RUN = 1;
final int GAME_OVER = 2;

PImage bg1,bg2,enemy,fighter,hp,treasure,start2,start1,end1,end2;
int bgX,treasureX,treasureY;
int blood;
int gameState;
final int TOTAL_LIFE = 100;
int life;

float fighterX,fighterY;
float enemyX,enemyY;
float speedX = 3;
float speedY = 3;
boolean upPressed = false;
boolean downPressed = false;
boolean leftPressed = false;
boolean rightPressed = false;
boolean isPlaying = false;

void setup () {
  size(640, 480) ;
  
  bg1 = loadImage("img/bg1.png");
  bg2 = loadImage("img/bg2.png");
  enemy = loadImage("img/enemy.png");
  fighter = loadImage("img/fighter.png");
  hp = loadImage("img/hp.png");
  treasure = loadImage("img/treasure.png");
  start2 = loadImage("img/start2.png");
  start1 = loadImage("img/start1.png");
  end2 = loadImage("img/end2.png");
  end1 = loadImage("img/end1.png");
  
  bgX = 0;
  enemyX = 0;
  enemyY = floor(random(30,400));
  fighterX = 580;
  fighterY = 240;
  treasureX = floor(random(20,590));
  treasureY = floor(random(20,460));
  blood = 200;
  life = TOTAL_LIFE;
  gameState = GAME_START;
}

void draw() {
  background(0);
  
  switch (gameState){
    case GAME_START:
    image(start2,0,0);
    if(mouseX > 205 && mouseX <455 && mouseY >380 && mouseY < 410){
      image(start1,0,0);
      if(mousePressed){
        gameState = GAME_RUN;
      }
    }
    break;
    
    case GAME_RUN:
    image(bg1,bgX,0);
    image(bg2,bgX-bg1.width,0);
    image(bg1,bgX-bg1.width-bg2.width,0);
    bgX++;
    bgX%=(bg1.width+bg2.width);
    
    image(enemy,enemyX,enemyY);
    enemyX=enemyX+3;
    enemyX%=640;
    
    
    fill(255,0,0);
    rect(30,24,blood,20);
    blood = 2*life;
    image(hp,20,20);
    
    image(treasure,treasureX,treasureY);
    
    image(fighter,fighterX,fighterY);
    
    if (upPressed) {
      fighterY -= speedY;
    }
    if (downPressed) {
      fighterY += speedY;
    }
    if (leftPressed) {
      fighterX -= speedX;
    }
    if (rightPressed) {
      fighterX += speedX;
    }
    
    if(fighterX > 590){
      fighterX = 590;
    }
    if(fighterX < 0){
      fighterX = 0;
    }
    if(fighterY > 430){
      fighterY = 430;
    }
    if(fighterY < 0){
      fighterY = 0;
    }
    
    
    if(fighterY > enemyY){
      enemyY++;
    }else{
      enemyY--;
    }
    if(enemyY >= 430){
      enemyX = 0;
    }
    
    //hit detection
    if(fighterX >= enemyX-enemy.width && fighterX <= enemyX+enemy.width){
      if(fighterY >= enemyY-enemy.height &&  fighterY <= enemyY+enemy.height){
        life -= 20;
        enemyX = 0;
        enemyY = 240;  
      }
    }
      if(life <= 0){
        gameState = GAME_OVER;
      }
    
    //score detection
    if(fighterX >= treasureX-treasure.width && fighterX <= treasureX+treasure.width){
      if(fighterY >= treasureY-treasure.height && fighterY <= treasureY+treasure.height ){
        life += 10;
        treasureX = floor(random(20,600));
        treasureY = floor(random(20,460));
        if(life >= 100){
          life = 100;
        }
      }
    }
    break;
    
    
    
    case GAME_OVER:
    image(end2,0,0);
    if(mouseX > 200 && mouseX <440 && mouseY >300 && mouseY < 360){
      if(mousePressed){
        gameState = GAME_RUN;
        life = TOTAL_LIFE;
      }else{
        image(end1,0,0);
      }
    break;
    }
  }
}

void keyPressed(){
  if (key == CODED) { 
    switch (keyCode) {
      case UP:
        upPressed = true;
        break;
      case DOWN:
        downPressed = true;
        break;
      case LEFT:
        leftPressed = true;
        break;
      case RIGHT:
        rightPressed = true;
        break;
    }
  }
}

void keyReleased(){
  if (key == CODED) {
    switch (keyCode) {
      case UP:
        upPressed = false;
        break;
      case DOWN:
        downPressed = false;
        break;
      case LEFT:
        leftPressed = false;
        break;
      case RIGHT:
        rightPressed = false;
        break;
    }
  }
}
