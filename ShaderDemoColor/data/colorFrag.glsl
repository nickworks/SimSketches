varying vec4 vertColor;

void main() {
  vec2 pos = gl_FragCoord.xy;
  vec4 color;
  color.r = sin(pos.x/2.0);
  color.g = cos(pos.y/2.0);
  color.b = 1.0;
  color.a = 1.0;
  gl_FragColor = color * vertColor;
}