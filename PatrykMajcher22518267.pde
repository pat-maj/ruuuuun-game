private GameMode gameMode = GameMode.MENU; // Start the game in the MENU
private String[] fileInput; 
private int score = 0;
private int highestScore;
private int lives;
private final int level1 = 20; // Value that determinates when the level 1 finish
private final int level2 = level1 + 20; // // Value that determinates when the level 2 finish
private ArrayList<Entity> entities = new ArrayList<>();
private ArrayList<Explosion> explosions = new ArrayList<>();
public PImage crosshair;
public PImage[] imgsExplosion = new PImage[9];
public PImage[] imgsGhost = new PImage[6];
public PImage[] imgsGhost2 = new PImage[10];
public PImage[] imgsPlayer = new PImage[20];
private final int IMGSIZE = 100; //Sets the general image size

void setup(){
  size(1100,700); // Sets size of the canvas
   
  loadImages();
  loadHighestScore();
  initialiseObjects();
}  
  
void draw(){
  //Displays different things based on the game mode (menu, levels, or game over screen)
  switch(gameMode){
    
    // Displays main menu, and instruction on how to start the game
    case MENU:
       background(0);
       textSize(90);
       text("RUUUUUN!", 330,100);
       textSize(70);
       text("Press your mouse to continue", 80, 350);
       if(mousePressed) gameMode = GameMode.LEVEL1;  // Click mouse to go to level 1
      break;
        
    // Level1, only one type of enemies  
    case LEVEL1:
       
       loadLevelSettings();    
       
       if(entities.size() <= 1) addEnemies((int)random(2,4),0);
      
       // If player scored enough points go to level 2, and remove enemies
       if(score >= level1) {
          removeEnemies();
          gameMode = GameMode.LEVEL2;
       }
      break;
        
    case LEVEL2:
    
       loadLevelSettings();
          
       if(entities.size() <= 1) addEnemies((int)random(3,6), 2,  (int)random(2,4), 4);
        
       if(score >= level2) {
          removeEnemies();
          gameMode = GameMode.LEVEL3;
       }
     break;
        
    case LEVEL3:
       
       loadLevelSettings();
          
       if(entities.size() <= 1) addEnemies((int)random(2,3), 3,  (int)random(3,5), 6);
        
     break;
        
    // Game Over screen     
    case GAMEOVER:
       background(0);
        
       // Checks if player beated his previous highest score (if so overwrite it)
       if(score>highestScore){
          highestScore = score;
          fileInput[0] = str(score);
          saveStrings("data/score.txt", fileInput);
       }
      
       // Displays information about the scores
       textSize(120);
       text("GAME  OVER", 250, 200);
       textSize(50);
       text("Your score: " + score + "\nHighest score: " + highestScore, 350, 350);
     break;
  }
}

// Initialise all starting objects (the goal, 5 ghosts)
private void initialiseObjects(){
   entities.add( new Goal() );
   for(int i=0; i<5; i++){
       entities.add( new Ghost2((int)random(-100, width+100), (int)random(-100, -300)) );
   }
}

// Load all images that will be displayed
private void loadImages(){
   crosshair = loadImage("crosshair.png");
   for(int i=0, n=imgsExplosion.length; i<n ; i++){
       imgsExplosion[i] = loadImage("collision_" + (i+1) + ".png");
   }
   for(int i=0, n=imgsGhost.length; i<n; i++){
       imgsGhost[i] = loadImage("ghost_" + i + ".png");
       imgsGhost[i].resize(IMGSIZE/2, IMGSIZE/2);
   }
   for(int i=0, n=imgsGhost2.length; i<n ; i++){
       imgsGhost2[i] = loadImage("ghost2_" + (i+1) + ".png");
       imgsGhost2[i].resize(IMGSIZE, IMGSIZE);
   }
   for(int i=0, n=imgsPlayer.length; i<n ; i++){
       imgsPlayer[i] = loadImage("PlayerRun_" + (i+1) + ".png");
       imgsPlayer[i].resize(IMGSIZE, IMGSIZE);
   }
}

