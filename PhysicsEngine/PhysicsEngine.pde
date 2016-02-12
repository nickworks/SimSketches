// CLICK : add new boxes
// LEFT / RIGHT : apply horizontal force
// UP : apply vertical force

import org.jbox2d.common.*;
import org.jbox2d.collision.*;
import org.jbox2d.callbacks.*;
import org.jbox2d.dynamics.*;

float zoom = 20;

float timeStep = 1/60.0;
World world;
Camera camera;
Body player;

boolean keyL = false;
boolean keyU = false;
boolean keyR = false;
boolean keyD = false;

void setup() {
  size(800, 480); 

  camera = new Camera();
  world = new World(new Vec2(0, 50), true);

  MakeABox(new Vec2( 10, 10), 50, 10, true);
  MakeABox(new Vec2( 10, -40), 50, 10, true);
  MakeABox(new Vec2( 55,-19), 5, 20, true);
  MakeABox(new Vec2(-35,-19), 5, 20, true);
  player = MakeABox(new Vec2(10, 0), 1, 1, false);
  player.setAngularVelocity(1);
}
void draw() {

  // UPDATE:
  camera.update(player.getPosition());
  
  world.step(timeStep, 10, 10);
  if(keyL) player.applyForce(new Vec2(-1000, 0), player.getPosition());
  if(keyR) player.applyForce(new Vec2(1000, 0), player.getPosition());
  if(keyU) player.applyForce(new Vec2(0, -1000), player.getPosition());

  // DRAW:
  background(0);
  pushMatrix();
  applyMatrix(camera.matrix);

  for (Body body = world.getBodyList(); body != null; body = body.getNext()) {
    DrawPolygonShapeFromBody(body);
  }

  popMatrix();
}


Body MakeABox(Vec2 pos, float w, float h, boolean fixed) {

  BodyDef def = new BodyDef();
  def.type = fixed ? BodyType.STATIC : BodyType.DYNAMIC;
  def.position = pos;

  Body body = world.createBody(def);

  PolygonShape shape = new PolygonShape();
  shape.setAsBox(w, h);

  FixtureDef fixture = new FixtureDef();
  fixture.shape = shape;
  fixture.density = 1;
  fixture.friction = .25;
  fixture.restitution = 0;

  body.createFixture(fixture);

  return body;
}

void DrawPolygonShapeFromBody(Body body) {
  // drawing code!
  pushMatrix();
  Vec2 pos = body.getPosition();
  translate(pos.x, pos.y);
  rotate(body.getAngle());

  fill(body.isAwake() ? 255 : 128);
  noStroke();

  Fixture f = body.getFixtureList();
  PolygonShape ps = (PolygonShape) f.getShape();

  if (body == player) fill(255, 255, 0);
  beginShape();
  for (int i = 0; i < ps.getVertexCount(); i++) {
    Vec2 v = ps.getVertex(i);
    vertex(v.x, v.y);
  }
  endShape();
  popMatrix();
}

void mousePressed() {
  PVector t = new PVector();
  camera.tmatrix.mult(new PVector(mouseX, mouseY), t);
  MakeABox(new Vec2(t.x, t.y), random(2) + 2, random(2) + 2, false);
}

void keyPressed() {
  if (keyCode == 37) keyL = true;
  if (keyCode == 38) keyU = true;
  if (keyCode == 39) keyR = true;
  if (keyCode == 40) keyD = true;
}
void keyReleased() {
  if (keyCode == 37) keyL = false;
  if (keyCode == 38) keyU = false;
  if (keyCode == 39) keyR = false;
  if (keyCode == 40) keyD = false;
}