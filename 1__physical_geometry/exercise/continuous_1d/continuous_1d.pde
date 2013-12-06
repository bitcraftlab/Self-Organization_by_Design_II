
//////////////////////////////////////////////
//                                          //
//     1D Reaction-Diffusion System         //
//                                          //
//////////////////////////////////////////////

// (c) bitcraftlab 2013

// Simple example of a continuous 1D CA with two chemicals

float[][][] ca;
int chemicals = 2;
int memories = 2;

color palette[] = {  #ff0000, #0000ff };
float[] diffusionRate = { 0.1, 0.1 };
float[][] reactionRate = {{ 0, 0.1 }, { -0.1, -0.02 }};

int RED = 0, BLUE = 1;
int CELLS = 0, MEMORY = 1;
int speedup = 5;

float cmax = 1.0; // maximum concentrations
boolean paused;

void setup() {

  size(800, 240);
  ca = new float[chemicals][memories][width];
  randomInit();
  
  background(255);

}

PImage img;

void draw() {

  // performing several steps before showing the state
  // making everything a lot smoother to watch
  
  if(!paused) {
    for (int i= 0; i < speedup; i++) {
      pushMemory();
      for (int c = 0; c < chemicals; c++) {
        for (int x = 0; x < width; x++) {
          reaction_diffusion(c, x);
        }
      }
    }
  }


  // maximum height
  background(255);

  // flip the screen upside-down
  translate(0, height);
  scale(1, -1);

  // sweep from left to right, bar-chart style
  for (int i = 0; i < chemicals; i++) {
    stroke(palette[i], 63);
    for (int x = 0; x < width; x++) {
      line(x, 0, x, ca[i][CELLS][x] * height);
    }
  }

}

void mousePressed() {
  mousePaint();
}

void mouseDragged() {
  mousePaint();
}

void keyPressed() {
  switch(key) {
    case ' ': randomInit(); break;
    case 'p': paused = !paused; break;
  }

}
