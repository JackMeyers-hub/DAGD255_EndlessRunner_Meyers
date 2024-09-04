class Player extends AABB {

  float maxHealth = 100, currentHealth = maxHealth;
  boolean isGrounded = false;
  boolean isGroundPound = false;
  boolean isRumble = false;
  float rumbleTime = 0.3;
  float rumbleMultiplier = 4;
  int numJumps = 0;
  float easing = 5;
  float friction = 0.95;
  float radius = 25;
  float platformDropCD = 10;
  Sword sword = null;


  Player() {
    position = new PVector(width/2, 830);
    velocity = new PVector();
    setSize(25, 25); // THIS FUNCTION MUST BE CALLED FOR ALL AABB OBJECTS
    platformDropCD = 10;
  }

  void update() {

    calcAngleToMouse();

    if (isRumble) {
      rumbleTime -= dt;

      float randX = random(-1, 1) * rumbleMultiplier;
      float randY = random(-1, 1) * rumbleMultiplier;

      translate(randX, randY);

      if (rumbleTime <= 0) {
        translate(0, 0);
        isRumble = false;
        rumbleTime = 0.3;
      }
    }

    velocity.y += GRAVITY * dt;
    platformDropCD -= dt;

    if (!isGrounded) {

      if (Keyboard.onDown(Keyboard.DOWN)) {
        isGroundPound = true;
        velocity.y = 1500;
        velocity.x = 0;
      }
    }

    if (Mouse.onDown(Mouse.RIGHT)) {
      if (sword == null) {
        sword = new Sword(this);
      }
    }

    if (sword != null) {
      sword.update();
      if (sword.isDead) sword = null;
    }

    // FIGURE OUT DOUBLE JUMP
    //if (isGrounded == true) {
    //  numJumps = 0;
    //}

    //if (Keyboard.onDown(Keyboard.UP) && numJumps < 1) {
    //  numJumps ++;
    //  velocity.y = - 500;

    //  isGrounded = false;
    //}

    if (isGrounded == true) {
      velocity.y = -500;
      isGrounded = false;
    }


    float dx = mouseX - position.x;
    position.x += dx * easing * dt;


    velocity.x = mouseX;


    //if (Keyboard.isDown(Keyboard.LEFT)) {
    //  velocity.x = -300;
    //} else if (Keyboard.isDown(Keyboard.RIGHT)) {
    //  velocity.x = 300;
    //} else {
    //  //if(isGrounded){
    //  //velocity.x = 0;
    //  //}
    //}

    velocity.x *= friction;


    position.y += velocity.y * dt;


    if (platformDropCD >= 0) {

      if (position.y >= height - 100 - halfH) {
        position.y = height - 100 - halfH;
        velocity.y = 0;
        isGrounded = true;
        friction = 0.95;
        rumble();


      }
    }
    super.update();
  }

  void draw() {
    if (platformDropCD <= 0) {
      fill(#898989);
      rect(0, height-100, width, 150);
    } else if (platformDropCD >= 0) {
      fill(#CB02EA);
      rect(0, height-100, width, 150);
    }

    fill(#0278EA);
    rect(position.x - halfW, position.y - halfH, w, h);
    fill(255);
    //float reticleX = position.x + 75 * cos(angleToMouse);
    //float reticleY = position.y + 75 * sin(angleToMouse);
    //ellipse(reticleX, reticleY, 5, 5);





    if (sword != null) sword.draw();
  }
  @Override void setBottomEdge(float Y) {
    position.y = Y - halfH;
    velocity.y = 0;
    isGrounded = true;
    rumble();
    calcEdges();
  }

  void rumble() {
    if (isGroundPound) {
      //screen shake
      isRumble = true;
      //apply damage
      //particles

      isGroundPound = false;
    }
  }
}
