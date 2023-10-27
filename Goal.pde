public class Goal extends Entity implements Collidable{

  private int lives = 3; // Amount of player's lives
  
  Goal(){
    // Coordinates of where the goal is displayed
    this.x = width/2;
    this.y = height-100;
  }
  
  // Allows to access the goal lives
  public int getGoalLives(){ return lives; }
  
  // Allows to access the goal coordinates
  public int getGoalX(){ return x; }
  public int getGoalY(){ return y; }
  
  // Render the player
  protected void render(){
    imageMode(CENTER);
    image(imgsPlayer[imgCounter/2 % imgsPlayer.length], x,y);
    imgCounter++;
  }
  
  // Checks whether the player collided with an enemy
  boolean collision(Enemy enemy, int size){
    if(enemy instanceof Ghost) size = size/2;
    if(abs(this.x-enemy.x) < size && abs(this.y - enemy.y) < size){
      lives--;
      return true; 
    }
    return false;
  }
}
