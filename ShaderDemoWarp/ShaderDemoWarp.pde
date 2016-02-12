
PImage img;
PShader shader;
float ringSize = 0;
boolean ringGrow = true;

void setup() {
  size(800, 400, P2D);
  img = loadImage("trogdor.png");
  shader = loadShader("warp.glsl");
}
void draw() {
  background(0);
  shader.set("resolution", (float)width, (float)height);
  shader.set("ringSize", ringSize);//map(mouseY, 0, height, 0, 1));
  shader.set("ringWidth", map(mouseY, 0, height, 1, 20));
  shader.set("ringMag", map(mouseX, 0, width, 0, 2));

  if (ringGrow) {
    if (ringSize < 2) ringSize += .02;
    else ringGrow = false;
  }
  else {
    if (ringSize > 0) ringSize -= .02;
    if (ringSize < 0) {
      ringSize = 0;
      ringGrow = true;
    }
  }

  image(img, 50, 30);
  image(img, 260, 30);
  image(img, 470, 30);
  filter(shader);
}

