class Rock {
  // Member Variables
  int x, y, w, h, speed, diam;
  PImage rocky1;


  //Constructor
  Rock(int x, int y) {
    this.x = int(random(width));
    this.y = -20;
    diam = int (random(20,50));
    speed = int(random(1, 3));
    rocky1 = loadImage("Rock1.png");
  }

  void display() {
    rocky1.resize(diam,diam);
    image(rocky1, x, y);
  }

  void move() {
    y = y + speed;
  }

  boolean reachedBottom() {
    if (y > height +200) {
      return true;
    } else {
      return false;
    }
  }
}
