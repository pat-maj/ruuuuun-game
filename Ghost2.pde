public class Ghost2 extends Enemy implements Movable {
  
  
  PVector pos = new PVector(x, y);
  PVector goal = new PVector(goalX, goalY);
  
  Ghost2(int x, int y){
    super(x,y); 
    speed = 2;
  }
  
  Ghost2(int x, int y, float speed){
    super(x,y);
    this.speed = speed;
  }
  

  void move(){
    PVector dir = PVector.sub(goal, pos);
    dir.normalize();
    float sinOffset = sin(frameCount / 20.0) * 1.6;  
    dir.y += sinOffset;
    dir.mult(speed);
    pos.add(dir);
    
    
    x = (int) pos.x;
    y = (int) pos.y;
  }
  
  void render(){
    super.render();
    image(imgsGhost2[imgCounter/10 % imgsGhost2.length], x, y);
  }
}
