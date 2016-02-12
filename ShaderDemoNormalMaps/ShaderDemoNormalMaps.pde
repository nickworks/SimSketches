
PImage img1;
PImage img2;
PShader shader;
float lightZ = .5;

void setup() {

  img1 = loadImage("img1.png");
  img2 = loadImage("img2.png");
  size(img1.width, img1.height, P2D);
  shader = loadShader("normal.glsl");
  shader.set("normals", img2);
  shader.set("Resolution", (float)img1.width, (float)img1.height);
  shader.set("LightColor", 1.0, 0.8, 0.6, 5.0);
  shader.set("AmbientColor", 0.6, 0.6, 1.0, 0.2);
  shader.set("Falloff", 0.4, 3.0, 20.0);
}
void draw() {
  background(0);
  float normalX = map(mouseX, 0, img1.width, 0, 1);
  float normalY = map(mouseY, 0, img1.height, 1, 0);
  shader.set("LightPos", normalX, normalY, lightZ);

  shader(shader);
  image(img1, 0, 0);
}

void keyPressed() {
  if (keyCode == 38 && lightZ > .1) lightZ -= .05;
  if (keyCode == 40 && lightZ < 1) lightZ += .05;
}

