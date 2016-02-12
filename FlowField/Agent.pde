public class Agent {

  boolean dead = false;
  PVector position = new PVector();
  PVector lastPosition = new PVector();
  PVector velocity = new PVector(random(4) - 2, random(4) - 2);
  PVector acceleration = new PVector();
  PVector force = new PVector();
  float maxSpeed = 10;
  float maxForce = 1;
  float mass = random(5) + 1;
  color strokeColor1 = 0;
  color strokeColor2 = 0;
  boolean switchColor = false;
  float strokeWeight = 1;

  public Agent() {

    float brightness = 1;
    switch(int(random(3))) {
    case 0:
      brightness = random(1);
      break;
    case 1:
      brightness = random(.5) + random(.5);
      break;
    case 2:
      brightness = random(.1);
      break;
    }

    brightness = 1;

    strokeColor1 = color(random(255) * brightness, random(255) * brightness, random(255) * brightness);
    strokeColor2 = color(random(255) * brightness, random(255) * brightness, random(255) * brightness);

    strokeWeight = random(5) + 1;
    
    velocity = PVector.fromAngle(random(TWO_PI));
    velocity.mult(6);
  }
  public void steer(PVector f) {
    if (f.x == 0 && f.y == 0) dead = true;
    f.mult(maxSpeed);
    f.sub(velocity);
    f.limit(maxForce);
    addForce(f);
  }
  void addForce(PVector f) {
    force.add(f);
  }
  void resetValues() {
    // Reset force and acceleration to zero every update!
    force.mult(0);
    acceleration.mult(0);
  }
  void update() {
    resetValues(); // reset force & acceleration
    lastPosition = position.get();

    steer(getFlowAt(position)); // steering algorithm
    force.div(mass); // divide force by mass. (f = ma ... a = f/m)
    acceleration.add(force); // set acceleration to f/m (a = f/m)
    velocity.add(acceleration); // add acceleration to current velocity
    position.add(velocity); // add speed to current position
  }
  void draw() {
    if (showPaths) {
      //switchColor = !switchColor;
      buffer.stroke(switchColor ? strokeColor1 : strokeColor2);
      buffer.strokeWeight(strokeWeight);
      buffer.line(lastPosition.x, lastPosition.y, position.x, position.y);
    }
    noStroke();
    fill(255);
    ellipse(position.x, position.y, 10, 10);
  }
}

