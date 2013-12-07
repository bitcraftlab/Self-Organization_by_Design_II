
// This sketch shows how to use a uniform videosource interface
// to access webcams, image sequences, animated gifs etc ...

import processing.video.*;

VideoSource[] source;
VideoSource video;
int channel;

boolean blackMode = true; // background color
int scaleMode = 0;

void setup() {
  
  size(1000, 580);
  frameRate(25);
  
  // load a couple of video sources
  source = new VideoSource[] { 
    new Cam(this),                         // camera input
    new AnimatedGif(this, "animated.gif"),    // animated gif input
    new ImageLoop(this, "loop_%05d.gif", 20), // image loop input ( loop_00001.gif ... loop_00019.gif )
    new OggVideo(this, "BugsShort.ogg")       // ogg theora video input
  };
  
  // run all video loops in parallel
  for(int i=0; i< source.length; i++) {
    source[i].loop();
    source[i].play();
  }
  
  // pick the first video for display
  video = source[0];
  
}


void draw() {

  // get the next frame
  PImage img = video.get();

  // display the frame using the selected scale mode
  background(blackMode ? 0 : 255);
  if (img != null) {
    autoScale(img, width, height, scaleMode);
  }
  
}


void keyPressed() {
  
  switch(key) {
    case ' ': channel++; break;
    case 's': scaleMode = (scaleMode + 1) % 4; return;
    case 'b': blackMode = !blackMode; return;
    case 'p': if(video.isPlaying()) video.pause();else video.play(); return;
  }
  
  // use number keys to switch between channels
  if(key >= '1' && key <= '9' ) {
    channel = (key - '1');
  }
  
  channel = channel % source.length;
  video = source[channel];
  
}






