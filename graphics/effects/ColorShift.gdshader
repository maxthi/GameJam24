shader_type canvas_item;

uniform sampler2D screen_texture : hint_screen_texture, repeat_disable, filter_nearest;
uniform float shift_rate = 0.05;
uniform float intensity_mix = 1.0;

// HSV conversion from http://lolengine.net/blog/2013/07/27/rgb-to-hsv-in-glsl (WTFPL)

// All components are in the range [0…1], including hue.
vec3 rgb2hsv(vec3 c)
{
    vec4 K = vec4(0.0, -1.0 / 3.0, 2.0 / 3.0, -1.0);
    vec4 p = mix(vec4(c.bg, K.wz), vec4(c.gb, K.xy), step(c.b, c.g));
    vec4 q = mix(vec4(p.xyw, c.r), vec4(c.r, p.yzx), step(p.x, c.r));

    float d = q.x - min(q.w, q.y);
    float e = 1.0e-10;
    return vec3(abs(q.z + (q.w - q.y) / (6.0 * d + e)), d / (q.x + e), q.x);
}

// All components are in the range [0…1], including hue.
vec3 hsv2rgb(vec3 c)
{
    vec4 K = vec4(1.0, 2.0 / 3.0, 1.0 / 3.0, 3.0);
    vec3 p = abs(fract(c.xxx + K.xyz) * 6.0 - K.www);
    return c.z * mix(K.xxx, clamp(p - K.xxx, 0.0, 1.0), c.y);
}

void fragment() {
	vec3 inColor = textureLod(screen_texture, SCREEN_UV, 0).rgb;
	
	vec3 hsv = rgb2hsv(inColor);
	
	hsv.x = fract(hsv.x + TIME * shift_rate);

	// Called for every pixel the material is visible on.
	COLOR = vec4(mix(inColor, hsv2rgb(hsv), intensity_mix * intensity_mix), 1);
}
