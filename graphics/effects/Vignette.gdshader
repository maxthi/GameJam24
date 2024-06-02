shader_type canvas_item;

uniform sampler2D screen_texture : hint_screen_texture, repeat_disable, filter_nearest;

void fragment() {

	float blurIntensity = length(SCREEN_UV * 2.0 - vec2(1)) / length(vec2(1.0, 1.0));

	float pulse = sin(TIME * 2.0) * 0.5 + 0.5;
	
	blurIntensity = pow(blurIntensity, mix(0.1, 0.3, pulse));

	vec3 black = vec3(0);
	
	COLOR = vec4(mix(textureLod(screen_texture, SCREEN_UV, 0).rgb, black, blurIntensity), 1.0);
}
