


// return an invisible dummy wall for the cursor
Wall dummyWall() {
  int d = -10; return new Wall(d,d,d,d);
}

class Wall {

  float x1, y1, x2, y2;
  
  Wall(float _x1, float _y1, float _x2, float _y2) {
    x1 = _x1;  y1 = _y1; x2 = _x2; y2 = _y2;
  }
  
  // Return the point of the line segment that is closest to p
  PVector nearest(PVector p) {

    // get points and vectors
    PVector p1 = new PVector(x1, y1), p2 = new PVector(x2, y2);
    PVector v1 = PVector.sub(p2, p1), v2 = PVector.sub(p, p1);

    // projection beyond the beginning of the line
    float c1 = v1.dot(v2);
    if (c1 <= 0) return p1;

    // projection beyond the end of the line
    float c2 = v1.dot(v1);
    if (c1 >= c2) return p2;

    // point projects onto the line
    PVector p0 = PVector.add(p1, PVector.mult(v1, c1 / c2));
    return p0;
  }
  
  // normal to the line
  // PVector normal() { return new PVector(y1 - y2, x2 - x1); }
  
  // normal to the segment
  PVector normal(PVector p) {
    return PVector.sub(p, nearest(p));
  }
  
  float dist(PVector p) {
    return p.dist(nearest(p)); 
  }
  
  PVector reflect(PVector p, PVector v) {
    PVector n = normal(p);
    float c1 = PVector.mult(v, 2).dot(n);
    float c2 = n.dot(n); 
    return PVector.sub(v, PVector.mult(n, c1 / c2 ));
  }

  void draw() {
    strokeWeight(2);
    line(x1, y1, x2, y2);
  }
}

