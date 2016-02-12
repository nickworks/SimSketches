
PImage img;
PShader shader;

void setup() {
  size(800, 400, P2D);
  img = loadImage("trogdor.png");
  shader = loadShader("simpleFrag.glsl", "simpleVert.glsl");
}

void draw() {
  background(0);
  shader(shader);
  float time = millis()/1000.0;
  shader.set("time", time); 
  image(img, mouseX, mouseY);
  resetShader();
}

