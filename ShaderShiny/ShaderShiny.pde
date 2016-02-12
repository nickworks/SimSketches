PShader shader;
void setup(){
  size(800, 480, P2D);
  shader = loadShader("thingy.glsl");
  shader.set("ratio", (float)width/height);
}
void draw(){
  
  shader.set("position", (float)mouseX/width, (float)mouseY/height);
  
  background(0);
  filter(shader);
}
