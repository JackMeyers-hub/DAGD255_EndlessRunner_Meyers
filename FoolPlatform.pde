class FoolPlatform extends AABB {

  FoolPlatform(float X, float Y, float W, float H) {
    position.x = X;
    position.y = Y;


    setSize(W, H);
    velocity.y =  100;
  }

  void update() {

    position.y += velocity.y * dt;


    if (position.y > height + 50) isDead = true; // kills once platform is off the left edge
    super.update(); // calls parents update function
  }

  void draw() {
    fill(#670707);
    rect(position.x - halfW, position.y - halfH, w, h);
  }
}
