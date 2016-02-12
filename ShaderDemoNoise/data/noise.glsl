#define PROCESSING_TEXTURE_SHADER

uniform sampler2D texture;
varying vec4 vertTexCoord;
uniform vec2 texOffset;

// simple, 1-pixel box blur

float noise( in vec2 x )
{
    return sin(1.5*x.x)*sin(1.5*x.y);
}

void main() {
    float n = noise(vertTexCoord.xy);
    gl_FragColor = vec4(n,n,n, 1.0);
}