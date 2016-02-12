class Room {

  int gridSize = 32;

  int type = RoomType.NORMAL;
  boolean isMapped = false;

  Point pos = null;
  Point gridPos = null;

  public Room() {
  }
  void setGridPos(Point gridPos) {
    this.gridPos = gridPos;
    this.pos = gridPos.mult(gridSize);
  }
  void draw() {
    noStroke();
    switch(type) {
    case RoomType.NORMAL: 
    case RoomType.FORK: 
      fill(255);
      break;
    case RoomType.ENTER: 
      fill(255, 0, 0);
      break;
    case RoomType.EXIT: 
      fill(0, 0, 255);
      break;
    default:
      fill(0, 255, 0);
      break;
    }
    ellipse(pos.x, pos.y, 15, 15);
  }
}

