#define PROCESSING_TEXTURE_SHADER

// properties set by processing:
uniform sampler2D texture;
uniform vec2 texOffset;
varying vec4 vertTexCoord;
varying vec4 vertColor;

// custom properties:
uniform float desatAmount;

// simple desaturation shader

void main() {

    vec4 color = texture2D(texture, vertTexCoord.xy);
    float avg = (color.r + color.g + color.b)/3.0;

    color.r = mix(color.r, avg, desatAmount);
    color.g = mix(color.g, avg, desatAmount);
    color.b = mix(color.b, avg, desatAmount);

    gl_FragColor = color * vertColor;
}