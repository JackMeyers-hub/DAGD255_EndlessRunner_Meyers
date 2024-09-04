class Sword {
  Player player;

  Enemy enemyTarget;

  float x, y;
  float radius = 25;

  float lifeTime = 0.15;
  boolean isDead = false;
  float damage;

  float directionX;

  ArrayList<Enemy> enemiesCopy = new ArrayList();

  Sword(Player p) {
    player = p;
    enemyTarget = null;
    radius = 15;

    //directionX = p.spriteDirectionX;
    // x = p.x + 5 * cos(p.angleToMouse);
    // y = p.y + 5 * sin(p.angleToMouse);
    x = p.position.x;
    y = p.position.y + 50;
    damage = random(25, 45);
    enemiesCopy = scenePlay.enemies;
  }

  Sword(Enemy e) {
    enemyTarget = e;
    player = null;
    radius = 100;
    directionX = e.angleToPlayer;
    x = e.position.x + 50 * cos(e.angleToPlayer);
    y = e.position.y + 50 * sin(e.angleToPlayer);
    damage = random(5, 10);
  }

  void update() {
    if (player != null) {

      x = player.position.x + 65 * directionX;
      y = player.position.y;

      for (int i = 0; i < enemiesCopy.size(); i++) {
        Enemy e = enemiesCopy.get(i);

        if (checkCollisionSwordEnemy(this, e)) {
          player.velocity.y = -800;
          e.isDead = true;
          scenePlay.kills ++;
        }
      }
    }

    if (enemyTarget != null) {
      x = enemyTarget.position.x + 50 * cos(enemyTarget.angleToPlayer);
      y = enemyTarget.position.y + 50 * sin(enemyTarget.angleToPlayer);

      //if (checkCollisionSwordPlayer(this, player)) {
      //  if (!player.isParrying) {
      //    scenePlay.player.currentHealth -= damage;
      //  }
      //}
    }

    lifeTime -= dt;
    if (lifeTime <= 0) {

      //if (playerTarget != null) {
      //  for (int i = 0; i < enemiesCopy.size(); i++) {
      //    Enemy e = enemiesCopy.get(i);
      //    e.isSlashed = false;
      //  }
      //}

      isDead = true;
    }
  }

  void draw() {
    fill(255);
    ellipse(x, y + 50, radius*2, radius*2);
  }
}
