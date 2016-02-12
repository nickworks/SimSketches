// Universal Gravitation!

ArrayList<Agent> agents = new ArrayList<Agent>();
float G = 1; // gravitational constant
float maxForce = 1;

void setup(){
  size(800, 480);
  for(int i = 0; i < 10; i++){
    agents.add(new Agent(pow(10,(int)random(3) + 1)));
  }
  for(int i = 0; i < 3; i++){
    agents.add(new Agent(100000));
  }
}
void draw(){
  background(0);
  
  for (Agent a : agents) a.resetValues();
  
  for (Agent a1 : agents) {
    for (Agent a2 : agents) {
      if(a1 == a2 || a2.done) continue;
      // F = G*M1*M2/(R*R)
      PVector V = PVector.sub(a2.position, a1.position);

      float magSq = V.x * V.x + V.y * V.y; 
      float M = G * a1.mass * a2.mass / magSq;
      if(M > maxForce) M = maxForce;
      float A = atan2(V.y, V.x);
      float Fx = M * cos(A);
      float Fy = M * sin(A);
      a1.addForce(new PVector(Fx, Fy));
      a2.addForce(new PVector(-Fx, -Fy));
    }
    a1.done = true;
    a1.update();
    a1.draw();
  }
}