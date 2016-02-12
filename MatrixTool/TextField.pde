class TextField {

  float num = 0;
  String text = "";
  float x = 0;
  float y = 0;
  boolean focus = false;
  float prevMouseX = 0;
  float scaleDrag = 1;

  TextField() {
  }
  TextField(String text) {
    this.text = text;
  }
  TextField(String text, float x, float y, float scale) {
    this.text = text;
    this.x = x;
    this.y = y;
    this.scaleDrag = scale;
  }
  void draw() {
    if (focus) {
      stroke(255, 0, 0);
      fill(255);
      setNum(num + (mouseX - prevMouseX) * scaleDrag);
      prevMouseX = mouseX;
    }
    if (!focus) {
      stroke(220, 220, 220);
      fill(245, 245, 245);
    }
    strokeWeight(2);
    rect(left(), top(), Width(), Height());

    noStroke();
    fill(0);
    text(text, x, y);
  }
  float Width() {
    return 50;
  }
  float Height() {
    return 20;
  }
  float left() { 
    return x - 5;
  }
  float right() { 
    return x + Width() - 5;
  }
  float top() { 
    return y - Height() + 5;
  }
  float bottom() { 
    return y + 5;
  }
  void mousePressed() {
    if (mouseX >= left() && mouseX <= right() && mouseY >= top() && mouseY <= bottom()) {
      focus = true;
      prevMouseX = mouseX;
    } else {
      focus = false;
    }
  }
  void mouseReleased() {
    focus = false;
  }
  void setNum(float num) {
    this.num = num;
    setTextToNum();
    if (focus) UpdateMatrix();
  }
  void setTextToNum() {
    text = nf(num, 2, 2);
  }
}

