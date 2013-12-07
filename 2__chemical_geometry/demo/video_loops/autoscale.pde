
// utility functions for auto-scaling an image to screen size

void autoScale(PImage img, float w, float h, int scaleMode) {
 
  float hi = img.height;
  float wi = img.width;
  
  switch(scaleMode) {
      case 0: scale(img, min(w/wi, h/hi)); break; // scale to fit
      case 1: scale(img, max(w/wi, h/hi)); break; // scale to crop
      case 2: scale(img, w/wi, h/hi); break; // stretch to fit
      case 3: scale(img, 1.0); break; // center image   
  }
      
}
      
void scale(PImage img, float s) {
   scale(img, s, s); 
}

void scale(PImage img, float sx, float sy) {
  pushMatrix();
  translate(width/2, height/2);
  scale(sx, sy);
  translate(-img.width/2, -img.height/2);
  image(img, 0, 0);
  popMatrix();
}

