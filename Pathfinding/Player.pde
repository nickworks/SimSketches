class Player {

  // GRID-SPACE COORDINATES:
  Point gridP = new Point();
  Point gridT = new Point();

  // PIXEL-SPACE COORDINATES:
  PVector pixlP = new PVector(); // CURRENT POSITION

  ArrayList<Tile> path;
  boolean findPath = false;

  Player() {
    teleportTo(gridP);
  }
  void teleportTo(Point gridP) {
    Tile tile = level.getTile(gridP);
    if (tile != null) {
      this.gridP = gridP.get();
      this.gridT = gridP.get();
      this.pixlP = tile.getCenter();
    }
  }
  void setTargetPosition(Point gridT) {
    this.gridT = gridT.get();
    findPath = true;
  }
  void update() {
    if (findPath == true) findPathAndTakeNextStep();
    updateMove();
  }
  void findPathAndTakeNextStep() {
    findPath = false;
    Tile start = level.getTile(gridP);
    Tile end = level.getTile(gridT);
    if (start == end) {
      path = null;
      return;
    }
    path = pathfinder.findPath(start, end);

    if (path != null && path.size() > 1) { 
      Tile tile = path.get(1);
      if(tile.isPassable()) gridP = new Point(tile.X, tile.Y);
    }
  }
  void updateMove() {
    
    float snapThreshold = 1;
    PVector pixlT = level.getTileCenterAt(gridP);
    PVector diff = PVector.sub(pixlT, pixlP);
    
    pixlP.x += diff.x * .2;
    pixlP.y += diff.y * .2;
    
    if (abs(diff.x) < snapThreshold) pixlP.x = pixlT.x;
    if (abs(diff.y) < snapThreshold) pixlP.y = pixlT.y;

    if (pixlT.x == pixlP.x && pixlT.y == pixlP.y) findPath = true;
  }
  void draw() {
    noStroke();
    fill(0);
    ellipse(pixlP.x, pixlP.y, 28, 28);
    drawPath();
  }
  void drawPath() {
    if (path != null && path.size() > 1) {
      stroke(0);
      PVector prevP = pixlP.get();//path.get(0).getCenter();
      for (int i = 1; i < path.size (); i++) {
        PVector currP = path.get(i).getCenter();
        line(prevP.x, prevP.y, currP.x, currP.y);
        prevP = currP;
      }
      noStroke();
      ellipse(prevP.x, prevP.y, 8, 8);
    }
  }
}

