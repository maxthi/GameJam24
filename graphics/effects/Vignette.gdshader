shader_type canvas_item;

uniform sampler2D screen_texture : hint_screen_texture, repeat_disable, filter_nearest;
uniform float intensity_mix = 1.0;

void fragment() {

	float blurIntensity = length(SCREEN_UV * 2.0 - vec2(1)) / length(vec2(1.0, 1.0));

	float pulse = sin(TIME * 2.0) * 0.5 + 0.5;
	
	blurIntensity = pow(blurIntensity, mix(0.1, 0.3, pulse));

	vec3 black = vec3(0);
	
	vec3 inColor = textureLod(screen_texture, SCREEN_UV, 0).rgb;
	vec3 output = mix(inColor, black, blurIntensity);
	
	COLOR = vec4(mix(inColor, output, sqrt(intensity_mix)), 1.0);
}
