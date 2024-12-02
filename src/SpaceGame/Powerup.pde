class Powerup {
  // Member Variables
  int x, y, w, h, speed, diam;
  char type;
  PImage pu1;


  //Constructor
  Powerup(int x, int y) {
    this.x = int(random(width));
    this.y = -20;
    diam = int (random(20, 50));
    speed = int(random(1, 3));
    //rocky1 = loadImage("powerup1.png");
    int rand = int(random(2));
    if (rand == 0 ) {
      type = 'h';
      pu1 = loadImage("HealthPu.png");
    } else if (rand == 1) {
      pu1 = loadImage("AmmoPu2.png");
      type = 'a';
    } else if (rand == 3) {
      type = 'w';
      pu1 = loadImage("William.png");
    }
  }

  void display() {




    pu1.resize(diam, diam);
    image(pu1, x, y);
  }

  void move() {
    y = y + speed;
  }

  boolean intersect(Spaceship s) {
    float d = dist(x, y, s.x, s.y);
    if (d<50) {
      return true;
    } else {
      return false;
    }
  }
  boolean reachedBottom() {
    if (y > height +200) {
      return true;
    } else {
      return false;
    }
  }
}
