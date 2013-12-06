
/////////////////////////////////////////
//                                     //
//          B E E   S W A R M          //
//                                     //
/////////////////////////////////////////

// (c) Martin Schneider @bitcraftlab 2013

int n = 1000;
Swarm swarm;
Space space;

Wall dummy = dummyWall();
Wall mouseWall = dummy;


float d_separation = 6; // separation distance
float d_cohesion = 50;    // cohesion distance
float d_alignment = 100;  // alignment distance
float d_density = 2.0;

float f_cohesion = 1.0;
float f_separation = 1.0;
float f_alignment = 1.0;


void setup() {
  size(500, 500);
  fill(0, 10);
  reset();
  swarm.addBees(30);
}

void draw() {
  background(255);
  swarm.step();
  space.draw();
  swarm.draw();
  
  // cursor
  pushStyle();
  stroke(255, 0, 0);
  mouseWall.draw();
  popStyle();
  
  if(mousePressed && mouseButton != RIGHT) {
    swarm.add(new Bee(mouseX, mouseY));
  }  
}

void reset() {
  swarm = new Swarm();
  space = new Space();
}

void keyPressed() {
  switch(key) {
    case ' ': reset(); break;
  }
}

void mousePressed() {

  if(mouseButton != LEFT) {
    mouseWall = new Wall(mouseX, mouseY, mouseX, mouseY);
  }
}

void mouseDragged() {
  if(mouseButton != LEFT) {
    mouseWall.x2 = mouseX;
    mouseWall.y2 = mouseY;
  }
}

void mouseReleased() {
  if(mouseButton != LEFT) {
    space.walls.add(mouseWall);
    mouseWall = dummy;
  }
}
