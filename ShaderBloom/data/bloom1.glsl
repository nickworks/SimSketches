#define PROCESSING_TEXTURE_SHADER

uniform sampler2D texture;
uniform float brightPassThreshold;
varying vec4 vertTexCoord;

void main(void) {
    vec3 luminanceVector = vec3(0.2125, 0.7154, 0.0721);
    vec4 sample = texture2D(texture, vertTexCoord.xy);

    float luminance = dot(luminanceVector, sample.rgb);
    luminance = max(0.0, luminance - brightPassThreshold);
    sample.rgb *= sign(luminance);
    sample.a = 1.0;

    gl_FragColor = sample;
}