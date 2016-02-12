PImage img;

PShader shader1;
PShader shader2;
PGraphics buffer;

void setup(){
  size(800, 400, P2D);
  shader1 = loadShader("bloom1.glsl");
  //shader2 = loadShader("bloom2.glsl");
  
  img = loadImage("trogdor.png");
  buffer = createGraphics(img.width, img.height, P2D);
}
void draw(){
  background(0);
  
  shader1.set("brightPassThreshold", map(mouseX, 0, width, 0, 1));
  
  buffer.beginDraw();
  buffer.background(0);
  buffer.shader(shader1);
  buffer.image(img, 0, 0);
  buffer.resetShader();
  buffer.filter(BLUR, 6);
  buffer.endDraw();
  
  image(img, 0, 0);
  blendMode(ADD);
  image(buffer, 0, 0);
  blendMode(NORMAL);
}
