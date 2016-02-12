class Polygon {

  // our shape data, transformed shape data, and our normals:
  ArrayList<PVector> mpoints = new ArrayList<PVector>();
  ArrayList<PVector> tpoints = new ArrayList<PVector>();
  ArrayList<PVector> edges = new ArrayList<PVector>();
  ArrayList<PVector> normals = new ArrayList<PVector>();

  // The Matrix:
  PMatrix2D matrix = new PMatrix2D();

  // our transforming properties for the matrix:
  PVector position = new PVector();
  float rotation = 0;
  float scale = 1;

  float bbEdgeL = 0;
  float bbEdgeR = 0;
  float bbEdgeT = 0;
  float bbEdgeB = 0;

  // whether or not we're colliding:
  boolean colliding = false;
  boolean showDebug = true;

  // helps us drastically improve efficiency by
  // allowing us to prevent double-checking collisions:
  boolean doneChecking = false;

  // properties to help us avoid recalculating
  // our matrix, transformed points, and normals:
  PVector previousPosition = new PVector();
  float previousRotation = 0;
  float previousScale = 1;
  boolean sleeping = false;

  Polygon(PVector pos) {
    position = pos;
  }
  // add a point to our shape:
  // (REMEMBER THAT OUR SHAPE SHOULD BE CLOCKWISE)
  void addPoint(float x, float y) {
    mpoints.add(new PVector(x, y));
    tpoints.add(new PVector());
    normals.add(new PVector());
  }
  void update() {
    doneChecking = false;
    colliding = false;
    sleeping = false;

    // if rotation and position haven't changed,
    // DON'T bother recaculating matrix, transformed points, and normals:
    if (previousRotation == rotation && previousPosition.x == position.x && previousPosition.y == position.y && previousScale == scale) {
      sleeping = true;
      return;
    }

    previousPosition = position.get();
    previousRotation = rotation;
    previousScale = scale;

    // CALCULATE NEW MATRIX:
    matrix.reset();
    matrix.translate(position.x, position.y);
    matrix.rotate(rotation);
    matrix.scale(scale);

    // CALCULATE TRANSFORMED POINTS:

    bbEdgeL = Float.MAX_VALUE;
    bbEdgeT = Float.MAX_VALUE;
    bbEdgeR = Float.MIN_VALUE;
    bbEdgeB = Float.MIN_VALUE;

    for (int i = 0; i < mpoints.size(); i++) {
      matrix.mult(mpoints.get(i), tpoints.get(i));
      PVector p = tpoints.get(i);
      if (p.x > bbEdgeR) bbEdgeR = p.x;
      if (p.x < bbEdgeL) bbEdgeL = p.x;
      if (p.y > bbEdgeB) bbEdgeB = p.y;
      if (p.y < bbEdgeT) bbEdgeT = p.y;
    }

    // CALCULATE LEFT-HAND NORMALS: (points must be defined clockwise)
    normals = new ArrayList<PVector>();
    for (int i = 0; i < tpoints.size(); i++) {
      int j = i + 1;
      if (i >= tpoints.size() - 1) j = 0;
      PVector e = new PVector(tpoints.get(i).x - tpoints.get(j).x, tpoints.get(i).y - tpoints.get(j).y);
      PVector n = new PVector(tpoints.get(i).y - tpoints.get(j).y, tpoints.get(j).x - tpoints.get(i).x); 
      normals.add(n);
      edges.add(e);
    }
  }
  void draw() {

    fill(255);
    if (sleeping) fill(128);
    if (colliding) fill(255, 0, 0);
    noStroke();
    beginShape();
    for (PVector p : tpoints) vertex(p.x, p.y);
    endShape();

    ////////// DEBUG DRAWING CODE: //////////
    if (showDebug) {
      int count = normals.size();
      for (int i = 0; i < count; i++) {
        PVector n = normals.get(i);
        PVector mid = PVector.add(tpoints.get(i), tpoints.get(i < count - 1 ? i+1 : 0)); // get point halfway between this point and the next
        mid.mult(.5);
        if (!sleeping) n.normalize(); // inefficient!
        stroke(255);
        PVector pp = PVector.mult(n, -20);
        pp.add(mid);
        line(mid.x, mid.y, pp.x, pp.y);
      }
      // DRAW AABB:
      noFill();
      stroke(255, 0, 0);
      rect(bbEdgeL, bbEdgeT, bbEdgeR - bbEdgeL, bbEdgeB - bbEdgeT);
    }
    ////////// END DEBUG DRAWING CODE //////////
  }
  // Project ALL points onto an axis,
  // and find the shape's minimum and
  // maximum values along that axis:
  MinMax projectAlongAxis(PVector axis) {
    MinMax mm = new MinMax();

    int i = 0;
    for (PVector tp : tpoints) {
      float d = tp.dot(axis);
      if (i == 0) {
        mm.min = d;
        mm.max = d;
      } else {
        if (d < mm.min) mm.min = d;
        if (d > mm.max) mm.max = d;
      }
      i++;
    }
    return mm;
  }

  boolean checkCollisionWithPoint(PVector pt) {
    if (pt.x > bbEdgeR || pt.x < bbEdgeL || pt.y > bbEdgeB || pt.y < bbEdgeT) return false;
    // in bounding box, now check in polygon:
    for (int i = 0; i < tpoints.size(); i++) {
      PVector t = tpoints.get(i);
      PVector p = pt.get();
      p.sub(t);
      float result = normals.get(i).dot(p);
      if (result < 0) return false;
    }
    return true;
  }
}
// allows us to return 2 values from Polygon.projectAlongAxis():
class MinMax {
  float min = 0;
  float max = 0;
}