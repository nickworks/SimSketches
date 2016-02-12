
ArrayList<Agent> agents = new ArrayList<Agent>();

void setup() {
  size(800, 400, P2D);
  for(int i = 0; i < 20; i ++) agents.add(new Agent()); 
  background(0);
  smooth(8);
}
void draw() {
  fade();
  for(Agent a : agents){
    a.Update();
    a.Draw();
  }
}
void fade(){
  noStroke();
  fill(0,0,0,10);
  rect(0,0,width,height);
}