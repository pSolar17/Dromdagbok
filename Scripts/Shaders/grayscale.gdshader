shader_type canvas_item;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	COLOR = texture(TEXTURE, UV);
	float avg = (COLOR.r + COLOR.g + COLOR.b) / 3.0;
	COLOR.r = avg;
	COLOR.g = avg;
	COLOR.b = avg;
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
