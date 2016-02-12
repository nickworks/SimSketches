#define PROCESSING_TEXTURE_SHADER

// properties set by processing:
uniform sampler2D texture;
uniform vec2 texOffset;
varying vec4 vertTexCoord;
varying vec4 vertColor;

// custom properties:
uniform sampler2D texture2;
uniform int blendMode;

void main() {

    vec4 color1 = texture2D(texture, vertTexCoord.xy);
    vec4 color2 = texture2D(texture2, vertTexCoord.xy);

    vec4 one = vec4(1.0);
    vec4 color;

    if(blendMode == 0) color = color1; // no blend
    if(blendMode == 1) color = color1 * color2; // multiply
    if(blendMode == 2) color = one - ((one - color1) * (one - color2)); // screen
    if(blendMode == 3) color = color1 + color2; // add
    if(blendMode == 4) color = color1 - color2; // subtract
    if(blendMode == 5) color = (color1 + color2)/2.0; // average
    if(blendMode == 6) color = min(color1, color2); // darken
    if(blendMode == 7) color = max(color1, color2); // lighten
    if(blendMode == 8) color = color1 + color2 - (2.0 * color1 * color2); // exclusion
    if(blendMode == 9) { // overlay
    	if(color2.r < 0.5) color.r = 2.0 * color1.r * color2.r;
    	else color.r = 1.0 - 2.0 * (1.0 - color1.r) * (1.0 - color2.r);
    	if(color2.g < 0.5) color.g = 2.0 * color1.g * color2.g;
    	else color.g = 1.0 - 2.0 * (1.0 - color1.g) * (1.0 - color2.g);
    	if(color2.b < 0.5) color.b = 2.0 * color1.b * color2.b;
    	else color.b = 1.0 - 2.0 * (1.0 - color1.b) * (1.0 - color2.b);
    }
    if(blendMode == 10) { // soft light
    	if (color2.r < 0.5) color.r = 2.0 * color1.r * color2.r + color1.r * color1.r - 2.0 * color1.r * color1.r * color2.r;
		else color.r = 2.0 * sqrt(color1.r) * color2.r - sqrt(color1.r) + 2.0 * color1.r - 2.0 * color1.r * color2.r;
		if (color2.g < 0.5) color.g = 2.0 * color1.g * color2.g + color1.g * color1.g - 2.0 * color1.g * color1.g * color2.g;
		else color.g = 2.0 * sqrt(color1.g) * color2.g - sqrt(color1.g) + 2.0 * color1.g - 2.0 * color1.g * color2.g;
		if (color2.b < 0.5) color.b = 2.0 * color1.b * color2.b + color1.b * color1.b - 2.0 * color1.b * color1.b * color2.b;
		else color.b = 2.0 * sqrt(color1.b) * color2.b - sqrt(color1.b) + 2.0 * color1.b - 2.0 * color1.b * color2.b;
    }

    color.a = 1.0;

    gl_FragColor = color * vertColor;
}