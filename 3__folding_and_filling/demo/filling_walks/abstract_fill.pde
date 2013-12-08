
// this is an abstract class.
// implement the abstract methods in my_fill, to create your own filling algorithm

abstract class Fill {

  int[] pos = {-1, -1};
  
  // set the origin of the filling spree
  void setStart(int x, int y) {
    pos = new int[] { x, y };
  }

  // return all neighbor corrdinates of the current position
  int[][] getNeighbors() {
    int x = pos[0];
    int y = pos[1];
    int[][] nbs = new int[4][];
    nbs[0] = new int[] { x - 1, y };
    nbs[1] = new int[] { x, y - 1 };
    nbs[2] = new int[] { x + 1, y };
    nbs[3] = new int[] { x, y + 1 };
    return nbs;
  }
  
  // can we fill more pixels?  [ ]yes [ ]no [ ]maybe
  abstract int hasNext();
  
  // return position of the next filling point
  abstract int[] getNext();
  

}


