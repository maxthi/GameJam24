shader_type canvas_item;

uniform sampler2D screen_texture : hint_screen_texture, repeat_disable, filter_nearest;
uniform float intensity_mix = 1.0;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	vec3 inColor = textureLod(screen_texture, SCREEN_UV, 0).rgb;
	// Called for every pixel the material is visible on.
	
	vec3 black = vec3( 0 );
	vec3 white = vec3( 1 );
	
	//vec3 color = mix( mix( black, inColor, abs(vec3(5)*sin(TIME)-0.2f) ), white, abs(vec3(2)*sin(TIME) -0.2f) );
	float t = 1.;
	//vec3 color = mix( mix( black, inColor, -1.0), white, 0.5);
	vec3 color = clamp((vec3(0.3) - inColor) * vec3(10.0), vec3(0.0), vec3(1.0));
	COLOR = vec4( mix(inColor, color, intensity_mix), 1);
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
