/*
 * This class provides encapsulates the mathematical representation (points) of a
 * Polygon. This class can update, draw, and do collision detection between Polygon
 * objects.
 *
 * We are using a CLOCKWISE point-ordering convention.
 */
class Polygon {
  /*
   * This flag is set to false each update, and true during collision detection if it collides.
   * When true, this shape is drawn in red.
   */
  private boolean colliding = false;
  /*
   * This flag is set to false each update, and true during collision detection AFTER it has been
   * checked against ALL of its siblings. It is used to prevent each pair of objects from checking
   * twice.
   */
  private boolean doneChecking = false;
  /*
   * This flag is used to indicate when transformed points, normals, and AABB should be calculated.
   * When we rotate / translate / scale the Polygon we set this flag to true. When the flag is false,
   * The cached data is used instead.
   */
  private boolean dirty = true;
  /*
   * The list of points, relative to this object's anchor point.
   */
  private ArrayList<PVector> points = new ArrayList<PVector>();
  /*
   * The list of transformed points relative to the world origin.
   */
  private PVector[] pointsTransformed;
  /*
   * The list of edge normals.
   */
  private PVector[] normals;
  /*
   * This Polygon's AABB.
   */
  AABB aabb = new AABB();

  /*
   * These are our three transformation properties. They should be kept private
   * and accessed only through the public getter / setter methods.
   */
  private float rotation = 0;
  private float scale = 1;
  private PVector position = new PVector(400, 250);

  /*
   * These are our three transformation getter methods. These are very straightforward.
   */
  public float getScale() { 
    return scale;
  }
  public float getRotation() { 
    return rotation;
  }
  public PVector getPosition() { 
    return position.copy();
  }

  /*
   * These are our three transformation setter methods. When any of the transformation
   * properties are changed, we set the dirty flag to true.
   */
  public void setScale(float s) { 
    scale = s; 
    dirty = true;
  }
  public void setRotation(float r) { 
    rotation = r; 
    dirty = true;
  }
  public void setPosition(PVector p) { 
    position = p.copy(); 
    dirty = true;
  }

  /*
   * This method updates this Polygon every frame.
   */
  void update() {
    
    // unset the doneChecking flag: (we'll do collision detection again this frame)
    doneChecking = false;
    
    // unset the colliding flags: (we don't know yet whether or not this object is colliding)
    colliding = false; 
    aabb.resetColliding();

    // if the object is dirty (has been transformed), recalculate transformed points, normals, and AABB:
    if (dirty) recalc();
  }
  /*
   * This method recalculates all of the transformed points, normals, and AABB for the polygon.
   * If the object's position / rotation / scale have not changed, this method should not be called.
   */
  void recalc() {

    dirty = false; // reset the dirty flag

    // build a transformation matrix:
    PMatrix2D matrix = new PMatrix2D();
    matrix.translate(position.x, position.y);
    matrix.rotate(rotation);
    matrix.scale(scale);

    // calculate the transformed positions of each point:
    pointsTransformed = new PVector[points.size()];
    for (int i = 0; i < points.size(); i++) {
      PVector p = new PVector();
      matrix.mult(points.get(i), p); // get the transformed point, store it in (p)
      pointsTransformed[i] = p; // store (p) in the pointsTransformed array
    }

    normals = new PVector[pointsTransformed.length];
    for(int i = 0; i < pointsTransformed.length; i++){
      // find edge vector
      int j = (i == pointsTransformed.length - 1) ? 0 : i + 1;
      PVector p1 = pointsTransformed[i];
      PVector p2 = pointsTransformed[j];
      // find left-hand perpendicular
      normals[i] = new PVector(p1.y - p2.y, p2.x - p1.x);
      //normals[i].normalize();
    }

    // update this object's AABB:
    aabb.recalc(pointsTransformed);
  }
  /*
   * This method draws this Polygon object to the screen using the list of transformed points.
   */
  void draw() {

    // set up stroke / fill:
    noStroke();
    fill(255);
    if (colliding) fill(255, 0, 0); // draw red if colliding this frame

    // draw the shape:
    beginShape();
    for (int i = 0; i < pointsTransformed.length; i++) {
      vertex(pointsTransformed[i].x, pointsTransformed[i].y);
    }
    endShape();

    // tell AABB to draw:
    aabb.draw();
  }
  /*
   * This method adds a Point to this object's list of points.
   *
   * @param PVector p  The point to add.
   */
  void addPoint(PVector p) {
    addPoint(p.x, p.y);
  }
  /*
   * This method adds a Point to this object's list of points.
   *
   * @param float x  The x component of the point to add.
   * @param float y  The y component of the point to add.
   */
  void addPoint(float x, float y) {
    points.add(new PVector(x, y));
  }
  /*
   * This method checks for collision between this object and a list of other Polygon objects. If this
   * object is found to be colliding with another object, it is flagged so that it can be colored red this frame.
   *
   * @param ArrayList<Polygon> shapes  The list of other Polygon objects
   */
  void checkCollisions(ArrayList<Polygon> shapes) {
    for (Polygon p : shapes) {
      if (p == this) continue; // don't check for collision between this object and itself
      if (p.doneChecking == true) continue; // don't check against object p, it's already done collision detection against every object
      if (checkCollision(p)) {
        colliding = true; // flag as colliding for this frame (so we can color it red)
        p.colliding = true; // set flag for other object
      }
    }
    doneChecking = true;
  }
  /*
   * This method checks for collision between this Polygon and another Polygon. Currently, it only
   * uses AABB collision detection (mid-phase collision detection). In this method, implement narrow-phase
   * collision detection ONLY IF the AABB collision detection detects a potential collision.
   *
   * @todo Implement narrow phase collision detection using normals, projection, and min/maxes.
   *
   * @param Polygon poly  The other Polygon to check against this Polygon.
   * @return boolean  Whether or not these two Polygon objects are colliding.
   */
  boolean checkCollision(Polygon poly) {

    if (aabb.checkCollision(poly.aabb)) {

      // TODO: add narrow-phase collision detection here!
      // Use the normals array and project each object's transformed
      // points onto an axis aligned with EVERY normal of BOTH objects.
      // When doing projection, look for gaps between the objects.
      
      for(PVector n : normals){ // for every normal in THIS object ...
        MinMax mm1 = this.projectAlongAxis(n);
        MinMax mm2 = poly.projectAlongAxis(n);
        
        if(mm1.min > mm2.max) return false; // look for a gap to the right of object 2
        if(mm2.min > mm1.max) return false; // look for a gap to the right of object 1
      }
      for(PVector n : poly.normals){ // for every normal in the OTHER object ...
        MinMax mm1 = this.projectAlongAxis(n);
        MinMax mm2 = poly.projectAlongAxis(n);
        
        if(mm1.min > mm2.max) return false; // look for a gap to the right of object 2
        if(mm2.min > mm1.max) return false; // look for a gap to the right of object 1
      }
      return true;
    }
    return false;
  }
  
  MinMax projectAlongAxis(PVector axis){
    
    float min = 0, max = 0;
    int i = 0;
    for(PVector p : pointsTransformed){
      float v = p.dot(axis);
      if(i == 0 || v < min) min = v;
      if(i == 0 || v > max) max = v;
      i++;
    }
    
    return new MinMax(min, max);
  }
  
}

class MinMax {
  float min, max;
  MinMax(float min, float max){
    this.min = min;
    this.max = max;
  }
}