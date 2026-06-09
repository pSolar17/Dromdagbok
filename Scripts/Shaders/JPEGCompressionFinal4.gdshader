shader_type canvas_item;

uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, repeat_enable, filter_nearest;

const float dct[64] = float[64](
0.353553,0.353553,0.353553,0.353553,0.353553,0.353553,0.353553,0.353553,
0.490393,0.415735,0.277785,0.0975452,-0.0975452,-0.277785,-0.415735,-0.490393,
0.46194,0.191342,-0.191342,-0.46194,-0.46194,-0.191342,0.191342,0.46194,
0.415735,-0.0975452,-0.490393,-0.277785,0.277785,0.490393,0.0975452,-0.415735,
0.353553,-0.353553,-0.353553,0.353553,0.353553,-0.353553,-0.353553,0.353553,
0.277785,-0.490393,0.0975452,0.415735,-0.415735,-0.0975452,0.490393,-0.277785,
0.191342,-0.46194,0.46194,-0.191342,-0.191342,0.46194,-0.46194,0.191342,
0.0975452,-0.277785,0.415735,-0.490393,0.490393,-0.415735,0.277785,-0.0975452
);

const mat3 ycbcr_to_rgb = mat3(vec3(1.), vec3(0., -.344136, 1.772), vec3(1.402, -.714136, 0.));
// I'm not worrying about 128/255 vs. .5 here.
const vec3 ycbcr_offset_to_rgb = vec3(0., -.5, -.5);

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	int block_x = int(FRAGCOORD.x) % 8;
	
	ivec2 block_start = ivec2(FRAGCOORD.xy) - ivec2(block_x, 0);
	
	highp vec3 row[8];
	
	for (int i = 0; i < 8; ++i){
		row[i] = texelFetch(SCREEN_TEXTURE, block_start + ivec2(i, 0), 0).rgb;
		row[i] = 4.0 * row[i] - 1.0;
	}
	
	highp vec3 dct_out = vec3(0.0);
	for (int i = 0; i < 8; ++i){
		dct_out += dct[8 * i + block_x] * row[i];
	}
	
	COLOR = vec4(dct_out, 1.0);
	COLOR.rgb = ycbcr_to_rgb * (dct_out + ycbcr_offset_to_rgb);
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
