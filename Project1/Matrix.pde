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

	// makes a copy of this matrix, resets this matrix to identity,
	// converts this into a rotation matrix, multiplies this new
	// rotation matrix with the copy of the original matrix
	void rotate(float angle) {}

	// makes a copy of this matrix, resets this matrix to identity,
	// converts this into a translation matrix, multiplies this new
	// translation matrix with the copy of the original matrix
	void translate(float tx, float ty) {}

	// makes a copy of this matrix, resets this matrix to identity,
	// converts this into a scale matrix, multiplies this new scale
	// matrix with the copy of the original matrix
	void scale(float sx, float sy) {}

	// applies matrix transformation to a Vector, returns the result
	Vector transform(Vector v) {}

	// resets this matrix to an identity matrix
	void Reset() {}

	// returns a copy of this matrix
	Matrix copy() {}

	// multiplies this matrix against another matrix
	void mult(Matrix m) {}
}
