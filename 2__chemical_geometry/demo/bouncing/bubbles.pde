
class Bubble {
  
  float x, y, r;
  float fx, fy;
  float vx, vy;
  int c;
 
  Bubble(float _x, float _y, float _r, int _c) {
    x = _x;
    y = _y;
    r = _r;
    c = _c;
    vx = random(-2, 2); 
  }
  
  void attract() {
    
    for(Bubble b : bubbles)  {
      
      if(b==this) continue;
      
      // force decreasing quadratically with distance
      float dd = min(width / sq( dist(x, y, b.x, b.y) ), 2);
      
      // same colors attract
      float f = (c == b.c ? dd : -dd * repell);
      
      // circlular color attraction (!)
      //float f = c == b.c || c == (b.c + 1) % 4 || c == (b.c + 7) % 4 ? dd : -dd * repell;
      
      float dir = atan2(b.y-y, b.x-x);
      x += f * cos(dir);
      y += f * sin(dir);
    }
    
  }
  
 
  void gravity() {
    vy += .5; 
  }
  
 
  void move() {
    vx *= .99; vy *= .99; // friction
    x += vx; y += vy;     // motion
  }
  
  
  // wall collisions are bouncy (change of velocity)
  boolean collide() {
    
    boolean c = false;
  
    // bubble collisions
    for(Bubble b : bubbles)  {
      c |= collide(b);
    }
   
    // wall collisions
    if(x<r)  { x=r ; vx = -vx; c = true; }
    if(x>width-r) { x = width-r; vx = -vx; c = true; }
    if(y<r) { y = r; vy = -vy; c = true; }
    if(y>height-r) { y = height-r; vy = -vy; c = true; }

    return c;
    
  }
  
  // bubble collisions are not bouncy (change of position)
  boolean collide(Bubble a) {
    
     // no self collision
    if(a == this) return false; 

    float d = dist(x, y, a.x, a.y);
    float rr =  r + a.r;
    
    // correct bubble positions
    if (d<rr) {
      float t = (rr-d)/rr;
      float dx =  t * (x-a.x);
      float dy =  t * (y-a.y);
      x += dx; y += dy;
      a.x -= dx; a.y -= dy;

      return true;
    }
    return false;
  }
     
  void draw() {
    bubble(x, y, r, palette[c]);
  }
  
}