// Add enemies based on the numbers passed in
private void addEnemies(int numOfGhost2, int numOfGhost){
   for(int i=0; i<numOfGhost2; i++){
       entities.add( new Ghost2((int)random(-100, width+100), (int)random(-100, -300)) );
   }
   for(int i=0; i<numOfGhost; i++){
       entities.add( new Ghost((int)random(-100, width+100), (int)random(-100, -300)) );
   }
}

// Add enemies based on 4 values passed in (number of ghosts2, speed of ghosts2, number of ghosts, speed of ghosts) 
private void addEnemies(int numOfGhost2, float speedGhost2, int numOfGhost, float speedGhost){
   for(int i=0; i<numOfGhost2; i++){
       entities.add( new Ghost2((int)random(-100, width+100), (int)random(-100, -300), speedGhost2) );
   }
   for(int i=0; i<numOfGhost; i++){
       entities.add( new Ghost((int)random(-20, width+20), (int)random(-10, -20), speedGhost) );
   }
}

// Loads the highest score
private void loadHighestScore(){
   fileInput = loadStrings("data/score.txt");
   highestScore = Integer.parseInt(fileInput[0]);
}


// Checks if Player or Shoot (Collidable) collide with the enemy 
// If so remove the enemy and the shoot as well as add 1 to the score
private boolean checkForCollision( Collidable collidableObject ){    
   for(int j = entities.size()-1; j>=0; j--){
     
        if(entities.get(j) instanceof Enemy){
          
          Entity enemies = entities.get(j);
          Enemy currentEnemy = (Enemy) enemies;
        
           if(collidableObject.collision(currentEnemy, IMGSIZE)){
               entities.remove(currentEnemy); 
            
               if(collidableObject instanceof Shoot) {
                   score++;
                   entities.remove((Entity)collidableObject);
                   return true;
               }
           break;  
        }
     }
  } 
  return false;
}

// Load crucial level settings
private void loadLevelSettings(){
   background(90);
   renderEntities();
   imageMode(CENTER);
   image(crosshair, mouseX, mouseY);
   textSize(20);
   text(gameMode + "      Lives: " + lives + "   Score: " + score, 100,20); // display the score and lives on the screen
   renderExplosion();
   checkForGameover(lives);
}

// Displays explosion
private void renderExplosion(){
   for(int i = explosions.size()-1; i>=0; i--){
        Explosion currentExplosion = explosions.get(i);
        currentExplosion.render();
        if(currentExplosion.removeExplosion()) explosions.remove(currentExplosion);
   }
}

// Renders all entities
private void renderEntities(){
   for(int i = entities.size()-1; i>=0; i--){
       Entity currentEntity = entities.get(i);
       
       if(currentEntity instanceof Goal){
           Goal player = (Goal) currentEntity;
           lives = player.getGoalLives();
       }
          
       // Checks whether shoot or player collided with an enemy  
       if(currentEntity instanceof Collidable) {
           if(checkForCollision((Collidable)currentEntity)) i--; 
       }
         
       // Remove unecessary shoot from the arraylist
       if(currentEntity instanceof Shoot){
           entities.remove(currentEntity);
       }
           
       currentEntity.update(); 
   } 
}

// Checks whether the player lost all lives
private void checkForGameover(int lives){
  if(lives <= 0) gameMode = GameMode.GAMEOVER;
}

// Removes all entities expect the goal
private void removeEnemies(){
   for(int i = entities.size()-1; i>=1; i--){
       entities.remove(i);
   }
}

// Allow user to shoot as well as display explosion animation
public void mousePressed(){
   entities.add( new Shoot(mouseX, mouseY) ); 
   explosions.add( new Explosion(mouseX, mouseY) ); 
}
