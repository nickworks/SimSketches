
float zoom = 2;

void setup(){
  size(800, 400);
  background(0);
  stroke(255);
}

void draw(){
  background(0);
  zoom = map(mouseX, 0, width, 2, 100);
  drawGraphs();
}

void drawGraphs(){
  drawWave(75);
  drawRandom(150);
  drawNoise(275);
}

void drawWave(float baseline){
  float prevY = 0;
  for(int x = 0; x < width; x++){
    float y = sin(x/zoom) * 50 + baseline;
    if(x > 0) line(x - 1, prevY, x, y);
    prevY = y;
  }
}
void drawRandom(float baseline){
  float prevY = 0;
  for(int x = 0; x < width; x++){
    float y = random(1) * 100 + baseline;
    if(x > 0) line(x - 1, prevY, x, y);
    prevY = y;
  }
}
void drawNoise(float baseline){
  float prevY = 0;
  for(int x = 0; x < width; x++){
    float y = noise(x/zoom) * 100 + baseline;
    if(x > 0) line(x - 1, prevY, x, y);
    prevY = y;
  }
}

