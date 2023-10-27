public class Ghost extends Enemy implements Movable {

  // The current location of the enemy
  PVector pos = new PVector(x, y);

  // The current location of the goal
  PVector goal = new PVector(goalX, goalY);
  
  
  Ghost(int x, int y){
    super(x,y);
    speed = 4;
  }
  
  Ghost(int x, int y, float speed){
    super(x,y);
    this.speed = speed;
  }
  
  void move(){

    // Determine the vector from the enemy's present location to the goal location
    PVector dir = PVector.sub(goal, pos);

    // The direction vector should be normalised to have a magnitude of 1.
    dir.normalize();
    
    // To the direction vector, add a sinusoidal offset.
    float sinOffset = sin(frameCount / 20.0) * 1.6; 
    dir.x += sinOffset;

    // Adapt the direction vector's magnitude to the speed of the enemy.
    dir.mult(speed);

    // Update the location of the enemy by include the direction vector.
    pos.add(dir);
    
    
    x = (int) pos.x;
    y = (int) pos.y;
  }
  
  void render(){
    super.render();
    image(imgsGhost[imgCounter/10 % imgsGhost.length], x, y);
  }
}
