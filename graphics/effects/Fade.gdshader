shader_type canvas_item;

uniform sampler2D screen_texture : hint_screen_texture, repeat_disable, filter_nearest;
uniform float fade_mix = 0.5;

void fragment() {
	float dist = length(SCREEN_UV * 2.0 - vec2(1)) / length(vec2(1.0, 1.0));
	
	COLOR = vec4(mix(textureLod(screen_texture, SCREEN_UV, 0).rgb, vec3(0), clamp((dist - fade_mix) * 50.0, 0, 1)), 1.0);
}
