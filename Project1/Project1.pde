
boolean manualMode = false;
ArrayList<Vector> points = new ArrayList<Vector>();

void setup() {
  size(800, 500);
  // create points:
  // box shape:
  points.add(new Vector(0, 0));
  points.add(new Vector(10, 0));
  points.add(new Vector(20, 0));
  points.add(new Vector(20, 10));
  points.add(new Vector(20, 20));
  points.add(new Vector(10, 20));
  points.add(new Vector(0, 20));
  points.add(new Vector(0, 10));
  // four corners:
  points.add(new Vector(-10, -10));
  points.add(new Vector(30, -10));
  points.add(new Vector(30, 30));
  points.add(new Vector(-10, 30));
}

void draw() {
  background(127);

  float time = millis()/1000.0; // get number of seconds as a float
  float scale = manualMode ? 10.0 * mouseY / height : (7 + 5 * sin(time)); // two methods for setting scale
  float angle = manualMode ? mouseX / 100.0 : time; // two methods for setting angle

  Matrix m = new Matrix(); // build matrix object
  m.translate(-10, -10); // slide up and to the left
  m.scale(scale, scale); // scale up
  m.rotate(angle); // rotate
  m.translate(400, 250); // reposition in center of window

  for (Vector v : points) { // for every point...
    Vector t = m.transform(v); // transforms point V into point T
    t.drawPoint(); // draw point T
  }

  // draw top bar:
  fill(255);
  rect(0, 0, width, 30);
  fill(0);
  text("manual mode : " + (manualMode ? "on" : "off"), 10, 20);
}

void mousePressed() {
  manualMode = !manualMode; // switch modes
}

