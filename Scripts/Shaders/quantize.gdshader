shader_type canvas_item;

uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, repeat_enable, filter_nearest;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	COLOR = texelFetch(SCREEN_TEXTURE, ivec2(FRAGCOORD.xy), 0);
	
	float f = 32.0;
	int block_x = int(FRAGCOORD.x) % 8;
	int block_y = int(FRAGCOORD.y) % 8;
	float quantize = f;
	
	COLOR.rgb = round(128.0 * COLOR.rgb / quantize) * (quantize / 128.0);
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
