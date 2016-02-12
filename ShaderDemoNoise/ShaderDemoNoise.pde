
PImage img;
PShader shader;

void setup() {
  size(800, 400, P2D);
  shader = loadShader("noise.glsl");
}
void draw() {
  //background(0);
  filter(shader);
}

