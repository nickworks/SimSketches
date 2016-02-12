class Vector {
	float x = 0;
	float y = 0;

	// constructor that leaves x and y at their default values
	public Vector() {}

	// constructor that sets x and y to the same value
	public Vector(float value) {}

	// constructor that sets x and y independently
	public Vector(float x, float y) {}

	// returns a copy of this vector
	Vector copy() {}

	// adds a vector to this vector
	void add(Vector v) {}

	// subtracts a vector from this vector
	void sub(Vector v) {}

	// multiplies this vector with a scalar
	void mult(float s) {}

	// returns the dot product of the two vectors
	float dot(Vector v) {}

	// returns the vector's magnitude squared
	float magSq() {}

	// returns the vector's magnitude
	float mag() {
		// tip: call magSq()
	}

	// returns the distance from this Vector (point) to another Vector (point)
	float disTo(Vector v) {}

	// normalizes the vector
	void norm() {}

	// returns the angle of the Vector (in radians)
	float angle() {}

	// returns the angle from this Vector (point) to another Vector (point)
	float angleTo(Vector v) {}

	// draws a circle at (x, y)
	void drawPoint() {}

	// returns a string representing this object (for debugging)
	String toString() {}
}
