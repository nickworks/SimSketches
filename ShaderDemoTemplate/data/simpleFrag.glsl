#define PROCESSING_TEXTURE_SHADER

// properties set automatically by processing:
uniform sampler2D texture;
uniform vec2 texOffset;

// properties set by vertex shader:
varying vec4 vertTexCoord;
varying vec4 vertColor;

// this function is executed for every pixel.
// within the function, vertTexCoord contains the coordinates of the pixel
void main(){

	// given a sampler2D (a texture) and a vec2 (a position), this function returns a vec4 (the pixel color at position)
	vec4 color = texture2D(texture, vertTexCoord.xy); 
	
	// set the pixel color to use:
	gl_FragColor = color;
}
