
PImage img;
PShader shader;

void setup() {
  size(800, 400, P2D);
  img = loadImage("trogdor.png");
  shader = loadShader("desat.glsl");
  shader(shader);
}
void draw() {
  background(0);
  shader.set("desatAmount", map(mouseX, 0, width, 0, 1));
  image(img, mouseX, mouseY);
}

