// This game will be a jumping endless runner
// Copyright Jack Meyers 2024.


//save sudo code
// save distance and kills as a score
// convert int variables to strings
// saveString() both strings in array not array list

float dt, prevTime = 0;
int distanceScore = 0;

final float GRAVITY = 1000;

SceneTitle sceneTitle;
ScenePlay scenePlay;
SceneGameOver sceneGameOver;

float platformSpawnCD = 2;
float enemySpawnCD = 2.5;

void setup() {
  switchToTitle();
  size(540, 960);
  noStroke();
}

void draw() {
  calcDeltaTime();
  background(#898989);

  if (sceneTitle != null) {
    sceneTitle.update();
    if (sceneTitle != null) sceneTitle.draw(); // this extra if statement exists because the sceneTitle.update() might result in the scene switching...
  } else if (scenePlay != null) {

    if (scenePlay != null) scenePlay.draw(); // this extra if statement exists because the scenePlay.update() might result in the scene switching...
  } else if (sceneGameOver != null) {
    sceneGameOver.update();
    if (sceneGameOver != null) sceneGameOver.draw(); // this extra if statement exists because the sceneGameOver.update() might result in the scene switching...
  }

  // SPAWN ALL UNDER THIS LINE

  // UPDATE ALL UNDER THIS LINE

  //DRAW ALL UNDER THIS LINE
}

void keyPressed() {
  println(keyCode);
  Keyboard.handleKeyDown(keyCode);
}

void keyReleased() {
  Keyboard.handleKeyUp(keyCode);
}

void mousePressed() {
  if (mouseButton == LEFT) Mouse.handleKeyDown(Mouse.LEFT);
  if (mouseButton == RIGHT) Mouse.handleKeyDown(Mouse.RIGHT);
  if (mouseButton == CENTER) Mouse.handleKeyDown(Mouse.CENTER);
}

void mouseReleased() {
  if (mouseButton == LEFT) Mouse.handleKeyUp(Mouse.LEFT);
  if (mouseButton == RIGHT) Mouse.handleKeyUp(Mouse.RIGHT);
  if (mouseButton == CENTER) Mouse.handleKeyUp(Mouse.CENTER);
}

boolean checkCollisionSwordEnemy(Sword a, Enemy b) {
  float dx = b.position.x - a.x;
  float dy = b.position.y - (a.y + 50);
  float dis = sqrt(dx * dx + dy * dy);
  if (dis <= a.radius + b.radius) return true;
  return false;
}


void calcDeltaTime() {
  float currTime = millis();
  dt = (currTime - prevTime) / 1000.0;
  prevTime = currTime;
}

void switchToTitle() {
  sceneTitle = new SceneTitle();
  scenePlay = null;
  sceneGameOver = null;
}

void switchToPlay() {
  scenePlay = new ScenePlay();
  sceneTitle = null;
  sceneGameOver = null;
}

void switchToGameOver() {
  sceneGameOver = new SceneGameOver();
  scenePlay = null;
  sceneTitle = null;
}
