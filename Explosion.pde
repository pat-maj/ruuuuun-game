class Explosion extends Entity {
  
  private int frameCounter = 27;
  
  Explosion(int x, int y){
    super();
    this.x = x;
    this.y = y;
    render();
  }
  
  void render(){
    imageMode(CENTER);
    image(imgsExplosion[imgCounter/3 % imgsExplosion.length], x, y);
    imgCounter++;
    frameCounter--;
  }
  
  public boolean removeExplosion(){
    return frameCounter==0; 
  }
}
