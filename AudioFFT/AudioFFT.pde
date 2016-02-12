import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;

Minim minim;
AudioPlayer player;
FFT fft;
IIRFilter filter;
//PShader shader;

void setup() {
  size(1024, 512);
  minim = new Minim(this);
  player = minim.loadFile("bb.mp3", 2048);
  filter = new LowPassSP(1024, player.sampleRate());
  player.addEffect(filter);
  player.play();
  fft = new FFT(player.bufferSize(), player.sampleRate());
  //shader = loadShader("example3.glsl");
}

void draw() {

  float red = 255 * player.mix.level();
  background(red, 0, 0);
  //shader.set("rotateAmount", .1f * player.mix.level());
  //filter(shader);
  
  
  stroke(255);
  filter.setFreq(map(mouseY, 0, height, 2000, 0));
  
  // DRAW FFT:
  fft.forward(player.mix);
  for(int i = 0; i < fft.specSize(); i++){
    line(i, 200, i, 200 - fft.getBand(i) * 4);
  }
  
  float spread = map(mouseX, 0, width, 1, 21.5);
  float x = 0;
  for(int i = 0; i < player.sampleRate() && x <= width; i += spread){
    x = i/spread;
    line(x, 200, x, 200 + fft.getFreq(i) * 4);
  }
  
  
  // DRAW WAVE FORM:
  for(int i = 0; i < player.bufferSize() - 1 && i < width; i++){
    float y1 = 50 + player.mix.get(i) * 50;
    float y2 = 50 + player.mix.get(i+1) * 50;
    line(i, y1, i+1, y2);
  }
  
}

