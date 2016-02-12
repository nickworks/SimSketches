/*
 * This class provides a simple AABB that can be updated, drawn, and used for
 * collision detection against other AABB objects. This class is used within
 * the Polygon class.
 */
class AABB {
  /*
   * This flag is set to false each update, and true during collision detection if it collides.
   * When true, this AABB is drawn in red.
   */
  private boolean colliding = false;
  /*
   * The four edges of this AABB. Each are measured from the world origin.
   */
  private float xmin, xmax, ymin, ymax;
  /*
   * This method should be called each update before collision detection to reset the colliding flag.
   */
  public void resetColliding(){
    colliding = false;
  }
  /*
   * This method recalculates the AABB's four edges by stepping through a list of transformed
   * points in order to find the minimum and maximum values in the x and y dimensions.
   *
   * @param PVector[] points  The list of points to step through.
   */
  public void recalc(PVector[] points) {
    for (int i = 0; i < points.length; i++) {
      PVector p = points[i];
      if (i == 0 || p.x < xmin) xmin = p.x;
      if (i == 0 || p.x > xmax) xmax = p.x;
      if (i == 0 || p.y < ymin) ymin = p.y;
      if (i == 0 || p.y > ymax) ymax = p.y;
    }
  }
  /*
   * This method draws the AABB. If the colliding flag is set to true, this is drawn in red. 
   */
  public void draw() {
    noFill();
    stroke(255);
    if(colliding) stroke(255, 0, 0);
    rectMode(CORNERS);
    rect(xmin, ymin, xmax, ymax);
  }
  /*
   * Check for collision between this and another AABB.
   *
   * @param AABB aabb  The other AABB to check against this object.
   * @return boolean  Whether or not the objects are colliding.
   */
  public boolean checkCollision(AABB aabb){
    if (xmax < aabb.xmin) return false;
    if (xmin > aabb.xmax) return false;
    if (ymax < aabb.ymin) return false;
    if (ymin > aabb.ymax) return false;
    colliding = true; // flag as colliding this frame so that we draw it in red
    aabb.colliding = true; // set flag on other object
    return true;
  }
}