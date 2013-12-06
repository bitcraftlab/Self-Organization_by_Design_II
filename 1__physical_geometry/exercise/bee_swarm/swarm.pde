
class Swarm extends ArrayList<Bee> {
  
  void addBees(int n) {
    for(int i = 0; i < n; i++) {
      add(new Bee(random(width), random(height)));
    }
  }
  
  void step() {
    
    ArrayList<Bee> others;
    
    for(Bee b : this) {
      b.interact();  
      b.move();
    }
  }  
  
  void draw() {
    for(Bee b: this) b.draw(); 
  }
}
