
boolean manualMode = true;
ArrayList<Vector> points = new ArrayList<Vector>();
float scale = 1;
float angle = 0;
float intensity = 0;
color drawColor;
int hue = 0;
float speed = 1;
float time;
float scatter = 0;

void setup() {
  size(800, 500);

  points.add(new Vector(-10, -10));
  points.add(new Vector(30, -10));

  points.add(new Vector(30, 30));
  points.add(new Vector(-10, 30));

  points.add(new Vector(0, 0));
  points.add(new Vector(10, 0));
  points.add(new Vector(20, 0));
  points.add(new Vector(20, 10));
  points.add(new Vector(20, 20));
  points.add(new Vector(10, 20));
  points.add(new Vector(0, 20));
  points.add(new Vector(0, 10));
}

void draw() {
  fill(255, 255, 255, 10);
  rect(0, 0, width, height);

  time += (0.01 * speed);
  if(Input.S || mousePressed) speed *= .95;
  float newScale = 10.0 * mouseY / height * (7 + 5 * sin(time));
  float newAngle = mouseX / 100.0 + time;

  intensity = 10 + (int)((scale - newScale) * 20);
  
  if (Input.N4) intensity *= 4;
  if (Input.N3) intensity *= 4;
  if (Input.N2) intensity *= 4;
  if (Input.N1) intensity *= 2;

  scale = (scale + newScale) / 2;
  if(Input.SPACE) scatter = 1;
  angle = scatter * random(PI) + newAngle;//(angle + newAngle) / 2;
  if(scatter > 0) scatter *= .5;
  if(scatter < 0) scatter = 0;
  

  colorMode(HSB);
  hue += 1;
  while (hue > 255) hue -= 255;
  drawColor = color(hue, 255, intensity * intensity);
  colorMode(RGB);

  Matrix m = new Matrix(); // build matrix object
  m.translate(-10, -10);
  m.scale(scale, scale);
  m.rotate(angle);
  m.translate(400, 250);

  for (Vector v : points) { // for every point...
    Vector t = m.transform(v); // transforms point V into point T
    t.drawPoint(); // draw point T
  }
  /*
  fill(255);
   rect(0, 0, width, 30);
   fill(0);
   text("manual mode : " + (manualMode ? "on" : "off"), 10, 20);
   */
}

void mousePressed() {
  manualMode = !manualMode;
}
void mouseWheel(MouseEvent event) {
  float e = event.getCount();
  speed += e/2.0;
  println(speed);
}

