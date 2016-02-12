public class Agent {

  PVector velocity = new PVector();
  PVector position = new PVector();
  PVector acceleration = new PVector();
  PVector force = new PVector();
  float mass = 0;
  float size = 0;
  
  boolean done = false;

  public Agent(float mass) {
    position.x = random(width);
    position.y = random(height);
    this.mass = mass;
    size = log(mass);
  }
  public void update() {
    force.div(mass);
    acceleration.add(force);
    velocity.add(force);
    position.add(velocity);
  }
  public void resetValues() {
    done = false;
    acceleration.mult(0);
    force.mult(0);
  }
  public void addForce(PVector f) {
    force.add(f);
  }
  public void draw() {
    noStroke();
    fill(255);
    ellipse(position.x, position.y, size, size);
  }
}

