class Path {

  boolean isMapped = false;
  ArrayList<Room> rooms = new ArrayList<Room>();
  color pathColor = color(255);

  public Path(int n) {
    addRooms(n);
  }
  public Path(Room r, int n) {
    addRoom(r);
    addRooms(n);
  }
  void setColor(color c){
    pathColor = c;
  }
  void addRoom(Room r) {
    rooms.add(r);
  }
  void addRooms(int n) {
    for (int i = 0; i < n; i++) {
      addRoom(new Room());
    }
  }
  void setTypeStartEnd(int typeStart, int typeEnd){
    rooms.get(0).type = typeStart;
    rooms.get(rooms.size()-1).type = typeEnd;
  }
  void draw() {
    Point p = null;
    for (Room r : rooms) {
      if (p != null) {
        stroke(pathColor);
        line(p.x, p.y, r.pos.x, r.pos.y);
      }
      p = r.pos.get();
    }
    for (Room r : rooms) {
      r.draw();
    }
    
  }
}

