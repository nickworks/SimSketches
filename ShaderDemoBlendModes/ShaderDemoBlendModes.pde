/*
Check out all these blending modes programmed in blend.glsl.
Use the left and right arrow keys to change blending modes.
*/

PImage img1;
PImage img2;
PShader shader;
int blendMode = 0;

void setup() {
  size(400, 400, P2D);
  img1 = loadImage("img1.png");
  img2 = loadImage("img2.png");
  shader = loadShader("blend.glsl");
  shader.set("texture2", img2);
}
void draw() {
  background(0);
  shader.set("blendMode", blendMode);
  shader(shader);
  image(img1, 0, 0);
}
void keyPressed() {
  if (keyCode == 37) blendMode --;
  if (keyCode == 39) blendMode ++;
  if(blendMode < 0) blendMode = 10;
  if(blendMode > 10) blendMode = 0;
}

