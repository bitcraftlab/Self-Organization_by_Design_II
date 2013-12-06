

// let's turn the mouse into a pipette...

void mousePaint() {
  paint(mouseButton == LEFT ? RED : BLUE, pmouseX, pmouseY, mouseX, mouseY);
}

// Adding some chemical between x1 and x2
void paint(int chemical, int x1, int y1, int x2, int y2) {

  // add some over-shoot
  int dx = 5;

  if (x1 > x2) {

    // flip direction if necessary
    paint(chemical, x2, y2, x1, y1);
  } 
  else {

    // make sure we don't go off limits
    x1 = constrain(x1 - dx, 0, width-1);
    x2 = constrain(x2 + dx, 0, width-1);
   
    // sweep from left to right
    for (int x = x1; x < x2; x++) {
      float y = constrain(map(x, x1, x2, y1, y2), 0, height);  
      ca[chemical][CELLS][x] = map(height - y, 0, height, 0, cmax);
    }
  }
}

// init with noise
void randomInit() {
  for (int i = 0; i < chemicals; i++) {
    for (int x = 0; x < width; x++) {
      ca[i][CELLS][x] = random(cmax) * .65;
    }
  }
}


