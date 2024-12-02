class Spaceship {
  // Member Variables
  int x, y, w, health, laserCount, turretCount,invincible;
  //Constructor
  Spaceship() {
    x = width/2;
    y = height/2;
    w = 100;
    health = 100;
    laserCount = 100;
    turretCount = 1;
  }

  void display() {
    rectMode(CENTER);
    fill(0);
    
    rect(x+20, y+40, 10, 10);
    rect(x-20, y+40, 10, 10);
    fill(#9064C1);
    triangle(x, y-40, x+35, y+40, x-35, y+40);
    fill(80);
    triangle(x, y-35, x+10, y-20, x-10, y-20);
    fill(#D1A16E);
    ellipse(x, y+20, 20, 60);
    fill(127);
    stroke(220);
    strokeWeight(2);
    line(x+20, y-20, x+20, y-20);
  }

  void move(int tempX, int tempY) {
    x = tempX;
    y = tempY;
  }

  boolean fire () {
    if ( laserCount > 0) {
      return true;
    } else {
      return false;
    }
  }

  boolean intersect(Rock r) {
    float d = dist(r.x, r.y, x, y);
    if (d<50) { 
      return true;
    } else {
      return false;
    }
  }
}
// do you want to intersect when you are close or far from thge rock 
