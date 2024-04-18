import processing.sound.*;

//declaring my vars
Player p1;
ArrayList<Obstacle> obstacleList;
Obstacle o1;
Obstacle o2;

//sound
SoundFile meowSound;
SoundFile gamePlaySound;

//states
int state = 0;

//declaring timer
int startTime;
int currentTime;
int interval = 2000;

// declaring score timer
int scoreStartTime;
int scoreCurrentTime;

int obstacleCount = 0;

//images
PImage menuImg;
PImage caughtImg;
PImage backgroundImg;

PImage[] catImages = new PImage[2];
Animation catAnimation;

PImage[] catCrouch = new PImage[1];

PImage [] yarnImg = new PImage[1];


void setup(){
  size(900,550);
  
  //initialize timer
  startTime = millis();
  
  //initialize my vars
  p1 = new Player(100, 50, 50);
  o1 = new Obstacle(width - 300, height - 10);
  o2 = new Obstacle(width - 20, height - 75);
  
  meowSound = new SoundFile(this, "meow.wav");
  gamePlaySound = new SoundFile(this, "upbeat.mp3");
  
  meowSound.rate(2);
  
  obstacleList = new ArrayList<Obstacle>();
  obstacleList.add(o1);
  obstacleList.add(o2);
  
  menuImg = loadImage("Woof.jpg");
  rectMode(CENTER);
  menuImg.resize(width, height);
  
  caughtImg = loadImage("Caught.jpg");
  caughtImg.resize(width, height);
  
  backgroundImg = loadImage("Background.jpg");
  backgroundImg.resize(width, height);
  
  //initialize my array of images
  for(int index = 0; index < catImages.length; index ++){
    catImages[index] = loadImage("cat" + index + ".png");
    
   
  }
  
  for(int index = 0; index < catCrouch.length; index ++){
    PImage img = loadImage("crouch" + index + ".png");
    img.resize(int(img.width*3.5), int(img.height*3.5));
    catCrouch[index] = img;
   
  }
  
   for(int index = 0; index < yarnImg.length; index ++){
    PImage img = loadImage("yarn" + index + ".png");
    img.resize(int(img.width*3.5), int(img.height*3.5));
    yarnImg[index] = img;
   
  }
    //initialize my animation var
   catAnimation = new Animation(catImages, 0.1, 3.5);
  
  }




void draw(){

  //states
  switch(state){
    case 0:
    background(menuImg);
    menuScreen();
    break;
    //goes to game play screen
    case 1: 
    gameScreen();
    break;
    //goes to caught screen
    case 3:
    background(caughtImg);
      caughtScreen(); 
    break;
  }
  // checks constantly to see if its collided
  playerCollided();
  
  
  catAnimation.isAnimating = true;
  
}


void keyPressed(){ 
  if(key == 'w' && p1.isJumping == false && p1.isFalling == false){
    p1.isJumping = true; //start a new jump
    p1.highestY = p1.y - p1.jumpHeight;
    meowSound.play();
  }
  
  if(key == 's' && p1.isCrouching ==false){
    p1.isCrouching = true;
    println("is pressed");
    
  }
  //state change
  if(key == ' '){
    state = 1;
    scoreStartTime = millis();
  }
  if(key == 'r'){
    state = 1;
    obstacleList.clear();
    scoreStartTime = millis();
  }
  
 
}

void keyReleased(){
  if(key == 's')
  p1.isCrouching = false;
}

void menuScreen(){
  
}

void gameScreen(){
   background(backgroundImg);
   
   // score timer
   scoreCurrentTime = millis();
   textSize(50);
   text(scoreCurrentTime - scoreStartTime, 600, 50);
  
  //timer
  currentTime = millis();
  
  if(currentTime - startTime > interval){
    println("timer triggered");
    startTime = millis();
    
    int randNum = int(random(0,2));
    
    if (randNum == 0 && obstacleCount < 5){
      obstacleList.add(new Obstacle(int(random(width + 100, width + 300)), height - 10));
    }
    if (randNum == 1 && obstacleCount < 5){
      obstacleList.add(new Obstacle(int(random(width + 100, width + 300)), height - 75));
    }
    
    if (obstacleList.size() > 10){
       interval = 1000; 
    }
    
  }
  obstacleCount = 0;
  for(Obstacle aObstacle : obstacleList){
    aObstacle.render();
    aObstacle.move();
    aObstacle.collide(p1);
    
    if (aObstacle.x > 0 && aObstacle.x < width){
      obstacleCount++;
    }
    
  }
  
  //player
  p1.render();
  p1.jumping();
  p1.falling();
  p1.topOfJump();
  p1.land();
  
  if (gamePlaySound.isPlaying() == false){
    gamePlaySound.play();
  }
  
}

void playerCollided(){
  // did my player collide 
  for(Obstacle aObstacle : obstacleList){
    if (aObstacle.collide(p1) == true){
      state = 3;
    }
  }

}

void caughtScreen(){
  
  //display score
  text("Score:", 98, 400);
  text(scoreCurrentTime - scoreStartTime, 230, 400);
}
