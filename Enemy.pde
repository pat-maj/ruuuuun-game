public abstract class Enemy extends Entity implements Movable{
  
  protected float speed;
  protected int goalX;
  protected int goalY;
  Goal goal;
  
  Enemy(int x, int y){
    this.x = x;
    this.y = y;
    goal = new Goal();
    goalX = goal.getGoalX();
    goalY = goal.getGoalY();
  }
  
  @Override
  void update(){
    move();
    render();
  }
  
  @Override
  void render(){
    imageMode(CENTER);
    imgCounter++;
  }
}
