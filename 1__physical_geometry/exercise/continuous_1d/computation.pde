
// reaction diffusion magic ...

void reaction_diffusion(int c, int x) {

  float rate = diffusionRate[c];
   
  // influx from left and right cells
  int left = constrain(x - 1, 0, width-1);
  int right = constrain(x + 1, 0, width-1);
  
  // influx depending on the diffusion rate
  float diffusion  = (ca[c][MEMORY][left] + ca[c][MEMORY][x] + ca[c][MEMORY][right]) / 3.0;
  float cnew = ca[c][MEMORY][x] * (1-rate) +  diffusion * rate;
  
  // reaction depending on concentration and reaction rate of the other chemical
  for(int i = 0; i < chemicals; i++) {
    cnew += reactionRate[c][i] * (ca[i][MEMORY][x] - cmax/2);
  }
  
  // limit the concentration
  ca[c][CELLS][x] = constrain(cnew, 0, cmax);

}

// flipping buffers
void pushMemory() {
  CELLS = 1 - CELLS;
  MEMORY = 1 - MEMORY;
}

