// Self-Organization by Design
// Tapeworm  Exercise
// Jonas Köhler 2013

ArrayList<Bubble> bubbles = new ArrayList<Bubble>();
ArrayList<Worm> worms = new ArrayList<Worm>();
ArrayList<Bubble> freeBubbles = new ArrayList<Bubble>();


int wormcount = 3;
int startBubbles = 1;
int freeBubblesCount = 0;

void setup() {
  
  colorMode(HSB);
  
  size( 600, 600);
  for(int j=0; j<wormcount; j++) {
    Worm worm = new Worm();
    worms.add(worm);
    for(int i=0; i<startBubbles; i++) {
      float x = random(20) + width / wormcount * (j+0.5);
      float y = height / startBubbles * (i+0.5);
      Bubble b = new Bubble(x,y);
      bubbles.add(b);
       worm.addBubble(b);  
    }
  }
  

  
}

void mousePressed()
{
  Bubble b = new Bubble(mouseX,mouseY);
    freeBubbles.add(b);
    bubbles.add(b);
}


void draw() {
  background(0);
  for(int i=0; i<20; i++) {
    for(Worm worm: worms){
      worm.update(bubbles);
      worm.catchFreeBubbles(freeBubbles);
    }
    for(Bubble b: freeBubbles) {
      b.draw(color(255));
    }
  }
  
  
  

}
