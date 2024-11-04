class Button {
  // Refere to the first part of a class as member Bariables
  int w, h, x, y;
  color c1, c2;
  char val;
  boolean on, isNum;

  //Contstroctor
  Button(int x, int y, color c1, char val, boolean isNum) {

    this.x = x;

    this.y = y;
    w =30;
    h =30;

    this.c1 = c1;
    c2 = color(128);
    this.val = val;
    on=false;
    this.isNum = isNum;
  }
  // Mebmer methods
  void display() {
    if (on == false) {
      fill(c1);
    } else {
      fill(c2);
    }
    rectMode(CENTER);
    rect(x, y, w, h, 5);
    fill(255, 255, 255);
    textAlign(CENTER, CENTER);
    textSize(20);
    text(val, x, y);
  }
  boolean hover(int mx, int my) {
    if (mx > x-w/2 && mx < x+w/2 && my > y-h/2 && my < y+h/2) {
      on = true;
      return on;
    } else {
      on = false;
      return on;
    }
  }
}
