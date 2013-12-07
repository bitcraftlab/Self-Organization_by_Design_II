
// Using the POGG library
// http://www.fotosdelpais.com/octavi/pogg/doku.php

import processing.core.*;
import pogg.*;

public class OggVideo extends PausePlay implements VideoSource {
  
  TheoraMovie video;
  
  public OggVideo(PApplet app, String url) {
    video = new TheoraMovie(app.online ? url : app.dataPath(url));
  }
  
  public PImage get() {
    if(playing) video.read();
    return video;
  }
  
  public void loop() { video.loop(); }
  public void stop()  { video.stop(); }

  
}
  
