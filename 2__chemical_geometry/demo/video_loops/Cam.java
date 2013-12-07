
/*

// Camera Input for Processing 1.5

import processing.video.*;
import processing.core.*;

public class Cam extends PausePlay implements VideoSource {

  Capture cam;
    
  public Cam(PApplet app) {
    cam = new Capture(app, 640, 480); // get default camera
  }
  
  public Cam(PApplet app, int width, int height) {  
    cam = new Capture(app, width, height);  // try to get cam of specified size
  }
  
  public PImage get() {
    if (playing && cam.available() == true) {
      cam.read();
    }
    if (cam.width > 0 && cam.height > 0) {
      return cam;
    }
    return null;
  }
  
  public void loop() {} 
  public void stop() { cam.stop(); }
  
}
*/


// Camera Input for Processing 2.0

import processing.core.*;
import processing.video.*;

public class Cam extends PausePlay implements VideoSource {

  Capture cam;
  
  public Cam(PApplet app) {

    // get the first cam on the list
    String[] cameras = Capture.list();
    
    if (cameras.length == 0) {
      app.println("There are no cameras available for capture.");
      app.exit();
    } else {
      app.println(cameras[0]);
      cam = new Capture(app, cameras[0]);   
    }
    
  }
  
  
  public Cam(PApplet app, int width, int height) {
    
    // try to get cam of specified size
    cam = new Capture(app, width, height);     
  }
  
  public PImage get() {
    if (playing && cam.available() == true) {
      cam.read();
    }
    if (cam.width > 0 && cam.height > 0) {
      return cam;
    }
    return null;
  }
  
    
  public void loop() { cam.start(); } 
  public void stop() { cam.stop(); }
  
}


  
  



  
  
