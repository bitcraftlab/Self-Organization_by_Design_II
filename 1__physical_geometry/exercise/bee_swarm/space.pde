

class Space {
  
  float d = 10;
  ArrayList<Wall> walls = new ArrayList();
  
  Space() {
    
    // corner points

    float x1 = d, y1 = d;
    float x2 = width - d, y2 = height - d;

    /*
    float x1 = random(width);
    float y1 = random(height);
    float x2 = random(width);
    float y2 = random(height);
    */
    
    // adding four walls, clock-wise
    walls.add(new Wall(x1, y1, x2, y1));
    walls.add(new Wall(x2, y1, x2, y2));
    walls.add(new Wall(x2, y2, x1, y2));
    walls.add(new Wall(x1, y2, x1, y1));
    
    // add some more random walls
    /*
    for(int i = 0; i < 10; i++) {
      int r = 100;
      float a = random(TWO_PI);
      float x = random(r, width - r);
      float y = random(r, height - r);
      float dx = r * sin(a), dy = r * cos(a);
      walls.add(new Wall(x - dx, y - dy, x + dx, y + dy));
    }
    */
    
  }
  
  // distance to the closest wall
  float dist(PVector v) {
    float dmin = width * 2;
    for(Wall w : walls) dmin = min(w.dist(v), dmin);
    return dmin;
  }
  
  // return neigbors from the swarm
  ArrayList<Bee> getNeighbors(Bee b, float r) {
    ArrayList<Bee> neighbors = new ArrayList();
    for(Bee other : swarm) {
      if(b != other && b.p.dist(other.p) < r) {
        neighbors.add(other);
      }
    }
    return neighbors;
  }
  
  
  
  void draw() {
    for(Wall w: walls) w.draw();
  }
  
}
