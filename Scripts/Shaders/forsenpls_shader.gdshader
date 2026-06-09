shader_type canvas_item;

uniform float period = 1.0; // In seconds.
uniform sampler2D screen_texture : hint_screen_texture, repeat_disable, filter_nearest;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	COLOR = textureLod(screen_texture, SCREEN_UV, 0.0);

	vec4 new_color;
	new_color.r = 0.6 * cos(1.5 * PI * TIME / period);
	new_color.g = 0.6 * cos((1.5 * PI * (TIME + period / 3.0)) / period);
	new_color.b = 0.6 * cos((1.5 * PI * (TIME + 2.0 * period / 3.0)) / period);
	new_color.a = 0.6;

	COLOR.rgb = mix(COLOR.rgb, new_color.rgb, 0.5);
	COLOR.a = COLOR.a * new_color.a;
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
