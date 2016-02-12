#define PROCESSING_TEXTURE_SHADER

uniform sampler2D texture;
uniform vec2 texOffset;
varying vec4 vertTexCoord;

uniform float ratio;
uniform vec2 position;

void main( void ) {
    
    float sum = 1.0;
    float size = 1.0;
    float g = 0.93;
    int num = 100;

    vec2 p1 = vertTexCoord.xy;
    p1.x *= ratio;

    vec2 p2 = position.xy;
    p2.x *= ratio;
    p2.y = 1.0 - p2.y;

    float dist = length(p1 - p2);
    sum += size / pow(dist, g);
    
    vec4 color = vec4(0,0,0,1);
    float val = sum / float(num);
    color = vec4(0, val*0.5, val, 1);
    
    gl_FragColor = vec4(color);
}