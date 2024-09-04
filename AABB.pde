class AABB {

  Player player;
  PVector position = new PVector();
  PVector velocity = new PVector();
  boolean isDead;
  float w, h;
  float angleToMouse, angleToObject, launchAngle;

  // AABB Properties
  float edgeL = 0;
  float edgeR = 0;
  float edgeT = 0;
  float edgeB = 0;
  float halfW = 0;
  float halfH = 0;

  AABB() {
  }

  void update() {
    calcEdges();
  }

  void calcEdges() {
    edgeL = position.x - halfW;
    edgeR = position.x + halfW;
    edgeT = position.y - halfH;
    edgeB = position.y + halfH;
  }


  void setSize(float w, float h) {
    this.w = w;
    this.h = h;
    halfW = w/2;
    halfH = h/2;
    calcEdges();
  }

  boolean checkCollision(AABB other) {
    if (edgeR < other.edgeL) return false;
    if (edgeL > other.edgeR) return false;
    if (edgeB < other.edgeT) return false;
    if (edgeT > other.edgeB) return false;
    return true;
  }


  void fixOverlap(AABB other) {
    float pushUp = edgeB - other.edgeT;
    float pushLeft = edgeR - other.edgeL;
    float pushRight = other.edgeR - edgeL;
    float pushDown = other.edgeB - edgeT;


    if (pushUp <= pushLeft && pushUp <= pushRight && pushUp <= pushDown) setBottomEdge(other.edgeT);
    else if (pushLeft <= pushDown && pushLeft <= pushRight && pushLeft <= pushDown) setRightEdge(other.edgeL);
    else if (pushRight <= pushUp && pushRight <= pushDown && pushRight <= pushLeft) setLeftEdge(other.edgeR);
    else if (pushDown <= pushRight && pushDown <= pushLeft && pushDown <= pushUp) setTopEdge(other.edgeB);
  }

  void setBottomEdge(float Y) {
    position.y = Y - halfH;
    velocity.y = 0;
    calcEdges();
  }

  void setRightEdge(float X) {
    position.x = X - halfW;
    velocity.x = 300;
    scenePlay.player.isGrounded = false;
    calcEdges();
  }

  // figure out push down and push right to fix teleporting through platforms
  //---------------------------------------------
  void setTopEdge(float Y) {
    position.y = Y + halfH;
    velocity.y = 200;
    scenePlay.player.isGrounded = false;
    calcEdges();
  }

  void setLeftEdge(float X) {
    position.x = X + halfW;
    velocity.x = 0;
    scenePlay.player.isGrounded = false;
    calcEdges();
  }
  //--------------------------------------------
  void calcAngleToMouse() {
    angleToMouse = atan2(mouseY - position.y, mouseX - position.x);
  }
  void calcAngleToObject(AABB object) {
    angleToObject = atan2(object.position.y - position.y, object.position.x - position.x);
  }
}
