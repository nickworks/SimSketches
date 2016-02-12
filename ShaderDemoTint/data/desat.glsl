#define PROCESSING_TEXTURE_SHADER

// properties set automatically by processing:
uniform sampler2D texture;
uniform vec2 texOffset;

// properties set by vertex shader:
varying vec4 vertTexCoord;
varying vec4 vertColor;

// my properties:
uniform float desatAmount;

void main(){
	
	vec4 color = texture2D(texture, vertTexCoord.xy);

	float avg = (color.r + color.g + color.b) / 3.0;
	vec4 desatColor = vec4(avg, avg, avg, color.a);


	gl_FragColor = mix(color, desatColor, desatAmount);
}
