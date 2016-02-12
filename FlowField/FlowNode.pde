public class FlowNode {
  
  float W = 20;
  float W2 = W/2;
  
  PVector position;
  PVector direction;
  float angle;
  color tint = color(255, 0, 0);
  
  public FlowNode(PVector position, float angle) {
    
    //direction = PVector.fromAngle(angle);
    direction = new PVector(cos(angle), sin(angle)); 
    
    
    colorMode(HSB);
    tint = color(degrees(atan2(direction.y, direction.x)) + 180, 255, 255);
    colorMode(RGB);
    
    this.position = position;
    this.angle = angle;
  }
  public void draw() {
    noStroke();
    fill(tint);
    pushMatrix();
    translate(position.x, position.y);
    rotate(angle);
    ellipse(0,0,W2,W2);
    stroke(tint);
    strokeWeight(3);
    line(0, 0, W2, 0);
    popMatrix();
  }
  
} 

