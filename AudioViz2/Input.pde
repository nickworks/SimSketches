static class Input {

  static boolean S = false;
  static boolean N1 = false;
  static boolean N2 = false;
  static boolean N3 = false;
  static boolean N4 = false;
  static boolean N5 = false;
  static boolean SPACE = false;

  static void handle(int keyCode, boolean isDown) {
    
    switch(keyCode) {
    case 32:
      SPACE = isDown;
      break;
    case 49:
      N1 = isDown;
      break;
     case 50:
      N2 = isDown;
      break;
     case 51:
      N3 = isDown;
      break;
     case 52:
      N4 = isDown;
      break;
      case 53:
      N5 = isDown;
      break;
    case 83:
      S = isDown;
      break;
    }
  }
}
void keyPressed() {
  println(keyCode);
  Input.handle(keyCode, true);
}
void keyReleased(){
  Input.handle(keyCode, false);
}

