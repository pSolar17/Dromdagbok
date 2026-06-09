shader_type canvas_item;

uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, repeat_enable, filter_nearest;

uniform sampler2D text;

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

void fragment() {
	// Vertical DCT.

	int block_y = int(FRAGCOORD.y) % 8;
	ivec2 y_block_start = ivec2(FRAGCOORD.xy) - ivec2(0, block_y);

	highp vec3 col[8];

	for (int j = 0; j < 8; ++j){
		col[j] = texelFetch(SCREEN_TEXTURE, y_block_start + ivec2(0, j), 0).rgb;
		// In the prev shader, we normalized values.
		// Denormalize them to get original values.
		col[j] = 4.0 * col[j] - 1.2;
		//col[j] = rgb_to_ycbcr * col[j] + rgb_to_ycbcr_offset;
	}

	for (int j = 0; j < 4; ++j){
		vec3 mix_col = mix(col[2 * j], col[2 * j + 1], 0.5);
		col[2 * j].gb = mix_col.gb;
		col[2 * j + 1].gb = mix_col.gb;
	}

	highp vec3 dct_out_y = vec3(0.0);
	for (int j = 0; j < 8; ++j){
		dct_out_y += dct[8 * block_y + j] * col[j];
	}

	// Quantize

	float f = 50.0;
	int block_x = int(FRAGCOORD.x) % 8;
	float quantize = f * float(block_x + block_y + 1) + 1.0;

	dct_out_y = round(128.0 * dct_out_y / quantize) * (quantize / 128.0);

	// Once again, determine the range of dct_out_y values.
	// dct_out_y.r : 0.0 to 8.0
	// dct_out_y.g : 0.0 to 5.0
	// dct_out_y.b : 0.0 to 5.0
	// Normalize by dividing by 8.0

	COLOR = vec4((dct_out_y / 8.0), 1.0);
	//if (COLOR.b > 5.0) COLOR.rgb = vec3(1.0, 0.0, 0.0);
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
