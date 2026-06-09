shader_type canvas_item;

uniform sampler2D screen_texture : hint_screen_texture, repeat_disable, filter_nearest;
uniform float how_bad = 4.0; // Size of pixel group, the lower - the less prevalent the effect is.

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	ivec2 xy = ivec2(mod(FRAGCOORD.xy, how_bad));
	ivec2 group_start = ivec2(FRAGCOORD.xy) - xy;

	vec3 avg = vec3(0.0);

	for (int i = 0; i < int(how_bad); ++i){
		avg += texelFetch(screen_texture, group_start + ivec2(i, i), 0).rgb;
	}

	COLOR = vec4(avg / how_bad, 1.0);
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
