shader_type canvas_item;

uniform sampler2D screen_texture : hint_screen_texture, repeat_enable, filter_nearest;

float hash(vec2 p) {
    return fract(sin(dot(p, vec2(12.9898,78.233))) * 43758.5453123); 
}

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	COLOR = texelFetch(screen_texture, ivec2(FRAGCOORD.xy), 0);
	
	float avg = (COLOR.r + COLOR.b + COLOR.g) / 3.0;
	
	// Dim all colors
	avg = avg * avg - 0.1;
	
	COLOR.r = avg;
	COLOR.g = avg;
	COLOR.b = avg;
	
	// Add noise
	vec3 noise = vec3(hash(SCREEN_UV + fract(TIME / 5.0)));
	COLOR.rgb += noise * 0.2;
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
