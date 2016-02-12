#define PROCESSING_TEXTURE_SHADER

uniform sampler2D texture;
varying vec4 vertTexCoord;
uniform vec2 texOffset;

uniform float rotateAmount;
uniform float zoomAmount;
uniform vec2 resolution;

// offsetting pixels

vec2 cartToPolar(vec2 c){
    float dx = c.x;
    float dy = c.y;
    float M = sqrt(dx * dx + dy * dy);
    float A = atan(dy, dx);
    return vec2(M, A);
}
vec2 polarToCart(vec2 p){
    float x = p.x * cos(p.y);
    float y = p.x * sin(p.y);
    return vec2(x, y);
}
void main() {

    vec2 p = vertTexCoord.xy;
    p -= vec2(.5);
    p = cartToPolar(p);
    p.x *= zoomAmount;
    p.y += rotateAmount;
    p = polarToCart(p);
    p += vec2(.5);
    

    vec4 color = texture2D(texture, p);
    gl_FragColor = vec4(color.rgb, .99);
}
