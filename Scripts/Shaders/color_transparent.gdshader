shader_type canvas_item;

uniform vec4 target_color;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	COLOR = texture(TEXTURE, UV);
	if (COLOR == target_color) COLOR = vec4(0.0);
}