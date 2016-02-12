#define PROCESSING_TEXTURE_SHADER

//properties set automatically by processing:
uniform mat4 transform;
uniform mat4 texMatrix;
attribute vec4 vertex;
attribute vec4 color;
attribute vec2 texCoord;

// properties that we set for frag shader:
varying vec4 vertColor;
varying vec4 vertTexCoord;

uniform float time;

void main(){

	mat4 mat = transform;

	mat[3][0] += sin(time);

	// set properties for frag shader:
	vertColor = color;
	vertTexCoord = texMatrix * vec4(texCoord, 1.0, 1.0);

	// set vertex position for GPU:
	gl_Position = mat * vertex;
}