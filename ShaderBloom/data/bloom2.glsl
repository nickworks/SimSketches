#define PROCESSING_TEXTURE_SHADER

uniform sampler2D texture;
uniform sampler2D texture2;
varying vec4 vertTexCoord;

void main(void) {
    
    vec2 p = vertTexCoord.xy;
    vec4 sample1 = texture2D(texture, p);
    vec4 sample2 = texture2D(texture2, p);

    gl_FragColor = sample1 + sample2;
}