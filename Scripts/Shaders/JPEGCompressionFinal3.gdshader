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

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	int block_y = int(FRAGCOORD.y) % 8;
	ivec2 block_start = ivec2(FRAGCOORD.xy) - ivec2(0, block_y);
	
	highp vec3 col[8];
	for (int j = 0; j < 8; ++j){
		col[j] = texelFetch(SCREEN_TEXTURE, block_start + ivec2(0, j), 0).rgb;
		// As in prev shader, denormalize values to get originals
		col[j] = 8.0 * col[j];
	}
	
	highp vec3 dct_out = vec3(0.0);
	for (int j = 0; j < 8; ++j) {
		dct_out += dct[8 * j + block_y] * col[j];
	}
	
	// Range of values:
	// dct_out.r : 0.0 to 3.0
	// dct_out.g : -1.0 to 2.0
	// dct_out.b : -1.0 to 2.0
	// Normalize by adding 1.0 and dividing by 4.0
	
	COLOR = vec4((dct_out + 1.0) / 4.0, 1.0);
	//if (COLOR.b > 2.0) COLOR.rgb = vec3(1.0, 0.0, 0.0);
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
