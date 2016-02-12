
PImage img;
PShader shader;

void setup() {
  size(800, 400, P2D);
  img = loadImage("trogdor.png");
  shader = loadShader("desat.glsl");
}

void draw() {
  background(0);
  
  shader.set("desatAmount", map(mouseX, 0, width, 0, 1));
  
  image(img, mouseX, mouseY);
  
  stroke(0, 0, 255);
  line(0,0, 100, 100);
  
  filter(shader);
}

