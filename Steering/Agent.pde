class Agent {

  float maxSpeed = 5;
  float maxForce = 10;
  float mass = 10;
  PVector position = new PVector();
  PVector velocity = new PVector();
  PVector acceleration = new PVector();
  PVector force = new PVector();

  PVector targetOffset = new PVector();
  PVector prevPosition = new PVector();
  color tint;

  Agent() {
    // set properties to random values:
    position.x = random(width);
    position.y = random(height);
    mass = random(10) + 5;
    maxSpeed = random(5) + 1;
    maxForce = random(2) + random(2);
    // agents move to mouse position + targetOffset.
    // targetOffset is a random PVector. This is so all
    // the agents don't try to cluster right at the
    // mouse position
    targetOffset.x = random(400) - 200;
    targetOffset.y = random(400) - 200;
    // set prevPosition to starting position, so all Agents don't draw a line to 0,0:
    prevPosition = position.get();
    // set color mode to HSB (hue, saturation, brightness):
    colorMode(HSB);
    // get a random color:
    tint = color(random(360), 255, 255);
  }
  void Draw() {
    
    // direction the agent is facing (If you want them to point
    //  in the direction they're moving. Currently this is
    //  unneccessary because the agents are just drawing lines
    //  as they move...):
    //float rotation = velocity.heading(); // same as atan2(velocity.y, velocity.x);
    
    stroke(tint);
    strokeWeight(3);
    line(prevPosition.x, prevPosition.y, position.x, position.y);    
    prevPosition = position.get();
  }
  void Update() {
    resetValues(); // reset force & acceleration
    rotateTargetOffset(); // rotate target position
    steer(); // steering algorithm
    force.div(mass); // divide force by mass. (f = ma ... a = f/m)
    acceleration.add(force); // set acceleration to f/m (a = f/m)
    velocity.add(acceleration); // add acceleration to current velocity
    position.add(velocity); // add speed to current position
  }
  void rotateTargetOffset(){
    // Rotate the targetOffset. This makes the Agents rotate around
    // the mouse instead of just sitting at a stationary targetOffset
    // position near the mouse.
    float mag = targetOffset.mag();
    float angle = targetOffset.heading();// same as atan2(targetOffset.y, targetOffset.x);
    angle += .05;
    targetOffset.x = mag * cos(angle);
    targetOffset.y = mag * sin(angle);
  }
  void resetValues() {
    // Reset force and acceleration to zero every update!
    force.mult(0);
    acceleration.mult(0);
  }
  void steer() {
    // Steering algorithm calculates and adds steering force
    PVector target = new PVector(mouseX, mouseY);
    PVector dir = PVector.sub(target, position); // vector to mouse
    dir.add(targetOffset); // distance to targetOffset. comment out to have Agents chase mouse
    dir.limit(maxSpeed); // limit vector magnitude equal to maxSpeed
    
    PVector force = PVector.sub(dir, velocity); // calculate force by subtracting the current speed from the desired speed
    //f.limit(maxForce); // limit force to maxForce
    force.mult(.2);
    addForce(force);
  }
  void addForce(PVector f) {
    // Add vector f to force property
    force.add(f);
  }
}

