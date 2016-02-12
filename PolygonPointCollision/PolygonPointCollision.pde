
Polygon polygon;
boolean grow = true;

void setup(){
  size(800, 400);
  polygon = new Polygon(new PVector(width/2, height/2));
  polygon.scale = 50;
  polygon.addPoint(1.5, -.5);
  polygon.addPoint(1, .5);
  polygon.addPoint(0, .5);
  polygon.addPoint(-2, 0);
  polygon.addPoint(0, -2);
}
void draw(){
  background(0);
  if(grow){
     polygon.scale += .1;
     if(polygon.scale > 100) grow = false;
  } else {
    polygon.scale -= .1;
     if(polygon.scale < 50) grow = true;
  }
  polygon.rotation += .01;
  polygon.update();
  polygon.colliding = polygon.checkCollisionWithPoint(new PVector(mouseX, mouseY));
  polygon.draw();  
}

void keyPressed(){
  if(keyCode == 78) polygon.showDebug = !polygon.showDebug; 
}

