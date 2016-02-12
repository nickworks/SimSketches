#define PROCESSING_TEXTURE_SHADER

// properties set by processing:
uniform sampler2D texture;
uniform vec2 texOffset;
varying vec4 vertTexCoord;
varying vec4 vertColor;

// custom properties:
uniform vec2 resolution;
uniform float ringWidth;
uniform float ringSize;
uniform float ringMag;

float PI2 = 6.283185; // one wave
float PI4 = 12.566370; // two waves
float PI8 = 25.132741; // four waves

void main() {

    vec4 color = texture2D(texture, vertTexCoord.xy);

	if(ringMag != 1.0) {
		float ratio = resolution.x / resolution.y;
		vec2 p = vertTexCoord.xy - vec2(.5);
		p.x *= ratio;

		float distance = length(p);
		float radians = (ringSize - distance) * ringWidth;
		float dratio = cos(radians);
		dratio = ringMag +  (1.0 - ringMag) * dratio;

		p *= dratio;
		p.x /= ratio;
		p += vec2(.5);
		
		if(distance < ringSize && radians < PI8) {
			color = texture2D(texture, p);
		}
	}

    gl_FragColor = color * vertColor;
}