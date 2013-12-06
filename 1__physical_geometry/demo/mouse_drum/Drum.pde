
class Drum implements AudioSignal{
  
  int n; // size of the drum
  int t;
  
  float[][] amp; // amplitude
  float[][] vel; // velocity
  float[][] imp; // impulse
  
  boolean bng = false; // drum bang
  float bngImp = 800; // bang impulse
  int bngX, bngY; // bang position
  
  float spr = 0.02; // spring rate
  float dam = 0.01; // damping
  

  Drum(int drumSize) {
    n = drumSize;
    amp = new float[n][n];
    vel = new float[n][n];
    imp = new float[n][n]; 
  }

  // hit the drum at a certain position
  void bang(int x, int y) {
    bng = true;
    bngX = x;
    bngY = y;
  }
    
  // get a copy of the amplitudes
  synchronized void copyAmps(float[][] a) {
    arraycopy(amp, a);
  }
  
  
  void generate(float[] samp){
    // You may not make changes in
    // the data outside of this routine.
    if(bng){
      bng=false;
      // use mouse positio
      // deliver a big impulse
      amp[bngX][bngY] = bngImp;
    }
    for(int i=0;i<samp.length;i++){
      // get an amplitude while updating the simulation
      // amp[bngX][bngY] = 100 * sin(t++ * 0.05);
      samp[i] = update();
    }
  }
  
  void generate(float[] left, float[] right){
    // this is a mono drum
    // this routine returns a zero signal
  }
    
  float update(){
    float val = 0;
    float del;// a place to store one number
    // find all X forces
    for(int i=0;i<n-1;i++){
      for(int j=0;j<n;j++){
        // determine the spring force
        del=spr*(amp[i+1][j]-amp[i][j]);
        // add the damping force
        del+=dam*(vel[i+1][j]-vel[i][j]);
        // deliver an equal and opposite impulse
        imp[i][j]+=del;
        imp[i+1][j]-=del;
      }
    }
    // find all Y forces
    for(int i=0;i<n;i++){
      for(int j=0;j<n-1;j++){
        del=spr*(amp[i][j+1]-amp[i][j]);
        del+=dam*(vel[i][j+1]-vel[i][j]);
        imp[i][j]+=del;
        imp[i][j+1]-=del;
      }
    }
    // update all nodes which are not on the drum rim
    for(int i=1;i<n-1;i++){
      for(int j=1;j<n-1;j++){
        // accelerate by an impulse
        vel[i][j]+=imp[i][j];
        // reset the impulse sum
        imp[i][j]=0;
        // translate by a velocity
        amp[i][j]+=vel[i][j];   
        // sum the amplitudes of the drum
        val+=amp[i][j];
      }
    }
    // normalize to an average amplitude
    val /= sq(n);
    // clip audio
    return constrain(val,-1,1);
  }

}
