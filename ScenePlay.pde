class ScenePlay extends AABB {
  float dt, prevTime = 0;
  int distanceScore = 0;

  final float GRAVITY = 1000;
  boolean hasStarted = false;
  Player player;
  ArrayList<Platform> platforms = new ArrayList();
  ArrayList<FoolPlatform> Foolplatforms = new ArrayList();
  ArrayList<Particle> particles = new ArrayList();
  ArrayList<PowerUp01> powerup01s = new ArrayList();
  ArrayList<PowerUp02> powerup02s = new ArrayList();
  ArrayList<Enemy> enemies = new ArrayList();

  SceneTitle sceneTitle;
  SceneGameOver sceneGameOver;
int kills = 0;
  float gameTime = 0;
  int gTime = 0;
  int extraLife = 0;
  float platformSpawnCD = 2;
  float enemySpawnCD = 2.5;
  float powerUpSpawnCD = 5;
  float powerUpSpawnCD2 = 5;
  float platformDropCD = 10;
  //float gameTime = 0;
  //int gTime = 0;
  float foolPlatformSpawnCD = random(4, 8);
  ScenePlay() {
    platformDropCD = 10;
    player = new Player();
    extraLife = 0;
  }

  void draw() {
    calcDeltaTime();
    background(#898989);

    gameTime += dt;
    gTime = floor(gameTime);
    println("x" , player.position.x);
        println("y" , player.position.y);
    // SPAWN ALL UNDER THIS LINE

    platformDropCD -= dt;


    platformSpawnCD -= dt;
    platformSpawnCD -= dt;
    if (platformSpawnCD <= 0) {    //randomize platform sizes and position before spawning
      float xPos = random(width);
      float yPos = -50;
      float pWidth = random(100, 200);
      float pHeight = 20;
      Platform p = new Platform(xPos, yPos, pWidth, pHeight);
      platforms.add(p);

      platformSpawnCD = random(2, 3.5);
    }

    //beginning platforms
    
    // platforms move y+ 100 therefore move 200 - 350 pixles based on random SpawnCD
    if(hasStarted == false){
    hasStarted = true;
          float pWidth = random(100, 200);
      float pHeight = 20;
     
     
     
     // bottom most platform
     Platform p = new Platform(262, 847, pWidth, pHeight);
     platforms.add(p);
    
    
    }



    foolPlatformSpawnCD -= dt;
    if (foolPlatformSpawnCD <= 0) {    //randomize platform sizes and position before spawning
      float xPos = random(width);
      float yPos = -50;
      float pWidth = random(100, 200);
      float pHeight = 20;
      FoolPlatform q = new FoolPlatform(xPos, yPos, pWidth, pHeight);
      Foolplatforms.add(q);

      foolPlatformSpawnCD = random(4, 8);
    }





    enemySpawnCD -= dt;

    if (enemySpawnCD <= 0) {

      float i = random(0, 1);
      if (i <= 0.50) {
        Enemy e = new Enemy(width - 100);
        enemies.add(e);
      } else if (i >= 0.49) {
        Enemy e = new Enemy(100);
        enemies.add(e);
      }

      enemySpawnCD = random(2, 5);
    }
    powerUpSpawnCD -= dt;
    if (powerUpSpawnCD <= 0) {    //randomize platform sizes and position before spawning
      float xPos = random(width);
      float yPos = -50;
      float pWidth = 25;
      float pHeight = 25;
      PowerUp01 l = new PowerUp01(xPos, yPos, pWidth, pHeight);
      powerup01s.add(l);

      powerUpSpawnCD = random(10, 20);
    }

    powerUpSpawnCD2 -= dt;
    if (powerUpSpawnCD2 <= 0) {    //randomize platform sizes and position before spawning
      float xPos = random(width);
      float yPos = -50;
      float pWidth = 25;
      float pHeight = 25;
      PowerUp02 l = new PowerUp02(xPos, yPos, pWidth, pHeight);
      powerup02s.add(l);

      powerUpSpawnCD2 = random(5, 10);
    }


    // UPDATE ALL UNDER THIS LINE


    if (player.position.y > height + 20 ) {
      switchToGameOver();
    }



    for (int i = 0; i < platforms.size(); i++) {
      Platform p = platforms.get(i);
      p.update();

      // COLLISION WITH PLATFORM
      if (p.checkCollision(player)) {
        player.isGrounded = true;
        player.fixOverlap(p);

        player.velocity.x = p.velocity.x;
        player.friction = 1;
      }
      if (p.isDead) platforms.remove(p);
    }


    for (int i = 0; i < Foolplatforms.size(); i++) {
      FoolPlatform q = Foolplatforms.get(i);
      q.update();

      // COLLISION WITH PLATFORM
      if (q.checkCollision(player)) {
        q.isDead = true;
      }
      if (q.isDead) Foolplatforms.remove(q);
    }



    for (int i = 0; i < particles.size(); i++) {
      Particle p = particles.get(i);
      p.update();

      if (p.isDead) particles.remove(p);
    }

    for (int i = 0; i < powerup01s.size(); i++) {
      PowerUp01 p = powerup01s.get(i);
      p.update();
      if (p.checkCollision(player)) {
        extraLife ++;
        p.isDead = true;
      }

      if (p.isDead) powerup01s.remove(p);
    }

    for (int i = 0; i < powerup02s.size(); i++) {
      PowerUp02 p = powerup02s.get(i);
      p.update();

      if (p.checkCollision(player)) {
        player.velocity.y = -400;
        p.isDead = true;
      }

      if (p.isDead) powerup02s.remove(p);
    }


    for (int i =0; i < enemies.size(); i++) {
      Enemy e = enemies.get(i);
      e.update();

      if (e.checkCollision(player)) {
        if (extraLife > 0) {
          e.isDead = true;
          extraLife--;
          kills ++;
        } else if (extraLife <= 0) {
          switchToGameOver();
          e.isDead = true;
        }
      }

      if (e.isDead) {
        enemies.remove(e);
      }
    }

    player.update();
    Keyboard.update();
    Mouse.update();

    fill(#CB02EA);
    rect(0, height-100, width, 150);





    player.draw();

    for (int i = 0; i < platforms.size(); i++) {
      Platform p = platforms.get(i);
      p.draw();
    }

    for (int i = 0; i < Foolplatforms.size(); i++) {
      FoolPlatform q = Foolplatforms.get(i);
      q.draw();
    }


    for (int i =0; i < enemies.size(); i++) {
      Enemy e = enemies.get(i);
      e.draw();
    }

    for (int i =0; i < powerup01s.size(); i++) {
      PowerUp01 l = powerup01s.get(i);
      l.draw();
    }

    for (int i =0; i < powerup02s.size(); i++) {
      PowerUp02 d = powerup02s.get(i);
      d.draw();
    }
    pushMatrix();
    fill(#030000);
    textSize(30);
    text("Extra Life's - " + extraLife, width - 100, 20);
    popMatrix();
        pushMatrix();
    fill(#030000);
    textSize(30);
    text("Kills - " + kills, width - 100, 50);
    popMatrix();
    // PREP FOR NEXT FRAME
  }

  void calcDeltaTime() {
    float currTime = millis();
    dt = (currTime - prevTime) / 1000.0;
    prevTime = currTime;
  }
}
