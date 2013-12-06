

class Bee {
  
  
  float angle;
  PVector p, v, a;
  PVector force = new PVector();
  float r = 3;
  
  float vmax = 3;
  float fmax = 0.01;
  
  Bee(float x, float y) {
    p = new PVector(x, y);
    float ang =  0; //random(TWO_PI);
    v = new PVector(cos(ang), sin(ang));
    a = new PVector();
  }
  
  void interact() {
    
      ArrayList<Bee> others;
      PVector a = new PVector(0, 0);
     
      cohesion( space.getNeighbors(this, d_cohesion) );       // bee cohesion
      separation( space.getNeighbors(this, d_separation) );   // bee separation
      alignment( space.getNeighbors (this, d_alignment ) );  // bee alignment
    
      a.add(force);
      v.add(a);
      v.limit(vmax);
      p.add(v);
      
      // force.set(0, 0);
      bounce( space.walls );       

  }
  
  void move() {
    //p.add(v);
  }

  void draw() {
    
    strokeWeight(1);
    pushMatrix();
    pushStyle();
    
    // circle
    translate(p.x, p.y);
    stroke(0); ellipse(0, 0, 2*r, 2*r);
    
    // velocity
    stroke(0); line(0, 0, r * v.x , r * v.y);
    
    // force
    stroke(255, 0, 0); line(0, 0, r * force.x, r * force.y);
    
    popStyle();
    popMatrix();
  }
  
  // move towards to the center of the others
  void cohesion(ArrayList<Bee> others) {
    if(others.size() > 0) {
      PVector center = new PVector();
      for(Bee b : others) {
        center.add(b.p);
      }
      center.div(others.size());
      force.add( seek(center, f_cohesion));
    }
  };
  
  // move away from the center of others
  void separation(ArrayList<Bee> others) {
    if(others.size() > 0) {
      PVector center = new PVector();
      for(Bee b : others) {
        center.add(b.p);
      }
      center.div(others.size());
      PVector offcenter = PVector.sub(p, center);
      offcenter.setMag(d_separation * 2);
      offcenter.add(p);
      
      force.add(seek(offcenter, f_separation));
    }
  }
  
  
  // mix all velocities
  void alignment(ArrayList<Bee> others) {

    PVector vmix = new PVector();
    if(others.size() > 1){
      for(Bee b : others) {
        vmix.add(b.v);
      } 
      vmix.div(others.size()); 
      vmix.limit(vmax);
      PVector target = PVector.add(p, vmix);
      force.add(seek(target, f_alignment));
    }  
  };
  
  
  // bounce from walls
  void bounce(ArrayList<Wall> walls) {
    for(Wall wall: walls) {
      float d = wall.dist(p) - r;
      if(d < 0) {
        PVector n = wall.normal(p);
        n.normalize();
        p.sub(PVector.mult(n, d)); // move ball backwards so it does not intersect anymore
        v = wall.reflect(p, v);    // reflect the ball on the wall, or it's edges
        force.set(0, 0);
        //a = wall.reflect(p, a);
      }
    }
  };
  
  PVector seek(PVector target, float force) {
    PVector v2 = PVector.sub(target, p); 
    v2.normalize();
    v2.mult(vmax);
    PVector steer = PVector.sub(v2,v);
    steer.mult(force);
    steer.limit(fmax); 
    return steer;
  }
  
  /*
  // bounce from other bees
  void bounce(ArrayList<Bee> others) {
    for(Bee other: others) {
      float d = dist(this.p, other.p) - this.r - other.r;
    }
  }
  */

}
