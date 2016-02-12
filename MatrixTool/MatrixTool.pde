// This sketch serves as an interactive and visual learning tool for matrices.
// I've written a custom TextField class that allows users to change values
// in the transform matrix at run time.

PMatrix2D matrix = new PMatrix2D();
PImage img;

TextField tf1 = new TextField("", 050, 20, 0.05);
TextField tf2 = new TextField("", 100, 20, 0.05);
TextField tf3 = new TextField("", 160, 20, 1.5);
TextField tf4 = new TextField("", 050, 50, 0.05);
TextField tf5 = new TextField("", 100, 50, 0.05);
TextField tf6 = new TextField("", 160, 50, 1.5);

void setup() {
  size(400, 400);
  img = loadImage("neo.png");
  fill(0);
  matrix.m00 = 1.0;
  matrix.m01 = 0.0;
  matrix.m02 = 100;
  matrix.m10 = 0.0;
  matrix.m11 = 1.0;
  matrix.m12 = 150;

  UpdateFields();
}
void draw() {
  background(255);

  try {
    drawStuff();
  } 
  catch (Exception e){
    // the matrix was invalid, so it threw a runtime error.
    // we caught the runtime error, preventing the program from crashing.
    // we have to pop the matrix that was being used when the exception was thrown:
    popMatrix();
  }

  tf1.draw();
  tf2.draw();
  tf3.draw();
  tf4.draw();
  tf5.draw();
  tf6.draw();
}
void drawStuff() {
  pushMatrix();
  applyMatrix(matrix);

  noFill();
  for (int x = -500; x < 500; x += 50) {
    if (x == 0) {
      stroke(0);
      strokeWeight(2);
    } else {
      stroke(0, 0, 0, 128);
      strokeWeight(1);
    } 
    line(x, -500, x, 500);
  }
  for (int y = -500; y < 500; y += 50) { 
    if (y == 0) {
      stroke(0);
      strokeWeight(2);
    } else {
      stroke(0, 0, 0, 128);
      strokeWeight(1);
    } 
    line(-500, y, 500, y);
  }
  image(img, 0, 0);
  popMatrix();
}
void UpdateMatrix() {

  if (tf1.num != 0 || tf2.num != 0) matrix.m00 = tf1.num;
  if (tf1.num != 0 || tf2.num != 0) matrix.m01 = tf2.num;
  matrix.m02 = tf3.num;
  if (tf4.num != 0 || tf5.num != 0) matrix.m10 = tf4.num;
  if (tf4.num != 0 || tf5.num != 0) matrix.m11 = tf5.num;
  matrix.m12 = tf6.num;
}
void UpdateFields() {
  tf1.setNum(matrix.m00);
  tf2.setNum(matrix.m01);
  tf3.setNum(matrix.m02);
  tf4.setNum(matrix.m10);
  tf5.setNum(matrix.m11);
  tf6.setNum(matrix.m12);
}
void mousePressed() {
  tf1.mousePressed();
  tf2.mousePressed();
  tf3.mousePressed();
  tf4.mousePressed();
  tf5.mousePressed();
  tf6.mousePressed();
}
void mouseReleased() {
  tf1.mouseReleased();
  tf2.mouseReleased();
  tf3.mouseReleased();
  tf4.mouseReleased();
  tf5.mouseReleased();
  tf6.mouseReleased();
}
/*
void keyPressed() {
 println(keyCode);
 tf1.keyPressed();
 tf2.keyPressed();
 tf3.keyPressed();
 tf4.keyPressed();
 tf5.keyPressed();
 tf6.keyPressed();
 UpdateMatrix();
 }*/
