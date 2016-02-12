
PImage img;
PShader shader;

void setup() {
  size(800, 400, P2D);
  img = loadImage("trogdor.png");
  shader = loadShader("blur.glsl");
  background(0);
}

void draw() {
  //background(0);

  image(img, mouseX, mouseY);

  stroke(0, 0, 255);
  line(0, 0, 100, 100);

  filter(shader);
}

