abstract class Entity {
  
  protected int x;
  protected int y;
  protected int imgCounter = 0;
 
  abstract protected void render();
 
  void update(){
    render(); 
  }
}
