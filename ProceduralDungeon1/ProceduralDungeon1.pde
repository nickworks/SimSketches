
int dungeonW = 10;
int dungeonH = 10;
int chunksPerRoom = 5;

int[][] rooms;
int[][] bigrooms;

boolean showTinyRooms = false;
boolean keySpace = false;
boolean keyPrevSpace = false;

class Point {
  int x;
  int y;
  public Point(int x, int y) {
    this.x = x;
    this.y = y;
  }
}
void setup() {
  size(800, 600);

  newDungeon();
  rectMode(CORNER);
  fill(255);
  noStroke();
}
void mousePressed() {
  newDungeon();
}
void newDungeon() {
  rooms = new int[dungeonW*chunksPerRoom][dungeonH*chunksPerRoom];
  bigrooms = new int[dungeonW][dungeonH];

  int halfW = rooms.length/2;
  int halfH = rooms[0].length/2;

  for (int i = 0; i < 6; i++) {
    int x1 = (int)random(rooms.length);
    int y1 = (int)random(rooms[i].length);
    int x2 = (int)random(halfW);
    int y2 = (int)random(halfH);

    if (x1 < halfW) x2 += halfW;
    if (y1 < halfH) y2 += halfH;

    if (i == 0) {
      roomAt(x1, y1, 3); // enter
      roomAt(x2, y2, 4); // exit
    } else {
      roomAt(x1, y1, 2);
      roomAt(x2, y2, 2);
    }

    tunnel(x1, y1, x2, y2);
  }
  // make bigrooms
  for (int x = 0; x < rooms.length; x++) {
    for (int y = 0; y < rooms[x].length; y++) {
      if (rooms[x][y] > bigrooms[x/chunksPerRoom][y/chunksPerRoom]) bigrooms[x/chunksPerRoom][y/chunksPerRoom] = rooms[x][y];
    }
  }
  // remove unnecessary rooms
  ArrayList<Point> points = new ArrayList<Point>();
  for (int x = 0; x < bigrooms.length; x++) {
    for (int y = 0; y < bigrooms[x].length; y++) {
      points.add(new Point(x, y));
    }
  }

  int amt = bigrooms.length * bigrooms[0].length;
  for (int i = 0; points.size () > 0; i = (int)random(points.size())) {

    int x = points.get(i).x;
    int y = points.get(i).y;

    points.remove(points.get(i));

    int r = getBigRoomAt(x, y);
    if (r != 1) continue; // only consider deleting normal rooms
    int[] neighbors = new int[8];

    neighbors[0] = getBigRoomAt(x-1, y-1);
    neighbors[1] = getBigRoomAt(x, y-1);
    neighbors[2] = getBigRoomAt(x+1, y-1);
    neighbors[3] = getBigRoomAt(x+1, y);
    neighbors[4] = getBigRoomAt(x+1, y+1);
    neighbors[5] = getBigRoomAt(x, y+1);
    neighbors[6] = getBigRoomAt(x-1, y+1);
    neighbors[7] = getBigRoomAt(x-1, y);

    int prev = neighbors[neighbors.length-1] > 0 ? 1 : 0;
    int switches = 0;     
    for (int j = 0; j < neighbors.length; j++) {

      int n = (neighbors[j] > 0) ? 1 : 0;
      if (n != prev) {
        prev = n;
        switches++;
      }
    }
    if (switches <= 2) bigrooms[x][y] = 0;
  }
}
int getBigRoomAt(int x, int y) {

  if (x < 0) return 0;
  if (y < 0) return 0;
  if (x >= bigrooms.length) return 0;
  if (y >= bigrooms[0].length) return 0;
  return bigrooms[x][y];
}
int numOfRooms() {
  int num = 0;
  for (int x = 0; x < rooms.length; x++) {
    for (int y = 0; y < rooms[x].length; y++) {
      if (rooms[x][y] > 0) num++;
    }
  }
  return num;
}

boolean validXY(int x, int y) {
  if (x < 0) return false;
  if (y < 0) return false;
  if (x >= rooms.length) return false;
  if (y >= rooms[0].length) return false;
  return true;
}
void roomAt(int x, int y, int val) {
  if (validXY(x, y)) {
    if (rooms[x][y] == 0) rooms[x][y] = val;
  }
}
void tunnel(int x, int y, int tx, int ty) {
  int dx = tx - x;
  int dy = ty - y;
  int adx = abs(dx);
  int ady = abs(dy);
  int len = (int)random(5) + 1;
  if (len > 3) len = 3;

  roomAt(x, y, 1);

  if (adx == 0 && ady == 0) return;
  else if (adx > ady) {
    if (dx > 0) tunnelR(++x, y, tx, ty, len);
    if (dx < 0) tunnelL(--x, y, tx, ty, len);
  } else {
    if (dy > 0) tunnelD(x, ++y, tx, ty, len);
    if (dy < 0) tunnelU(x, --y, tx, ty, len);
  }
}
void tunnelU(int x, int y, int tx, int ty, int depth) {
  roomAt(x, y, 1);
  if (--depth > 0) tunnelU(x, --y, tx, ty, depth);
  else tunnel(x, y, tx, ty);
}
void tunnelD(int x, int y, int tx, int ty, int depth) {
  roomAt(x, y, 1);
  if (--depth > 0) tunnelD(x, ++y, tx, ty, depth);
  else tunnel(x, y, tx, ty);
}
void tunnelR(int x, int y, int tx, int ty, int depth) {
  roomAt(x, y, 1);
  if (--depth > 0) tunnelR(++x, y, tx, ty, depth);
  else tunnel(x, y, tx, ty);
}
void tunnelL(int x, int y, int tx, int ty, int depth) {
  roomAt(x, y, 1);
  if (--depth > 0) tunnelL(--x, y, tx, ty, depth);
  else tunnel(x, y, tx, ty);
}

void draw() {

  if (keySpace && !keyPrevSpace) showTinyRooms = !showTinyRooms;
  keyPrevSpace = keySpace;

  noStroke();
  background(0);
  int mag = 10;
  fill(200);
  int bigmag = mag*chunksPerRoom;
  for (int x = 0; x < bigrooms.length; x++) {
    for (int y = 0; y < bigrooms[x].length; y++) {
      if (bigrooms[x][y] > 0) {
        switch(bigrooms[x][y]) {
        case 1: 
          fill(200); 
          break;
        case 2: // special
          fill(0, 255, 0); 
          break;
        case 3: // entry
          fill(255, 0, 0); 
          break;
        case 4: // exit
          fill(0, 0, 255); 
          break;
        }
        rect(x*bigmag, y*bigmag, bigmag, bigmag);
      }
    }
  }
  if (showTinyRooms) {
    fill(255);
    for (int x = 0; x < rooms.length; x++) {
      for (int y = 0; y < rooms[x].length; y++) {
        if (rooms[x][y] > 0) {
          rect(x*mag, y*mag, mag, mag);
        }
      }
    }
  }

  stroke(255, 0, 0);
  for (int x = 0; x < dungeonW; x++) {
    line(x*bigmag, 0, x*bigmag, dungeonH*bigmag);
  }
  for (int y = 0; y < dungeonH; y++) {
    line(0, y*bigmag, dungeonW*bigmag, y*bigmag);
  }
}

void handleKey(int code, boolean state) {
  switch(code) {
  case 32:
    keySpace = state;
    break;
  }
}
void keyPressed() {
  handleKey(keyCode, true);
}
void keyReleased() {
  handleKey(keyCode, false);
}

