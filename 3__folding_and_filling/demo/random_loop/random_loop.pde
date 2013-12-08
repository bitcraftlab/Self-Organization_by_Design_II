
// Random Loop

// Closed loop variation of a random walk.
// To extend the loop we pick 2 positions to insert two
// steps in opposite directions

int dirs = 8;

float wstroke = 2.0;          // stroke weight
color cstroke = color(0, 80); // stroke color

float ang;
int[] walk;
float x, y;
BBox bbox = new BBox();


void setup() {
  size(400, 400);
  stroke(cstroke);
  fill(0, 100);
  smooth();
  reset();
}


void draw() {

  // info
  background(255);
  textAlign(LEFT);  text("random loop", 20, 20);
  textAlign(RIGHT); text("dirs: " + nf(dirs, 2), width - 20, 20);

  // extend the loop
  int dir =  randInt(dirs/2);
  walk = insert(walk, dir, randInt(walk.length));                   // add a single step anywhere in the loop
  walk = insert(walk, (dir + dirs/2) % dirs, randInt(walk.length)); // add the reverse step anywhere else
  
  // draw the loop
  bbox.centerScale(0.8);
  //bbox.reset();
  x = y = 0;
  for(int i = 0; i< walk.length; i++) {
    bbox.update(x, y);
    line(x, y, x += cos(walk[i] * ang), y += sin(walk[i] * ang));
  }


}

class BBox {
  
  boolean scaling;
  float xmin, xmax, ymin, ymax;
  
  void reset() {
    xmax = xmin = ymax = ymin = 0; 
  }
  void update(float x, float y) {
    xmin = min(x, xmin); xmax = max(x, xmax);
    ymin = min(y, ymin); ymax = max(y, ymax);
  }
  
  void centerScale(float factor) {
    translate(width/2, height/2);
    if(scaling) {
      float zoom = min(width, height) / max(xmax - xmin, ymax - ymin) * factor;
      scale(zoom);
      strokeWeight(wstroke / zoom);
    } else {
      strokeWeight(wstroke);
    }
    translate(-(xmax + xmin)/2, -(ymax + ymin)/2);
  }
} 


void reset() {
  walk = new int[] {};
  ang = TWO_PI / dirs;
  bbox.reset();
}

void keyPressed() {
  switch(keyCode) {
    case 'S'  : bbox.scaling =! bbox.scaling; return;
    case UP   : dirs += 2; break;
    case DOWN : dirs -= 2; break;
  }
  dirs = constrain(dirs, 4, 36);
  reset();
}


// insert an item into an array
int[] insert(int[] a, int item, int pos) {
  return concat(append(subset(a, 0, pos), item), subset(a, pos));
}


// we might want to use javas built-in random Integer functions ...
int randInt(int x) {
  return int(random(x));
}
