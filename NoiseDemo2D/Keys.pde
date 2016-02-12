
static class Keys {

  static boolean N1() { 
    return lookup(49);
  }
  static boolean N2() { 
    return lookup(50);
  }
  static boolean N3() { 
    return lookup(51);
  }
  static boolean N4() { 
    return lookup(52);
  }
  static boolean N5() { 
    return lookup(53);
  }
  static boolean N6() { 
    return lookup(54);
  }
  static boolean T() { 
    return lookup(84);
  }
  static boolean MINUS() { 
    return lookup(45);
  }
  static boolean PLUS() { 
    return lookup(61);
  }
  static boolean SPACE() { 
    return lookup(32);
  }
  static boolean LEFT() { 
    return lookup(37);
  }
  static boolean UP() { 
    return lookup(38);
  }
  static boolean RIGHT() { 
    return lookup(39);
  }
  static boolean DOWN() { 
    return lookup(40);
  }
  static boolean BRACKET_LEFT() {
    return lookup(91);
  }
  static boolean BRACKET_RIGHT() {
    return lookup(93);
  }
  static boolean PAGE_UP() {
    return lookup(33);
  }
  static boolean PAGE_DOWN() {
    return lookup(34);
  }

  static boolean[] states = new boolean[256];
  static boolean lookup(int code) {
    if (code < 0) return false;
    if (code >= states.length) return false;
    return states[code];
  }
  static void handleKey(int code, boolean state) {
    if (code < 0) return;
    if (code >= states.length) return;
    states[code] = state;
  }
}


void keyPressed() {
  //println(keyCode);
  Keys.handleKey(keyCode, true);
}
void keyReleased() {
  Keys.handleKey(keyCode, false);
}
void mouseWheel(MouseEvent event) {
  noiseScale += event.getCount();
  if (noiseScale < 6) noiseScale = 6;
  drawNoise2D();
}
