// Animate 3 electrons orbiting around a nucleus.
// Each electron should follow a path and match
// colors with its respective path.
// To mathematically determine the position of
// the electrons, look at the example electron.
// Notice that before we translate it (add 200
// to x and 200 to y), it is orbiting the origin.
// Its position is a vector, so we can easily get
// its magnitude and angle from the origin.
// Once we have the angle, it should be obvious
// that we need to modify the angle then
// recalculate x and y from angle and magnitude.
// Finally, you would translate it 200, 200.
// Do all of this with trigonometry and Vectors.

void setup(){
  size(400, 400);
}
void draw(){
  background(0);
  drawAtomBG();
  ///////////////// START HOMEWORK CODE HERE:
  
  noStroke();
  float time = (float)millis()/1000;
  
  PVector e1 = new PVector();
  e1.x = 150 * cos(time);
  e1.y = 50 * sin(time);
  fill(255,100,100);
  ellipse(e1.x + 200, e1.y + 200, 20, 20);
  ellipse(-e1.x + 200, -e1.y + 200, 20, 20);
  
  PVector e2 = new PVector();
  e2.x = 150 * cos(time);
  e2.y = 50 * sin(time);
  float rad2 = atan2(e2.y, e2.x) + PI / 3;
  float mag2 = sqrt(e2.x * e2.x + e2.y * e2.y); 
  e2.x = mag2 * cos(rad2);
  e2.y = mag2 * sin(rad2);
  fill(100,100,255);
  ellipse(e2.x + 200, e2.y + 200, 20, 20);
  ellipse(-e2.x + 200, -e2.y + 200, 20, 20);
  
  PVector e3 = new PVector();
  e3.x = 150 * cos(time);
  e3.y = 50 * sin(time);
  float rad3 = atan2(e3.y, e3.x) - PI / 3;
  float mag3 = sqrt(e3.x * e3.x + e3.y * e3.y); 
  e3.x = mag3 * cos(rad3);
  e3.y = mag3 * sin(rad3);
  fill(100,255,100);
  ellipse(e3.x + 200, e3.y + 200, 20, 20);
  ellipse(-e3.x + 200, -e3.y + 200, 20, 20);
  
  
  ///////////////// END HOMEWORK CODE HERE
  
}
void drawAtomBG(){
  noStroke();
  fill(255);
  ellipse(200,200,50,50);
  noFill();
  strokeWeight(5);
  
  pushMatrix();
  translate(200,200);
  stroke(255,100,100);
  ellipse(0,0,300,100);
  popMatrix();
  
  pushMatrix();
  translate(200,200);
  rotate(PI/1.5);
  stroke(100,255,100);
  ellipse(0,0,300,100);
  popMatrix();
  
  pushMatrix();
  translate(200,200);
  rotate(2*PI/1.5);
  stroke(100,100,255);
  ellipse(0,0,300,100);
  popMatrix();
}