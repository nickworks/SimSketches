class Point {
  int x = 0;
  int y = 0;
  Point(){ }
  Point(int x, int y) {
    this.x = x;
    this.y = y;
  }
  Point get(){
    return new Point(x, y); 
  }
  Point getUp(){
    return new Point(x, y-1);
  }
  Point getDown(){
    return new Point(x, y+1);
  }
  Point getLeft(){
    return new Point(x-1, y);
  }
  Point getRight(){
    return new Point(x+1, y);
  }
  String toString(){
    return x + ", " + y; 
  }
}

