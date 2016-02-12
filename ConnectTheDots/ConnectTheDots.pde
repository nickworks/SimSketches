// CLICK : spawn particles

// This sketch is a simple example of drawing lines
// between particles. This is purely an example of
// aesthetics.

// The particles calculate steering force towards a
// random point (each particle has their own). The
// random point has a speed that is always changing.

ArrayList<Agent> agents = new ArrayList<Agent>();

void setup() {
  size(800, 480);
}
void draw() {
  background(0);
  for (int i = 0; i < agents.size(); i++) {
    Agent agent = agents.get(i);
    agent.update();
    agent.draw();
    if (agent.dead) agents.remove(agent);
  }
  for (Agent a1 : agents) {
    if(a1.tagged) continue;
    for (Agent a2 : agents) {
      if(a2.tagged) continue;
      if(a1 != a2){
        if(abs(a1.position.x - a2.position.x) < 200 && abs(a1.position.y - a2.position.y) < 200){
          float d = PVector.sub(a1.position, a2.position).mag(); 
          if(d < 200){
            stroke(255, 255*(200-d)/200);
            line(a1.position.x, a1.position.y, a2.position.x, a2.position.y);
          }
        }
      }
    }
    a1.tagged = true;
  }
}
void mousePressed() {
  agents.add(new Agent(mouseX, mouseY));
}