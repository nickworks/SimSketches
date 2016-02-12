
Camera cam = new Camera();
void setup(){
  size(800, 500, P3D);
}

void draw(){
  background(0);
  
  cam.update();
  pushMatrix();
  translate(400, 0, 0);
  rotateX(millis()/1000.0);
  box(50,50,50);
  popMatrix();
  box(50,50,50);
}
