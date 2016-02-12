class Camera {
  PMatrix2D matrix = new PMatrix2D();
  PMatrix2D tmatrix = new PMatrix2D();
  PVector screen = new PVector();
  Camera() {
    screen = new PVector(width/2, height * .75);
  }

  void update(Vec2 target) {

    matrix.reset();
    matrix.translate(screen.x, screen.y);
    matrix.scale(zoom);
    matrix.translate(-target.x, -target.y);

    tmatrix.reset();
    tmatrix.translate(target.x, target.y);
    tmatrix.scale(1/zoom);
    tmatrix.translate(-screen.x, -screen.y);
    
    
    
  }
}

