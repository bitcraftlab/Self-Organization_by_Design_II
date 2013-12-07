class Worm {
  
  ArrayList<Bubble> bubbles;
  
  Worm () {
    bubbles = new ArrayList<Bubble>();
  }
  
  void update(ArrayList<Bubble> allBubbles) {
    int s = bubbles.size();
    for(int i=0; i<s; i++) {
        if(i<s-1)
        bubbles.get(i).follow(bubbles.get((i+1)%s));
        bubbles.get(i).processCollisions(allBubbles);
        
        int c = color(180 / bubbles.size() * i, 100, 200);
        bubbles.get(i).draw(c);
    }
    
    
  }
  
  void addBubble(Bubble b) {
    bubbles.add(b);
  }
  
  void followBubble(Bubble b) {
    if(bubbles.size() > 0) {
      bubbles.get(0).follow(b); 
    }  
  }
  
  void catchFreeBubbles(ArrayList<Bubble> freeBubbles) {
    Bubble closestForeign = null;
    Bubble closestSelf = null;
    float dMin = 999999;
    for(Bubble b: freeBubbles) {
        for(Bubble a: bubbles) {
            float dx = b.px - a.px;
            float dy = b.py - a. py;
            if(dx*dx + dy*dy < dMin) {
              closestSelf = a;
              closestForeign = b;
              dMin = dx*dx + dy*dy;
            }
        }
    }
    if(closestSelf != null) {
      bubbles.get(bubbles.size()-1).follow(closestForeign);
      float dx = closestSelf.px - closestForeign.px;
      float dy = closestSelf.py - closestForeign.py;
      if(dx*dx+dy*dy <= 1.5*(closestSelf.r+closestForeign.r)*(closestSelf.r+closestForeign.r)) {
        freeBubbles.remove(closestForeign);
        bubbles.add(closestForeign);
      }  
    }
  }
}
