class Enemy extends AABB {

  float maxHealth = 100, currentHealth = maxHealth;
  float damagePool = 0;
  float speedMultiplier = 2;
  float angleToPlayer;
  float radius = 25;
  Sword sword;
  //HealthBar bar;
  Enemy(float X) {

    //bar = new HealthBar(this);
    //bar.maxHealth = maxHealth;
    velocity.x = 0;
    velocity.y = 200;
    position.x = X;
    position.y = -50;
    setSize(25, 25);
  }

  void update() {
    //position.y += GRAVITY * dt;


    position.x += velocity.x * dt;
    position.y += velocity.y * dt;

    calcDamage();

    //bar.currentHealth = currentHealth;
    //bar.update();

    if (currentHealth <= 0) {
      isDead = true;
      sword = null;
    }

    if (position.y > height + 50) isDead = true;
    super.update();
  }

  void draw() {
    fill(60, 0, 0);
    rect(position.x - halfW, position.y - halfH, w, h);
    //bar.draw();
  }

  void calcDamage() {
    if (damagePool > 0) {
      currentHealth -= damagePool * dt * speedMultiplier;
      damagePool -= damagePool * dt * speedMultiplier;
    }

    if (damagePool <= 0) damagePool = 0;
  }

  void calcAngleToPlayer() {
    float dx = player.position.x - position.x;
    float dy = player.position.y - position.y;
    angleToPlayer = atan2(dy, dx);
  }
}
