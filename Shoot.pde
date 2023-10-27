public class Shoot extends Entity implements Collidable{
  
  Shoot(int x, int y){
    this.x = x;
    this.y = y;
    render();
  }
  
  void render(){}
  
  boolean collision(Enemy enemy, int size){
    if(enemy instanceof Ghost) size = size/2;
    return abs(this.x-enemy.x) < size && abs(this.y - enemy.y) < size; 
  }
}
