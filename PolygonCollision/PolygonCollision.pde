
ArrayList<Polygon> shapes = new ArrayList<Polygon>();
Polygon poly1;
Polygon poly2;

void setup() {
  size(800, 500);
  poly1 = makePoly1();
  poly2 = makePoly2();
}
void draw() {
  // UPDATE:
  update();
  
  // DRAW:
  background(0);
  for (Polygon p : shapes) p.draw();
}
void update(){
  float timeMultiplier = 0.5;
  float time = timeMultiplier * millis() / 1000.0;
  
  poly1.setPosition(new PVector(mouseX, mouseY));
  poly2.setRotation(time);
  poly2.setScale(sin(time) + 3);
  
  for (Polygon p : shapes) p.update();
  for (Polygon p : shapes) p.checkCollisions(shapes);
}

// convenience methods:

Polygon makePoly1() {
  Polygon p = new Polygon();
  shapes.add(p);
  p.addPoint(-10, -10);
  p.addPoint(10, -30);
  p.addPoint(20, 30);
  p.addPoint(-20, 20);
  return p;
}
Polygon makePoly2() {
  Polygon p = new Polygon();
  p.scale = 3;
  shapes.add(p);
  p.addPoint(-10, -10);
  p.addPoint(10, -30);
  p.addPoint(20, 30);
  return p;
}