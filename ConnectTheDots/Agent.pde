public class Agent {
  boolean dead = false;
  PVector velocity = new PVector();
  PVector position = new PVector();
  PVector acceleration = new PVector();
  float maxSpeed = 5;
  float maxForce = .2;
  float mass = random(5) + 1;
  PVector target = position.get();
  PVector targetSpeed = new PVector();
  int counter = 0;
  boolean tagged = false;

  boolean showTarget = false;

  public Agent(int X, int Y) {
    position.x = X;
    position.y = Y;
    float x = random(1) - random(1);
    float y = random(1) - random(1);
    PVector offset = new PVector(x * 100, y * 100);
    target = PVector.add(position, offset);
  }
  public void update() {
    tagged = false;
    if (position.x > width + 200 || position.x < -200) dead = true;
    if (position.y > height + 200 || position.y < -200) dead = true;

    if (counter <= 0) {
      float x = random(1) - random(1);
      float y = random(1) - random(1);
      targetSpeed = new PVector(x * random(2, 5), y * random(2, 5));
      counter = (int)random(60) + (int)random(60);
    } 
    else {
      counter --;
    }

    target.add(targetSpeed);

    steer(PVector.sub(target, position)); // steering algorithm
  }
  public void steer(PVector f) {
    acceleration.mult(0);
    f.normalize();
    f.mult(maxSpeed);
    f.sub(velocity);
    f.limit(maxForce);
    f.div(mass); // divide force by mass. (f = ma ... a = f/m)
    acceleration.add(f); // set acceleration to f/m (a = f/m)
    velocity.add(acceleration); // add acceleration to current velocity
    position.add(velocity); // add speed to current position
  }
  public void draw() {
    noStroke();
    fill(255);
    ellipse(position.x, position.y, 10, 10);
    if (showTarget) ellipse(target.x, target.y, 2, 2);
  }
}

