class Vector {
  float x = 0;
  float y = 0;

  public Vector() {
  }
  public Vector(float val) {
    x = val;
    y = val;
  }
  public Vector(float x, float y) {
    this.x = x;
    this.y = y;
  }
  Vector get() {
    return new Vector(x, y);
  }
  void fromAngle(float angle) {
    x = cos(angle);
    y = sin(angle);
  }
  void add(Vector v) {
    x += v.x;
    y -= v.y;
  }
  void sub(Vector v) {
    x -= v.x;
    y -= v.y;
  }
  void mult(float s) {
    x *= s;
    y *= s;
  }
  float dot(Vector v) {
    return v.x * x + v.y * y;
  }
  float magSq() {
    return x * x + y * y;
  }
  float mag() {
    return sqrt(magSq());
  }
  float disTo(Vector v) {
    v = v.get();
    v.sub(this);
    return v.mag();
  }
  float angle() {
    return atan2(y, x);
  }
  float angleTo(Vector v) {
    v = v.get();
    v.sub(this);
    return v.angle();
  }
  void norm() {
    mult(1/mag());
  }
  void drawPoint() {
    
    noStroke();
    fill(0);
    ellipse(x, y, 5, 5);
  }
  String toString() {
    return "[ " + x + ", " + y + " ]";
  }
}

