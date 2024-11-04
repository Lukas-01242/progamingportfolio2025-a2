// Lukas Jolley | Calc Project | 2 Oct 2024
Button[] buttons = new Button[23];
String dVal = "0";
char op;
float l, r, result;
boolean left;


void setup() {
  size(260, 260);
  background(255, 255, 25);
  left = true;
  op = ' ';
  l = 0.0;
  r = 0.0;
  result= 0.0;

  buttons[0] = new Button(60, 240, color(#7830A0), '0', true);
  buttons[1] = new Button(30, 200, color(5, 100, 180), '1', true);
  buttons[2] = new Button(30, 160, color(5, 100, 180), '4', true);
  buttons[3] = new Button(30, 120, color(5, 100, 180), '7', true);
  buttons[4] = new Button(30, 80, color(#E8913F), 'C', false);
  buttons[5] = new Button(80, 80, color(5, 100, 180), '±', false);
  buttons[6] = new Button(80, 120, color(5, 100, 180), '8', true);
  buttons[7] = new Button(80, 160, color(5, 100, 180), '5', true);
  buttons[8] = new Button(80, 200, color(5, 100, 180), '2', true);
  buttons[9] = new Button(130, 200, color(5, 100, 180), '3', true);
  buttons[10] = new Button(130, 160, color(5, 100, 180), '6', true);
  buttons[11] = new Button(130, 120, color(5, 100, 180), '9', true);
  buttons[12] = new Button(130, 80, color(5, 100, 180), 'π', false);
  buttons[13] = new Button(130, 240, color(5, 100, 180), '.', false);
  buttons[14] = new Button(180, 240, color(5, 100, 180), '+', false);
  buttons[15] = new Button(180, 200, color(5, 100, 180), '-', false);
  buttons[16] = new Button(180, 160, color(5, 100, 180), '÷', false);
  buttons[17] = new Button(180, 120, color(5, 100, 180), 'X', false);
  buttons[18] = new Button(180, 80, color(5, 100, 180), '%', false);
  buttons[19] = new Button(230, 80, color(5, 100, 180), '.', false);
  buttons[20] = new Button(230, 120, color(5, 100, 180), '^', false);
  buttons[21] = new Button(230, 160, color(5, 100, 180), '√', false);
  buttons[22] = new Button(230, 220, color(#256420), '=', false);
  buttons[0].w =90 ;
  buttons[0].h =30 ;
  buttons[22].w =30;
  buttons[22].h =70;
}

void draw() {
  background(0);
  //println("Left:" + l + "Op:" + op + "Right:" + r + "Result:" + result);

  for (int i=0; i<buttons.length; i++) {
    buttons[i].display();
    buttons[i].hover(mouseX, mouseY);
  }
  updateDisplay();
}

void updateDisplay() {
  rectMode(CENTER);
  rect(width/2, 25, 190, 30);
  fill(0);
  if (dVal.length()<17) {
    textSize(20);
  } else if (dVal.length() <18) {
    textSize(15);
  }
  textAlign(RIGHT);
  text(dVal, width-50, 32);
}
void mousePressed() {
  for (int i=0; i<buttons.length; i++) {
    if (buttons[i].on && buttons[i].isNum && left && dVal.length() < 20) {
      if (dVal.equals ("0")) {
        dVal = str(buttons[i].val);
        l = float(dVal);
      } else {
        dVal += buttons[i].val;
        l = float(dVal);
      }
    } else if (buttons[i].on && buttons[i].isNum && !left && dVal.length() < 20) {
      if (dVal.equals ("0")) {
        dVal = str(buttons[i].val);
        r = float(dVal);
      } else {
        dVal += buttons[i].val;
        r = float(dVal);
      }
    } else if (buttons[i].on && buttons[i].isNum && !left) {
      dVal += str(buttons[i].val);
      r = float(dVal);
    } else if (buttons[i].on && !buttons[i].isNum && buttons[i].val == ('+')) {
      dVal = "0";
      op = '+';
      left = false;
    } else if (buttons[i].on && !buttons[i].isNum && buttons[i].val == ('-')) {
      dVal = "0";
      op = '-';
      left = false;
    } else if (buttons[i].on && !buttons[i].isNum && buttons[i].val == ('X')) {
      dVal = "0";
      op = '*';
      left = false;
    } else if (buttons[i].on && !buttons[i].isNum && buttons[i].val == ('÷')) {
      dVal = "0";
      op = '/';
      left = false;
    } else if (buttons[i].on && !buttons[i].isNum && buttons[i].val == ('C')) {
      left = true;
      op = ' ';
      l = 0.0;
      r = 0.0;
      result= 0.0;
      dVal = "0";
    } else if (buttons[i].on && !buttons[i].isNum && buttons[i].val == ('=')) {
      performCalc();
    } else if (buttons[i].on && !buttons[i].isNum && buttons[i].val == ('π')) {
      if (left ) {
        dVal = str(PI);
        l = PI;
      } else {
        dVal = str(PI);
        l = PI;
      }
    } else if (buttons[i].on && buttons[i].val == '.') {
      // decimal
      if (!dVal.contains(".")) {
        dVal += buttons[i].val;
      }
    } else if (buttons[i].on && !buttons[i].isNum && buttons[i].val == '%') {
      if (left) {
        dVal = str(l);
      } else {
        r = r * 0.01;
        dVal = str(r);
      }
    } else if (buttons[i].on && buttons[i].val == '√') {
      if (left) {
        l = sqrt(l);
        dVal = str(l);
      } else {
        r = sqrt(r);
        dVal = str(r);
      }
    } else if (buttons[i].on && buttons[i].val == '^') {
      if (left) {
        l = sq(l);
        dVal = str(l);
      } else {
        r = sq(r);
        dVal = str(r);
      }
    } else if (buttons[i].on && buttons[i].val == '±') {
      if (left) {
        l = l * -1;
        dVal = str(l);
      } else {
        r = r * -1;
        dVal = str(r);
      }
    }
  }
}


void performCalc() {
  if (op == '+') {
    result = l + r;
  } else if (op == '-') {
    result = l - r;
  } else if (op == '*') {
    result = l * r;
  } else if (op == '/') {
    result = l / r;
  } else if (op == '^') {
    result = pow(l, r);
    dVal = str(result);
  }
}
void handleEvent(String keyVal, boolean isNum) {
  // handle numbers
  if ( dVal.length() < 20 && isNum) {

    if (dVal.equals("0")) {
      dVal = keyVal;
    } else {
      dVal += keyVal;
    }
    l = float(dVal);
  }
}


void keyPressed () {
  println("Key:" +key);
  println("KeyCode:" + keyCode);
 if (key == 0 || keyCode == 96 || keyCode == 48) {
     handleEvent("0",true);
  } else if (key == 1 || keyCode == 97 || keyCode == 49 ) {
     handleEvent("1",true);
  } else if (key == 2 || keyCode == 98 || keyCode == 50) {
     handleEvent("2",true);
  } else if (key == 3 || keyCode == 99 || keyCode == 51) {
     handleEvent("3",true);
  } else if (key == 4 || keyCode == 100 || keyCode == 52) {
     handleEvent("4",true);
  } else if (key == 5 || keyCode == 101 || keyCode == 53) {
     handleEvent("5",true);
  } else if (key == 6 || keyCode == 102 || keyCode == 54) {
     handleEvent("6",true);
  } else if (key == 7 || keyCode == 103 || keyCode == 55) {
     handleEvent("7",true);
  } else if (key == 8 || keyCode == 104 || keyCode == 56) {
     handleEvent("8",true);
  } else if (key == 9 || keyCode == 105 || keyCode == 57) {
     handleEvent("9",true);
  } else if (key =='=' || keyCode == 61) {
    handleEvent ("=",true);
  } else if (key == '.' || keyCode == 46 || keyCode == 110) {
     handleEvent (".", false);
  }
}
