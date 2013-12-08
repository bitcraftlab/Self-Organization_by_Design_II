
class FloodFill extends Fill {
  
  Stack<int[]> trace = new Stack();

  int hasNext() {
    
    int[][] nbs = getNeighbors();
    
    // if we find a free pixel push it to the stack
    for (int i = 0; i < 4; i++) {
      int[] nb = nbs[i];
      if ( get(nb) == fg_color ) {
        trace.push(nb);
        return TRUE;
      }
    }
    
    // otherwise pop from the stack and try again (later)
    if(!trace.empty()) {
      pos = trace.pop();
      return MAYBE;
    }
    
    // give up
    return FALSE;
    
  }

  // move to the next pixel
  int[] getNext() {
    pos = trace.peek();
    return pos;
  }
  
  
  
}

