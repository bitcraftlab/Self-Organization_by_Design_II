
import processing.core.*;

public class ImageLoop extends PausePlay implements VideoSource {
  
  PImage[] anim;
  int frame;
  
  public ImageLoop(PApplet parent, String pattern, int n) {
    anim = new PImage[n];
    for(int i=0; i<n; i++) {
      anim[i] = parent.loadImage(String.format(pattern, i));
    }
  }
  
  public PImage get() {
    PImage img = anim[frame];
    if(playing) {
      frame = (frame + 1) % anim.length;
    }
    return img;
  }
  
  public void loop() {}
  public void stop() {}
  
}
  
