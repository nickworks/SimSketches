
PImage img;
PShader shader;

void setup() {
  size(800, 400, P2D);
  shader = loadShader("colorFrag.glsl", "colorVert.glsl");
  shader(shader);
}
void draw() {
  background(0);
  ellipse(100, 100, 100, 100);
}

