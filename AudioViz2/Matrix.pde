
class Matrix {
  double n00 = 1; // Rx
  double n01 = 0; // Ry
  double n02 = 0; // Tx

  double n10 = 0; // Ux
  double n11 = 1; // Uy
  double n12 = 0; // Ty

  double n20 = 0;
  double n21 = 0;
  double n22 = 1; 

  void rotate(double radians) {
    Matrix m = this.copy();
    reset();
    n00 = cos((float)radians);
    n01 = sin((float)radians);
    n10 = - n01;
    n11 = n00;
    mult(m);
  }
  void translate(double tx, double ty) {
    Matrix m = this.copy();
    reset();
    n02 = tx;
    n12 = ty;
    mult(m);
  }
  void scale(double sx, double sy) {
    Matrix m = this.copy();
    reset();
    n00 = sx;
    n11 = sy;
    mult(m);
  }

  Vector transform(Vector p) {
    double x = n00 * p.x + n01 * p.y + n02;
    double y = n10 * p.x + n11 * p.y + n12;
    return new Vector((float)x, (float)y);
  }
  void reset() {
    n00 = 1; // Rx
    n01 = 0; // Ry
    n02 = 0; // Tx
    n10 = 0; // Ux
    n11 = 1; // Uy
    n12 = 0; // Ty
    n20 = 0;
    n21 = 0;
    n22 = 1;
  }
  Matrix copy() {
    Matrix m = new Matrix();
    m.n00 = n00; // Rx
    m.n01 = n01; // Ry
    m.n02 = n02; // Tx
    m.n10 = n10; // Ux
    m.n11 = n11; // Uy
    m.n12 = n12; // Ty
    m.n20 = n20;
    m.n21 = n21;
    m.n22 = n22;
    return m;
  }
  void mult(Matrix B) {
    Matrix A = this.copy();
    n00 = A.n00 * B.n00 + A.n01 * B.n10 + A.n02 * B.n20;
    n01 = A.n00 * B.n01 + A.n01 * B.n11 + A.n02 * B.n21;
    n02 = A.n00 * B.n02 + A.n01 * B.n12 + A.n02 * B.n22;
    n10 = A.n10 * B.n00 + A.n11 * B.n10 + A.n12 * B.n20;
    n11 = A.n10 * B.n01 + A.n11 * B.n11 + A.n12 * B.n21;
    n12 = A.n10 * B.n02 + A.n11 * B.n12 + A.n12 * B.n22;
    n20 = A.n20 * B.n00 + A.n21 * B.n10 + A.n22 * B.n20;
    n21 = A.n20 * B.n01 + A.n21 * B.n11 + A.n22 * B.n21;
    n22 = A.n20 * B.n02 + A.n21 * B.n12 + A.n22 * B.n22;
  }
}

