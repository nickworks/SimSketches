#define PROCESSING_TEXTURE_SHADER

uniform sampler2D texture;
varying vec4 vertTexCoord;
uniform vec2 texOffset;

// offsetting pixels

vec2 cartToPolar(vec2 c){
    float M = length(c);
    float A = atan(c.y, c.x);
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
    p.x *= .99;
    p = polarToCart(p);
    p += vec2(.5);

    vec4 color = texture2D(texture, p);
    gl_FragColor = vec4(color.rgb, .99);
}
