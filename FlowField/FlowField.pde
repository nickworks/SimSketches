// CLICK : spawn particles
// P : turn on/off paths
// SPACE : show/hide flow field
// LEFT / RIGHT : change resolution
// UP / DOWN : zoom in/out perlin noise

// This sketch is an example of a flow field implementation. Perlin
// noise is used to generate a grid of direction vectors. The vectors
// are stored in a 2D array for easy look-up. Every update the particles
// use their position to look-up which vector they are "closest" to. The
// particles then calculate steering force to match the vector's direction.


float zoom = 10;
FlowNode[][] nodes;
ArrayList<Agent> agents = new ArrayList<Agent>();
PGraphics buffer;
boolean showPaths = false;
boolean showField = false;

int sze = 50;
int size2 = 25;
int cols = 10;
int rows = 10;
int flow = 0;
float timerFlow = 0;
float time = 0;

void setup() {
  size(800, 800);
  buffer = createGraphics(width, height);
  generateField();
}
void draw() {
  
  background(0);
  
  float current = millis()/1000.0;
  float dt = current - time;
  time = current;
  
  if(timerFlow > 0) timerFlow -= dt; 
  if (mousePressed) {
    if(timerFlow <= 0){
      Agent agent = new Agent();
      agents.add(agent);
      agent.position = new PVector(mouseX, mouseY);
      timerFlow = flow/10.0;
    }
  }
  if (showField) {
    for (FlowNode[] row : nodes) {
      for (FlowNode node : row) {
        node.draw();
      }
    }
  }
  buffer.beginDraw();
  if (!showPaths) buffer.background(0, 0);
  for (int i = 0; i < agents.size(); i++) {
    Agent agent = agents.get(i);
    agent.update();
    agent.draw();
    if (agent.dead) {
      agents.remove(agent);
      i--;
    }
  }
  buffer.endDraw();
  if (showPaths) image(buffer, 0, 0);
  fill(255);
  text("zoom: x" + (int) zoom + "\ncell size: " + (int) sze + "px\n" + (int)frameRate + "fps\nflow delay: " + flow, 20, 20);
}

void generateField() {

  cols = int(width / sze);
  rows = int(height / sze);
  size2 = int(sze/2);

  nodes = new FlowNode[rows][cols];
  for (int Y = 0; Y < rows; Y ++) {
    //FlowNode[] row = FlowNode[cols];
    for (int X = 0; X < cols; X ++) {
      float angle = noise(X/zoom, Y/zoom) * (float) Math.PI * 4;
      nodes[Y][X] = new FlowNode(new PVector(X * sze + size2, Y * sze + size2), angle);
    }
  }
}
PVector getFlowAt(PVector p) {

  int x = (int)(p.x/sze);
  int y = (int)(p.y/sze);

  if (x < 0 || y < 0) return new PVector();
  if (x >= cols || y >= rows) return new PVector();

  return nodes[y][x].direction.get();
}
void keyPressed() {
  //println(keyCode);
  if (keyCode == 32) showField = !showField;
  if (keyCode == 80) showPaths = !showPaths;
  if (keyCode == 38) zoom ++;
  if (keyCode == 40) zoom --;
  if (keyCode == 37) sze --;
  if (keyCode == 39) sze ++;
  if (zoom < 1) zoom = 1;
  if (zoom > 100) zoom = 100;
  if (sze < 15) sze = 15;
  if (sze > 100) sze = 100;
  generateField();
}
void mouseWheel(MouseEvent event){
  flow += event.getCount();
  if(flow < 0) flow = 0;
  if(flow > 10) flow = 10;
}
int frame = 0;
void output(){
  frame++;
 save("render/steering_"+frame+".png"); 
}