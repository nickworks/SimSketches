#define PROCESSING_TEXTURE_SHADER

// properties set automatically by processing:
uniform sampler2D texture;
uniform vec2 texOffset;

// properties set by vertex shader:
varying vec4 vertTexCoord;
varying vec4 vertColor;


void main(){
	
	vec2 tc0 = vertTexCoord.xy;
	vec2 tc1 = vertTexCoord.xy + vec2( texOffset.x, 0);
	vec2 tc2 = vertTexCoord.xy + vec2(-texOffset.x, 0);
	vec2 tc3 = vertTexCoord.xy + vec2( 0, texOffset.y);
	vec2 tc4 = vertTexCoord.xy + vec2( 0,-texOffset.y);
	vec2 tc5 = vertTexCoord.xy + vec2( texOffset.x, texOffset.y);
	vec2 tc6 = vertTexCoord.xy + vec2( texOffset.x,-texOffset.y);
	vec2 tc7 = vertTexCoord.xy + vec2(-texOffset.x,-texOffset.y);
	vec2 tc8 = vertTexCoord.xy + vec2(-texOffset.x, texOffset.y);

	vec4 color;
	color += texture2D(texture, tc0) * 4.0;
	color += texture2D(texture, tc1) * 2.0;
	color += texture2D(texture, tc2) * 2.0;
	color += texture2D(texture, tc3) * 2.0;
	color += texture2D(texture, tc4) * 2.0;
	color += texture2D(texture, tc5);
	color += texture2D(texture, tc6);
	color += texture2D(texture, tc7);
	color += texture2D(texture, tc8);
	color /= 16.0;

	color.a = .95;

	gl_FragColor = color;
}	
