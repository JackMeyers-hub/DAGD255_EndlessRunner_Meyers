class SceneTitle {
  SceneTitle() {
  }
  void update() {

    if (Mouse.onDown(Mouse.LEFT)) {
      switchToPlay();
      scenePlay.platformDropCD = 10;
    }
  }
  void draw() {
    background(0);
    fill(255);
    textSize(45);
    textAlign(CENTER, CENTER);
    text("Spring Jump", width/2, height/2 - 50);
    textSize(40);
    text("Left Click to play!", width/2, height/2);
    textSize(25);
    text("The floor disapears after 10 seconds.", width/2, height/2 + 100);
    text("Mouse to move", width/2, height/2 + 130);
    text("Right Click to bounce off enemies", width/2, height/2 + 160);
    text("Pink powerups are extra lifes against enemies.", width/2, height/2 + 190);
    text("Blue powerups are a boost upwards", width/2, height/2 + 220);
    
  }
  void mousePressed() {
  }
}
