shader_type canvas_item;

uniform sampler2D screen_texture : hint_screen_texture, repeat_enable, filter_linear_mipmap;
uniform float how_bad = 2.0;

void fragment(){
	COLOR = textureLod(screen_texture, SCREEN_UV, how_bad);
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
