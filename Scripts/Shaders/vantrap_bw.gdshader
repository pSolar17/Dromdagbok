shader_type canvas_item;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	vec4 col = texture(TEXTURE, UV);
	vec2 uv = UV;
	
	const vec2 center = vec2(1.0, 0.5);
	
	float t = (col.r + col.g + col.b) / 3.0;
	
	if (t > 0.41) {
		COLOR = vec4(.75, .0, .0, 1.0);
		if (t > 0.5) {
			COLOR.r = 1.0;
		}
		//COLOR.a = pow(1.0 - (abs(0.5 - UV.x) / 0.5), 1.0);
		vec2 diff = vec2(center.x - UV.x, abs(UV.y - center.y));
		float dist = sqrt(diff.x * diff.x + diff.y * diff.y);
		COLOR.a = pow(1.0 - dist, 1.0) - 0.1;
	}
	else {
		COLOR = vec4(0.0);
	}
	
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
