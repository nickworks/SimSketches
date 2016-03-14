
static class Keys {

  static final int LEFT = 37;
  static final int RIGHT = 39;
  static final int UP = 38;
  static final int DOWN = 40;
  static final int SPACE = 32;

  static final int MAX_VALUE = 128;
  static boolean[] keys = new boolean[MAX_VALUE];
  static boolean[] pkeys = new boolean[MAX_VALUE];
  
  static boolean isDown(int code) {
    if (code < 0) return false;
    if (code >= keys.length) return false;
    return keys[code];
  }
  static boolean onDown(int code) {
    if (code < 0) return false;
    if (code >= keys.length) return false;
    return keys[code] && !pkeys[code];
  }
  static void update() {
    for(int i = 0; i < keys.length; i++){
      pkeys[i] = keys[i]; 
    }
  }
  static void handleKey(int code, boolean state) {
    if (code < 0) return;
    if (code >= keys.length) return;
    keys[code] = state;
  }
}

void keyPressed() {
  //println(keyCode);
  Keys.handleKey(keyCode, true);
}
void keyReleased() {
  Keys.handleKey(keyCode, false);
}