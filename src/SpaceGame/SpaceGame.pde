//Lukas Jolley | 6 Nov 2024 | SpaceGame
import processing.sound.*;
SoundFile laser1;
int score, level, rockTime;
boolean play;
Spaceship fred;
Rock rocky1;
ArrayList<Rock> rocks = new ArrayList<Rock>();
ArrayList<Rock> toBe_removed_rocks = new ArrayList<Rock>();
ArrayList<Laser> lasers = new ArrayList<Laser>();
ArrayList<Powerup> powups = new ArrayList<Powerup>();
ArrayList<Star> stars = new ArrayList<Star>();
Timer rTime, puTime, sTimer;

void setup() {
  size(500, 500);
  laser1 = new SoundFile(this, "laser17.wav");
  fred = new Spaceship();
  rockTime = 1000;
  rTime = new Timer(rockTime);
  rTime.start();
  puTime = new Timer(700);
  sTimer = new Timer(75);
  sTimer.start();
  noCursor();
  play = false;
}

void draw() {

  if (!play) {
    startScreen();
  } else {

    if (frameCount % 1000 == 0) {
      level++;
      rockTime -= 50;
    }


    background(#363152);
    if (sTimer.isFinished()) {
      stars.add(new Star());
      sTimer.start();
    }

    for (int i = 0; i<stars.size(); i++) {
      Star s = stars.get(i);
      s.display();
      s.move();
      if (s.reachedBottom()) {
        stars.remove(s);
      }
    }



    for (int i = 0; i < lasers.size(); i++) {
      Laser laser= lasers.get(i);
      for (int j = 0; j <rocks.size(); j++ ) {
        Rock r = rocks.get(j);//think about what the rock is used for

        if (laser.intersect(r)) {//answer the question
          //what do we use the rock for
          score+=r.diam;
          lasers.remove(laser);
          rocks.remove(r);
        }
      }

      laser.display();
      laser.move();
      if (laser.reachedTop()) {
        lasers.remove(laser);
      }
    }
    fred.display();
    fred.move(mouseX, mouseY);
    if (rTime.isFinished()) {
      rocks.add(new Rock(0, 0));
      rTime.start();
    }

    for (int i = 0; i < rocks.size(); i++) {
      Rock rock= rocks.get(i);
      rock.display();
      rock.move();
      if (fred.intersect(rock)) {
        if ( fred.invincible == 0) {
          fred.health -= rock.diam;
        }
        rocks.remove(rock);
      }
      if (rock.reachedBottom()) {
        rocks.remove(rock);
      }
    }
    infoPanel();


    //Power Ups
    if (puTime.isFinished()) {
      powups.add(new Powerup((int)random(width), -20));
      puTime.start();
    }

    for (int i = 0; i < powups.size(); i++) {
      Powerup pu= powups.get(i);
      pu.display();
      pu.move();
      if (pu.intersect(fred)) {
        //1. possible heath bennift
        if (pu.type == 'h') {
          fred.health += 100;
          fred.health = min(fred.health, 100);
        } else if (pu.type == 'a') {
          fred.laserCount += 100;
          //fred.health += 100;
        } else if (pu.type == 'w') {
          fred.invincible = 1000;
        }

        //else if  (pu.reachedBottom()) {
        powups.remove(pu);
        //2. replenish ammo
        //3. invincible mode
        //4. increase turret count
        //5. visual change to the ship
        //6. wave to take out all rocks and enimes
        //7.slowdown rocks
        //8.point bonus
      }
      if (pu.reachedBottom()) {
        powups.remove(pu);
      }
    }
    fred.display();
    fred.move(mouseX, mouseY);
    infoPanel();
    fred.invincible--;
    fred.invincible = max(0, fred.invincible);
    if (fred.health < 1) {
      gameOver();
      noLoop();
    }
  }
}
void mousePressed() {
  if (fred.fire ()) {
    laser1.play();
    lasers.add(new Laser(fred.x, fred.y));
    fred.laserCount--;
  }
}


void infoPanel() {
  fill(127, 127);
  rectMode(CENTER);
  rect(width/2, 20, width, 40);
  fill(255);
  textSize(20);
  text("Score:" + score, 50, 35);
  text("Level:" + level, 130, 35);
  text("Health:" + fred.health, 210, 35);
  text("Ammo:" + fred.laserCount, 310, 35);
}

void startScreen() {
  background (0);
  fill(255);
  textSize(30);
  textAlign(CENTER);
  text("Welcome To SpaceGame", width/2, 300);
  text("Click To Start>...", width/2, 350);
  if (mousePressed) {
    play = true;
  }
}
void gameOver() {
  background(0);
  fill(255);
  text("Game_Over  ", width/2, 300);
  text("Score : "+score, width/2, 350);
}

void ticker() {
}
