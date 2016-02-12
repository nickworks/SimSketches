
PVector v1;
PVector v2;
float angle = 0;

void setup(){
  size(400, 400);
  changeVector();
}

void draw(){

  if(mousePressed) changeVector();  
  v2 = new PVector(mouseX-200, mouseY-200);

  
  
  float dot1 = v1.dot(v2);
  float dot2 = v1.x * v2.x + v1.y * v2.y;
  float dot3 = v1.mag() * v2.mag() * cos(v1.heading() - v2.heading());
  float dot4 = v2.mag() * cos(v1.heading() - v2.heading());
  
  PVector v3 = v1.copy();
  v3.normalize().mult(dot4);
  
  background(255);
  pushMatrix();
  translate(200, 200);
  stroke(0);
  strokeWeight(1);
  line(0,0,v1.x,v1.y);
  line(0,0,v2.x,v2.y);
    
  strokeWeight(2);
  stroke(0, 0, 255);
  line(v2.x, v2.y, v3.x, v3.y);
  stroke(255, 0, 0);
  line(0, 0, v3.x, v3.y);
  noStroke();
  fill(0);
  ellipse(v3.x, v3.y, 10, 10);
  popMatrix();
  
  
  fill(0);
  text("v1: (" + v1.x + ", " + v1.y + ") " + v1.mag(), 20, 20);
  text("v2: (" + v2.x + ", " + v2.y + ") " + v2.mag(), 20, 40);
  text("dot1: " + dot1, 20, 60);
  text("dot2: " + dot2, 20, 80);
  text("dot3: " + dot3, 20, 100);
  text("dot4: " + dot4, 20, 120);
}
void changeVector(){
  v1 = new PVector();
  v1.x = round(100 * cos(angle));
  v1.y = round(100 * sin(angle));
  angle += .05;
}