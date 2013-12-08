/* OpenProcessing Tweak of *@*http://www.openprocessing.org/sketch/5669*@* */
/* !do not delete the line above, required for linking your tweak if you re-upload */

  /////////////////////////////////////
  //                                 //
  //  ///////     Rubik's Snake      //                          
  //  //                             //
  //  /////////////////////////////////
  //
  /////////// (c) Martin Schneider 2009 
  
  // Updated for Processing 2.1 in 2013


int psel, sel;
float W, zoom, rotX, rotY, tween;
float cx, cy, cz;
boolean translucent = false;
boolean edges = true;

void setup() {
  size(500, 500, P3D);
  W = width / 2;
  textFont(createFont("", max(12, W / 15)));
  zoom = W / 10;
  tween = 1;
}

void draw() {
  background(255);
  
  
  // interpolate between shapes
  tween = min(tween + .02, 1);  
      
  pushMatrix();
  // calculate the center of the snake  
  snake(false);
  
  // move the camera to the center
  beginCamera();
    camera();
    // Processing 1.5.1
    // translate(cx, cy, cz); 
    // Processing 2.1
    translate(-cx, -cy, -cz); 
  endCamera();
  lights(); 
    
  // draw the snake
  snake(true);
  popMatrix();
  
  // draw the label
  fill(0, abs(.5 - tween) * 255); 
  text(shapes[tween < .5 ? psel : sel][0], 10, 30);
  
}


void snake(boolean drawIt) {
  cx = cz = cy = 0;
  translate(W, W, W); 
  rotateX(rotX); 
  rotateY(rotY); 
  scale(zoom);
  for(int i = 0; i < P; i++) {
    translate(-.5, 0,-.5); 
    if(drawIt) {
      prism(i); 
    } else { 
      cx += (modelX(0, 0, 0) - W) / P; 
      cy += (modelY(0, 0, 0) - W) / P; 
      cz += (modelZ(0, 0, 0) - W) / P;
    }
    translate(0, .5, .5);
    rotateZ(HALF_PI); 
    float a0 = code.indexOf(shapes[psel][1].charAt(i));
    float a1 = code.indexOf(shapes[sel][1].charAt(i));
    rotateY(PI + lerp(a0, a1, tween) * HALF_PI);
  }
}


void prism(int n) {
  color[] c= { #ff9999, #9999ff };
  int[][] v = {
    {0, 0, 0}, {1, 0, 0}, {0, 1, 0},
    {0, 0, 1}, {1, 0, 1}, {0, 1, 1}
  };
  int[][][] f = {
    {v[0], v[1], v[2]}, 
    {v[3], v[4], v[5]}, 
    {v[0], v[1], v[4], v[3]}, 
    {v[0], v[2], v[5], v[3]}, 
    {v[1], v[2], v[5], v[4]}
  };
  fill(c[n%2], translucent ? 50 : 255); 

  strokeWeight(edges ? 2.0 / zoom : 0);
 
  for(int i=0; i<f.length; i++) {  
    beginShape(); 
    for(int j=0; j<f[i].length; j++) 
      vertex(f[i][j][0], f[i][j][1], f[i][j][2]);  
    endShape(); 
  }
}


void switchShape(int n) {
  if (tween < 1) return;
  psel = sel; 
  sel = (sel + n + shapes.length ) % shapes.length;
  tween=0;
}


void mouseDragged() {
  if (mouseButton == LEFT) {
    rotY += TWO_PI * (mouseX - pmouseX) / width;
    rotX -= TWO_PI * (mouseY - pmouseY) / height;
  } else {
    zoom = constrain(zoom - .1  * (mouseY - pmouseY), 1, W / 7.5);
  }
}


void keyPressed() {
  switch(key) { 
    case 'e': edges = !edges; break;
    case 't': translucent = !translucent; break; 
    case ' ': switchShape(1 + (int) random(shapes.length - 1)); break;
  }
  switch(keyCode) {
    case RIGHT: switchShape(+1); break;
    case LEFT: switchShape(-1); break; 
  }
}

