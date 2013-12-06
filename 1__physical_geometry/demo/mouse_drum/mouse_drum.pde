/* OpenProcessing Tweak of *@*http://www.openprocessing.org/sketch/62120*@* */
/* !do not delete the line above, required for linking your tweak if you re-upload */

// 2012 - original sketch by Asher Salomon
// 2013 - larger drum and mouse interaction by Martin Schneider @bitcraftlab
// requires the minim library

import ddf.minim.*;
import ddf.minim.signals.*;

Minim minim;
AudioOutput out;
Drum drum;
int drumSize = 20;

float[][] img; // image

void setup(){
  
  size(400, 400);  
  minim = new Minim(this);
  out = minim.getLineOut(Minim.MONO);
  drum = new Drum(drumSize);
  out.addSignal(drum);
  img = new float[drumSize][drumSize];
  
}
void draw(){
  
  drum.copyAmps(img);
  PImage drw = createImage(drumSize,drumSize,RGB);
  
  for(int i=0;i<drumSize;i++){
    for(int j=0;j<drumSize;j++){
      drw.set(i,j,color(img[i][j]*128+128));
    }
  }
  
  image(drw,0,0,width,height);
  
}

void mousePressed() {
  int x = floor(map(mouseX, 0, width, 1, drumSize-1.001));
  int y = floor(map(mouseY, 0, height, 1, drumSize-1.001));
  drum.bang(x, y); 
}

// you must close minim resources on exit
void stop(){
  out.close();
  minim.stop();
  super.stop();
}
