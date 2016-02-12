import ddf.minim.*;
import ddf.minim.signals.*;

Minim minim;
ArrayList<Wave> waves = new ArrayList<Wave>();
Wave baseWave;
AudioOutput audioOut;

void setup() {
  size(800, 400);
  minim = new Minim(this);
  audioOut = minim.getLineOut(Minim.STEREO);
  baseWave = new Wave(440, .5);
  waves.add(baseWave);
}
void draw() {

  Wave mostRecentWave = waves.get(waves.size() - 1);
  mostRecentWave.SetFreq(map(mouseX, 0, width, 0, 1024));
  mostRecentWave.SetAmplitude(map(mouseY, 0, height, 0, 1));

  background(0);
  fill(255);
  noStroke();
  text("Number of waves:" + waves.size(), 20, 20);
  noFill();

  ArrayList<PVector> points1 = new ArrayList<PVector>(); // mathematical result of wave addition
  ArrayList<PVector> points2 = new ArrayList<PVector>(); // truncated results of wave addition (what we actually hear)

  for (int x = 0; x < width; x++) {
    float amp = 0;
    for (Wave w:waves) {
      amp += sin(x * w.period) * w.amplitude;
    }
    points1.add(new PVector(x, getYForAmp(amp)));
    if(amp > 1) amp = 1;
    if(amp < -1) amp = -1;
    points2.add(new PVector(x, getYForAmp(amp)));
  }

  stroke(255, 100, 0);
  beginShape();
  for (PVector p:points1) vertex(p.x, p.y);
  endShape();

  stroke(255);
  beginShape();
  for (PVector p:points2) vertex(p.x, p.y);
  endShape();
}
float getYForAmp(float amp){
  return amp * 70 + 200;
}
void keyPressed() {
  if (keyCode == 93) {
    float period = random(0, 1024);
    float amplitude = random(0, .3);
    waves.add(new Wave(period, amplitude));
  }
  if (keyCode == 91) {
    if (waves.size() > 1) {
      Wave w = waves.get(waves.size() - 1);
      waves.remove(w);
      w.Dispose();
    }
  }
}

class Wave {
  private float zoom = 1/4000.0;
  private float freq = 0;
  private float amplitude = 1;
  private float period = 0;
  
  SineWave sw;
  Wave(float freq, float amplitude) {
    this.freq = freq;
    this.amplitude = amplitude;
    sw = new SineWave(freq, amplitude, 44100);
    audioOut.addSignal(sw);
    period = freq * zoom;
  }
  void Dispose() {
    audioOut.removeSignal(sw);
  }
  void SetFreq(float freq) {
    this.freq = freq;
    sw.setFreq(freq);
    this.period = freq * zoom;
  }
  void SetAmplitude(float amplitude) {
    this.amplitude = amplitude;
    sw.setAmp(amplitude);
  }
}

