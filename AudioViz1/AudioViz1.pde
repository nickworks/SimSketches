import ddf.minim.*;

Minim minim;
AudioPlayer player;
PShader shader;

ArrayList<Integer> taps = new ArrayList<Integer>();
float bpm = 60;
int beat = 1;
int lastBeat = 0;
boolean showTimer = false;
int hue = 0;

void setup() {
  size(800, 800, P2D);
  minim = new Minim(this);
  player = minim.loadFile("song.mp3", 2048);
  player.play();
  shader = loadShader("example3.glsl");
}

void draw() {
  //background(0);
  shader.set("rotateAmount", .01);
  shader.set("zoomAmount", map(mouseY, 0, height, .99, .95));
  filter(shader);

  if (millis() > lastBeat + bpm) {
    lastBeat = millis();
    beat ++;
    if(showTimer) println("Beat " + beat);
    if (beat > 4) {
      beat = 1;
      hue += 80;
      while(hue > 360) hue -= 360;
      if(showTimer) println("next measure. hue: " + hue);
    }
  }

  colorMode(HSB);
  hue += 2;
  float tempHue = hue + player.mix.level() * 720;
  while(tempHue >= 360) tempHue -= 360;
  stroke(tempHue, 255, 255);
  //stroke(hue, 255, 255);
  noFill();

  float sampleIncr = player.bufferSize() / 360;
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
  //output();
}
void keyPressed() {
  if(keyCode == 32){
    taps.add(millis());
    if (taps.size() > 8) taps.remove(0);
    float bpmtemp = 0;
    for (int i = 1; i < taps.size(); i++) {
      bpmtemp += taps.get(i) - taps.get(i - 1);
    }
    bpm = bpmtemp / (taps.size() - 1);
    println(bpm);
    lastBeat = millis();
    beat = 1;
  }
  if(keyCode == 40){
    showTimer = !showTimer;
  }
}
int frame = 0;
void output(){
  frame++;
  save("render/tunnel_"+frame+".png");
}

