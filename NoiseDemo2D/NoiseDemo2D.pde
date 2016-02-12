
PImage img;
int colorFunc = 1;
float noiseScale = 30;
float threshold = .6;
float time = 0;
PVector offset = new PVector();

void setup() {
  size(500, 500, P3D);
  img = createImage(width, height, RGB);
  drawNoise2D();
}
void draw() {
  boolean regen = false;
  int nextColorFunc = colorFunc;
  if (Keys.N1()) nextColorFunc = 1; 
  if (Keys.N2()) nextColorFunc = 2; 
  if (Keys.N3()) nextColorFunc = 3; 
  if (Keys.N4()) nextColorFunc = 4; 
  if (Keys.N5()) nextColorFunc = 5;
  if (Keys.N6()) nextColorFunc = 6;
  if (nextColorFunc != colorFunc) {
    colorFunc = nextColorFunc;
    regen = true;
  }
  float speed = 10/noiseScale;
  if (Keys.LEFT()) {
    offset.x -= speed;
    regen = true;
  }
  if (Keys.RIGHT()) {
    offset.x += speed;
    regen = true;
  }
  if (Keys.UP()) {
    offset.y -= speed;
    regen = true;
  }
  if (Keys.DOWN()) {
    offset.y += speed;
    regen = true;
  }
  if (Keys.PAGE_UP()) {
    offset.z -= speed;
    regen = true;
  }
  if (Keys.PAGE_DOWN()) {
    offset.z += speed;
    regen = true;
  }
  if (Keys.BRACKET_LEFT()) {
    threshold -= .01;
    regen = true;
  }
  if (Keys.BRACKET_RIGHT()) {
    threshold += .01;
    regen = true;
  }
  if(regen) drawNoise2D();
  background(0);
  image(img, 0, 0);
}

void drawNoise2D() {
  noiseDetail(8);
  img.loadPixels();
  int i = 0;
  float halfW = img.width/2;
  float halfH = img.height/2;
  
  for (int y = 0; y < img.height; y++) {
    for (int x = 0; x < img.width; x++) {
      float n = noise((x - halfW)/noiseScale + offset.x, (y - halfH)/noiseScale + offset.y, offset.z);
      switch(colorFunc) {
      case 1: 
        img.pixels[i] = color1(n);
        break;
      case 2: 
        img.pixels[i] = color2(n);
        break;
      case 3: 
        img.pixels[i] = color3(0, n);
        break;
      case 4: 
        img.pixels[i] = color4(n);
        break;
      case 5: 
        img.pixels[i] = color5(n);
        break;
      case 6: 
        img.pixels[i] = color6(n);
        break;
      }
      i++;
    }
  }
  img.updatePixels();
}
color color1(float n) {
  return color(255 * n);
}
color color2(float n) {
  n = abs((n - .5) * 2);
  return color(255 * n);
}
color color3(int x, float n) {
  n = sin(x/30.0 + 1/n) / 2.0 + .5;
  return color(255 * n);
}
color color4(float n) {
  colorMode(HSB);
  return color(360 * n, 255, 255);
}
color color5(float n) {
  colorMode(HSB, 360, 100, 100);

  n *= .8;

  float h = 180;
  float s = 100;
  float b = 100;

  if (n < .5) { // water:
    n *= 2;
    h = 225 - 60 * pow(n - .1, 6);
    b = 100 * pow(n, 5);
    if (b < 70) b = 70 - map(n, 0, 1, 20, 0);
    s = 80;
  } else {
    n = (n - .5) * 2;
    h = map(n, 0, .2, 180, 100);
    if (h < 80) h = 80;
    b = map(n, 0, 1, 70, 30);
    s = map(n, 0, .5, 70, 20);
  }
  return color(h, s, b);
}
color color6(float n) {
  return n > threshold ? color(255) : color(0);
}

