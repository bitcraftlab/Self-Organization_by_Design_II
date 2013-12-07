
// a simple interface, so we can easily switch between 
// different videosources ...

import processing.core.*;

interface VideoSource {
  
   public PImage get(); // get the next frame 
   
   public void loop();  // load the video 
   public void stop();  // eject the video
 
   public void play();  // play the video
   public void pause(); // pause the video
   
   public boolean isPlaying();  

}


