
// simple abstract base class for players 
// with support for play/pause

abstract class PausePlay  {
  
  boolean playing;
  
  public void pause() { playing = false; }
  public void play()  { playing = true; }
  public boolean isPlaying() { return playing; }
  
}

