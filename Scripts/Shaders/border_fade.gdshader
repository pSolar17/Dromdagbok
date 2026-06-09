shader_type canvas_item;

uniform bool invert = false;
uniform float border_start : hint_range(0.0, 1.0, 0.01) = 0.45;
uniform float exponent : hint_range(0.0, 5.0, 0.1) = 1.0;

void fragment() {
	COLOR = texture(TEXTURE, UV);
	vec2 center = vec2(0.5);
	vec2 diff = UV - center;
	float dist = length(diff);
	if (invert) {
		if (dist < border_start){
		float excess_dist = dist - border_start;
		float max_excess_dist = 0.5 * sqrt(2) - border_start;
		COLOR.a = 1.0 - pow(excess_dist / max_excess_dist, exponent);
	}
	}
	else
	if (dist > border_start){
		float excess_dist = dist - border_start;
		float max_excess_dist = 0.5 * sqrt(2) - border_start;
		COLOR.a = 1.0 - pow(excess_dist / max_excess_dist, exponent);
	}
}
