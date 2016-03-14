/*
Copyright Nick Pattison 2015, 2016
This sketch is a fun, interactive music visualizer!
While the music is playing, wiggle the mouse around the screen to affect the rotation and scale of the pattern of dots.
Use the LEFT and RIGHT arrows to adjust how fast the dots are spinning. Have fun!
*/

import ddf.minim.*;
import ddf.minim.analysis.*;

boolean manualMode = false;
ArrayList<PVector> points = new ArrayList<PVector>();
float scale = 1;
float angle = 0;
int hue = 0;
float speed = 1;
float time;
float level = 0;

AudioPlayer player;

void setup() {
  size(600, 600);
  
  Minim minim = new Minim(this);
  player = minim.loadFile("song.mp3", 1024);
  player.play();
  
  colorMode(HSB);
  noStroke();
 
  makePoints(); 
}
void makePoints(){
  float m = 15;
  float s = 6;
  
  for(int i = 0; i < s; i ++){
    float a = TWO_PI * i / s;
    float x = m * cos(a);
    float y = m * sin(a);
    points.add(new PVector(x, y));
    points.add(new PVector(x * 2, y * 2)); 
  }
}

void draw() {
  
  ///////////////////// UPDATE:
  
  if(Keys.isDown(Keys.LEFT)) speed -= .1;
  if(Keys.isDown(Keys.RIGHT)) speed += .1;
  
  
  level = smoothSignal(player.mix.level(), level, 20);
  time += (0.01 * speed);
  float newScale = (map(mouseY, 0, height, 0, 5) * map(sin(millis()/1000.0), -1, 1, 3, 10) + 20 * player.mix.level()) * (level) * (2 + player.mix.level());
  float newAngle = mouseX / 100.0 + time;// + player.mix.level();

  float intensity = 10 + (int)((scale - newScale) * 20) + player.mix.level() * player.mix.level() * 200;
  float jitter = 0;
  scale = smoothSignal(newScale, scale, 2);
  angle = jitter * random(PI) + newAngle;
  if(jitter > 0) jitter *= .9;
  if(jitter < 0) jitter = 0;
  
  hue += 1;
  while (hue > 255) hue -= 255;
  color drawColor = color(hue, 255, intensity * intensity);

  PMatrix2D matrix = new PMatrix2D();
  matrix.translate(width/2, height/2);
  matrix.rotate(angle);
  matrix.scale(scale);
  
  Keys.update();
  
  ///////////////////// DRAW:
  
  fill(255, 0, 255, 10);
  rect(0, 0, width, height);
  
  for (PVector v : points) { // for every point...
    fill(drawColor);
    PVector t = new PVector();
    matrix.mult(v, t);
    ellipse(t.x, t.y, intensity, intensity);
  }
  
}
float smoothSignal(float newValue, float oldValue, int oldWeight){
    return (newValue + oldValue * oldWeight) / (oldWeight + 1);
}