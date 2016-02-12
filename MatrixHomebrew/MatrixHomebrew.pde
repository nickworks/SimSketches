// In this example we homebrew our own Matrix math!
// This is a simple proof of concept, and is not very functional for complex transformations.

ArrayList<PVector> points = new ArrayList<PVector>();

void setup(){
  size(200,200);
  
  points.add(new PVector(-10, -10));
  points.add(new PVector(-10,  10));
  points.add(new PVector( 10,  10));
  points.add(new PVector( 10, -10));
  
}
void draw(){
  background(0);
  
  float time = (float) millis()/1000;
  
  for(PVector p : points){
    PVector tp = Transform(time, 5, 100, 100, p);
    ellipse(tp.x, tp.y, 10, 10);
  }
}
PVector Transform(float radians, float scale, float tx, float ty, PVector p) {

  float a = cos(radians) * scale;
  float b = sin(radians) * scale;
  float c = -b;
  float d = a;
  
  float x = a * p.x + b * p.y + tx;
  float y = c * p.x + d * p.y + ty;

  return new PVector(x, y);
}

