class Point {
  int x = 0;
  int y = 0;
  int z = 0;
  public Point(int x, int y) {
    this.x = x;
    this.y = y;
  }
  public Point(int x, int y, int z) {
    this.x = x;
    this.y = y;
    this.z = z;
  }
  public boolean matches2D(Point p) {
    return (p.x == x && p.y == y);
  }
  public Point get() {
    return new Point(x, y, z);
  }
  public Point add(Point p) {
    return add(p.x, p.y, p.z);
  }
  public Point add(int x, int y) {
    return add(x, y, 0);
  }
  public Point add(int x, int y, int z) {
    return new Point(this.x + x, this.y + y, this.z + z);
  }
  public Point mult(float scale) {
    return new Point((int)(x * scale), (int)(y * scale), (int)(z * scale));
  }
}

