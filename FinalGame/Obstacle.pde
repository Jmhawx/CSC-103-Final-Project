class Obstacle {

  //variables
  int x;
  int y;
  int w;
  int h;

  //hitboxes
  int left;
  int right;
  int top;
  int bottom;

  int speed;


  //constructor
  Obstacle(int startingX, int startingY) {
    rectMode(CENTER);

    x = startingX;
    y = startingY;
    w = 45;
    h = 55;

    speed = 5;

    left = x - w/2;
    right = x + w/2;
    top = y - h/2;
    bottom = y + h/2;
  }

  void render() {
    //rect(x, y, w, h);
    image(yarnImg[0], x, y);
    //rect((right-left)/2,(bottom-top)/2, right-left, bottom-top);
  }

  void move() {
    x -= speed; //x = x-speed;
    //if (x == 0) {
    //  x = width;
    //}
    left = x - w/2;
    right = x + w/2;
    top = y - h/2;
    bottom = y + h/2;
  }



  boolean collide(Player aPlayer) {
    if (aPlayer.isCrouching == false) {
      if (left < aPlayer.tRight &&
        right > aPlayer.tLeft &&
        top < aPlayer.tBottom &&
        bottom > aPlayer.tTop) {
          return true; 
        }

      if (left < aPlayer.bRight &&
        right > aPlayer.bLeft &&
        top < aPlayer.bBottom &&
        bottom > aPlayer.bTop) {

        return true; 
      }
    } else {
      if (left < aPlayer.bRight &&
         right > aPlayer.bLeft &&
         top < aPlayer.bBottom &&
         bottom > aPlayer.bTop) {

        return true; 
      }
    }
    
    return false; 
  }
}
