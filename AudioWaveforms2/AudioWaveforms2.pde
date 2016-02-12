import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;

Minim minim;
AudioPlayer player;
IIRFilter filter;

int hue = 0;
int sampleSize = 2048;
int scale = 20;
float[] yValuesPrev;

void setup() {
  size(2048, 400);
  minim = new Minim(this);
  player = minim.loadFile("song.mp3", sampleSize);
  filter = new LowPassSP(60, player.sampleRate());
  player.addEffect(filter);
  player.play();

  yValuesPrev = new float[sampleSize];
  colorMode(HSB);
  noFill();
  strokeWeight(2);
}

void draw() {
  background(0);

  filter.setFreq(map(mouseY, 0, height, 2000, 0));

  hue += 2;
  while (hue >= 360) hue -= 360;
  stroke(hue, 255, 255);

  int stepForward = sampleSize / scale;
  int max = yValuesPrev.length - stepForward;
  for (int i = 0; i < max; i++) {
    yValuesPrev[i] = yValuesPrev[i+stepForward];
  }

  float baseY = height/2;
  int x = 0;
  for (int i = 0; i < player.bufferSize (); i+=scale) {
    float y = baseY + player.mix.get(i) * 100;

    if (max + x < yValuesPrev.length - 1) {
      yValuesPrev[max + x] = y;
    } else {
      yValuesPrev[yValuesPrev.length - 1] = y;
    }
    x++;
  }
  beginShape();
  for (int i = 0; i < yValuesPrev.length; i++) {
    vertex(i, yValuesPrev[i]);
  }
  endShape();
}

