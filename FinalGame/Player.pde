class Player {

  //variables
  int x;
  int y;

  int w;
  int h;


  boolean isJumping;
  boolean isFalling;

  int speed;

  int jumpHeight;  //distance that you can jump upwards
  int highestY; //y value of the top of your jump

  //hitboxes
  //top hitbox
  int tLeft;
  int tRight;
  int tTop;
  int tBottom;

  //bottom hitbox (for crouch)
  int bLeft;
  int bRight;
  int bTop;
  int bBottom;

  boolean isCrouching;

  //constructor
  Player(int startingX, int startingW, int startingH) {
    x = startingX;
    w = startingW;
    h = startingH;
    y = height - h/2;

    isJumping = false;
    isFalling = false;

    speed = 10;

    jumpHeight = 160;
    highestY = y - jumpHeight;


    //hitbox
    tLeft = x - w/2;
    tRight = x + w/2;
    tTop = y - h/2;
    tBottom = y;

    bLeft = x - w/2;
    bRight = x + w/2;
    bTop = y;
    bBottom = y + h/2;

    isCrouching = false;
  }

  //functions
  void render() {
    rectMode(CENTER);
    //rect(x, y, w, h);
    if (keyPressed == true && key == 's'){
      image(catCrouch[0], x, y);
    }
    else{
      catAnimation.display(x,y);
    }
    //update the bounds of playerhitbox
    tLeft = x - w/2;
    tRight = x + w/2;
    tTop = y - h/2;
    tBottom = y;

    bLeft = x - w/2;
    bRight = x + w/2;
    bTop = y;
    bBottom = y + h/2;
  }

  void jumping() {
    if (isJumping == true) {
      y -= speed;
    }
  }

  void falling() {
    if (isFalling == true) {
      y += speed;
    }
  }

  void topOfJump() {
    if (y <= highestY) {
      isJumping = false; // stop jumping upward
      isFalling = true;  // start falling downward
    }
  }

  void land() {
    if (y >= height - h/2) {
      isFalling = false; //stop falling
      y = height - h/2; // snap player to position where they are standing on bottom of window
    }
  }

}
