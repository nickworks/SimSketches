class Dungeon {

  ArrayList<Path> paths = new ArrayList<Path>();

  int[][] dirs = {
    {
      1, 2, 3
    }
    , 
    {
      1, 3, 2
    }
    , 
    {
      2, 1, 3
    }
    , 
    {
      2, 3, 1
    }
    , 
    {
      3, 2, 1
    }
    , 
    {
      3, 1, 2
    }
  };

  public Dungeon() {

    int rooms = 15;

    ArrayList<Integer> paths = new ArrayList<Integer>();
    while (rooms > 0) {
      int num = rooms/2;
      num += (int)(random(2)) - 1;
      if(num <= 0) num = 1;
      if(num > 5 && paths.size() > 0) num = 5;
      if(num > rooms) num = rooms;
      rooms -= num;
      paths.add(num);
    }

    for (int p : paths) {
      print(p + " ");
      addPath(p);
    }
    println();
    layoutPaths();
  }
  void addPath(int n) {

    Path newPath = null;
    if (paths.size() == 0) {
      newPath = new Path(n);
      newPath.setTypeStartEnd(RoomType.ENTER, RoomType.EXIT);
    } 
    else {
      newPath = new Path(getRandomRoomOfType(RoomType.NORMAL, n), n);
      newPath.setTypeStartEnd(RoomType.FORK, RoomType.SPECIAL);
      colorMode(HSB);
      newPath.setColor(color((int)random(256), 255, 255));
      colorMode(RGB);
    }

    paths.add(newPath);
  }
  Room getRandomRoomOfType(int type) {
    return getRandomRoomOfType(type, 0);
  }
  Room getRandomRoomOfType(int type, int forPath) {
    Room r = null;
    while (r == null || r.type != type) {
      Path p = forPath > 2 ? paths.get(0) : paths.get((int)random(paths.size()));
      r = p.rooms.get((int)random(p.rooms.size()));
    }
    return r;
  }
  void layoutPaths() {

    boolean success = false;
    int tries = 1;
    while (!success) {
      resetLayout();
      for (Path p : paths) {
        p.isMapped = true;
        success = layoutPath(p, 0, new Point(10, 10)); // TODO: if unsuccessful, start over
        if (!success) {
          tries++;
          break;
        }
      }
    }
    if (tries > 1) println("layout created after "+tries+" tries");
  }
  void resetLayout() {
    for (Path p : paths) {
      p.isMapped = false;
      for (Room r : p.rooms) {
        r.isMapped = false;
      }
    }
  }
  boolean layoutPath(Path path, int index, Point gridPos) {

    Room room = path.rooms.get(index);
    if (room.isMapped) {
      gridPos = room.gridPos.get();
    } 
    else {
      room.setGridPos(gridPos);
    }
    room.isMapped = true;

    if (index + 1 == path.rooms.size()) return true;

    int[] dirs = this.dirs[(int)random(this.dirs.length)];

    for (int d : dirs) {
      // the direction to ignore is stored in the Point
      if (gridPos.z == d && gridPos.z != 4) d = 4;

      Point p = null;

      if (d == 1) p = gridPos.add(0, -1); //up
      if (d == 2) p = gridPos.add(1, 0); //right
      if (d == 3) p = gridPos.add(0, 1); //down
      if (d == 4) p = gridPos.add(-1, 0); //left

      if (isVacant(p)) { // store direction in Point:
        if (d == 1) p.z = 3;
        if (d == 2) p.z = 4;
        if (d == 3) p.z = 1;
        if (d == 4) p.z = 2;
        if (layoutPath(path, index + 1, p)) return true;
      }
    }
    room.isMapped = false;
    return false;
  }
  boolean isVacant(Point gridPos) {
    for (Path p : paths) {
      if (!p.isMapped) continue; // ignore unpositioned paths
      for (Room r : p.rooms) {
        if (!r.isMapped) continue; // ignore unpositioned rooms
        if (r.gridPos.matches2D(gridPos)) return false; // if a room is in this position, return false
      }
    }
    return true;
  }
  void draw() {
    for (Path p : paths) p.draw();
  }
} 

