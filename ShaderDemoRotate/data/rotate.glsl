#define PROCESSING_TEXTURE_SHADER

// properties set automatically by processing:
uniform sampler2D texture;
uniform vec2 texOffset;

// properties set by vertex shader:
varying vec4 vertTexCoord;
varying vec4 vertColor;

//uniform float rotateAmount = .1;
uniform vec2 resolution;

void main(){
	
	vec2 p = vertTexCoord.xy;
	p -= vec2(.5);

	// convert from cart to polar:
	float M = length(p);
	float A = atan(p.y, p.x);

	A += .1;
	M *= .99;

	// convert from polar to cart:
	p.x = M * cos(A);
	p.y = M * sin(A);

	p += vec2(.5);


	gl_FragColor = texture2D(texture, p);
}	
