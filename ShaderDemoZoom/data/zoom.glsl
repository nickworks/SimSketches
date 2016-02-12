#define PROCESSING_TEXTURE_SHADER

uniform sampler2D texture;
varying vec4 vertTexCoord;
uniform vec2 texOffset;

// zooming pixels

void main() {

    vec2 p = vertTexCoord.xy;
    // get offset from center:
    p -= vec2(.5);

    // convert from cartesian to polar:
    float M = length(p);
    float A = atan(p.y, p.x);

    // slightly reduce length of vector:
    M *= .99;
    
    // convert from polar to cartesian:
    p.x = M * cos(A);
    p.y = M * sin(A);

    // reorient back to corner:
    p += vec2(.5);

    vec4 color = texture2D(texture, p);
    gl_FragColor = vec4(color.rgb, .99);
}
