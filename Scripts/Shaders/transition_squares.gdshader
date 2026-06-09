shader_type canvas_item;

uniform float progress : hint_range(-1.0, 1.0, 0.01) = -2.0;
uniform int square_size = 4;
uniform float random_influence : hint_range(1.0, 25.0, 0.1) = 10.0;
uniform bool invert = false;

float rand(vec2 co){
    return fract(sin(dot(co.xy ,vec2(12.9898,96.233))) * 43758.5453);
}

void fragment() {
	ivec2 top_left = ivec2(FRAGCOORD.xy) - ivec2(FRAGCOORD.xy) % ivec2(square_size);
	vec2 top_left_uv = vec2(top_left) * SCREEN_PIXEL_SIZE;
	if (invert)
		if (top_left_uv.y - rand(top_left_uv) > progress) COLOR = texture(TEXTURE, UV);
		else COLOR = vec4(0.0);
	else
		if (top_left_uv.y - rand(top_left_uv) < progress) COLOR = texture(TEXTURE, UV);
		else COLOR = vec4(0.0);

}
