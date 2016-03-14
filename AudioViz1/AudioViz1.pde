import ddf.minim.*;

Minim minim;
AudioPlayer player;
PShader shader;
int hue = 0;

void setup() {
  size(800, 800, P2D);
  background(0);
  minim = new Minim(this);
  player = minim.loadFile("song.mp3", 2048);
  player.play();
  shader = loadShader("example3.glsl");
}

void draw() {
  shader.set("rotateAmount", .01);
  shader.set("zoomAmount", map(mouseY, 0, height, .99, .95));
  filter(shader);

  colorMode(HSB);
  hue += 2;
  float tempHue = hue + player.mix.level() * 720;
  while(tempHue >= 360) tempHue -= 360;
  stroke(tempHue, 255, 255);
  noFill();

  float offset = map(mouseX, 0, width, 0, 25);

  beginShape();
  for (int i = 0; i < 360; i ++) {
    float radius = 100 * player.mix.level() + player.mix.get(i) * 100;
    float angle = radians(i * offset);
    float x = width/2 + radius * cos(angle);
    float y = height/2 + radius * sin(angle);
    vertex(x, y);
  }
  endShape();
}