PImage img;
PShader shader;

void setup() {
  size(800, 400, P2D);
  img = loadImage("trogdor.png");
  shader = loadShader("zoom.glsl");
}
void draw() {
  image(img, mouseX, mouseY);
  filter(shader);
}

