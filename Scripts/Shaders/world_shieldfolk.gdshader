shader_type canvas_item;

uniform float size_x = 640.0;
uniform float size_y = 480.0;

uniform float offset_x = 0.0;
uniform float offset_y = 0.0;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	COLOR = texture(TEXTURE, fract(UV + vec2(offset_x / size_x, offset_y / size_y)));
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
