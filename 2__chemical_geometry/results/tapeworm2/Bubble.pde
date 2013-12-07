final float BUBBLE_SPEED = .3;
final float BUBBLE_RADIUS = 10;
final float BUBBLE_COLLISION_FACTOR = 0.6;
final float WALL_COLLISION_RADIUS = 50;

class Bubble {
  
  float px = 0, py = 0;
  float vx = 0, vy = 0;
  float r = BUBBLE_RADIUS;
  
  Worm parent;
  
  Bubble(float px, float py) {
    this.px = px;
    this.py = py;
  }
  
  void processCollisions(ArrayList<Bubble> bubbles) {
      for(Bubble b: bubbles) {
        if(b != this) {
          float dx = b.px - this.px;
          float dy = b.py - this.py;
          float d = dx*dx + dy*dy;
          float rr = r + b.r;
          rr *= BUBBLE_COLLISION_FACTOR;
          if(d <= rr*rr && d > 0) {
              d = sqrt(d);         
              float t = (rr-d) / rr;     
              px -=  t * dx;
              py -=  t * dy;
              b.px += t * dx;
              b.py += t * dy;
          }
          
          float wx = width - WALL_COLLISION_RADIUS;
          float wy = height - WALL_COLLISION_RADIUS;
          float lx = WALL_COLLISION_RADIUS, ly = WALL_COLLISION_RADIUS;
          
          
          
          
          
        }
      }
      float dx = width/2 - px;
      float dy = height/2 - py;
          
      float d = dx*dx + dy*dy;
      d = sqrt(d);
      
      
      px += dx * 0.0003;
      py += dy * 0.0003;
  }
  
  void update(ArrayList<Bubble> bubbles) {
    
  }
  
  void draw (int c) {
      noStroke();
      fill(c);
      ellipse(px, py, BUBBLE_RADIUS, BUBBLE_RADIUS);
  }
  
  void follow(Bubble b) {
      float dx = b.px - this.px;
      float dy = b.py - this.py;
      float d = dx*dx + dy*dy;
      if(d > 0) {
        d = sqrt(d);
        px += BUBBLE_SPEED * dx / d;
        py += BUBBLE_SPEED * dy / d;  
      }
  }
}
