shader_type canvas_item;

uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, repeat_enable, filter_nearest;

const mat3 rgb_to_ycbcr = mat3(vec3(.299, -.168736, .5), vec3(.587, -.331264, -.418688), vec3(.114, .5, -.081312));
const vec3 rgb_to_ycbcr_offset = vec3(0., .5, .5);

const float dct[64] = {
0.353553,0.353553,0.353553,0.353553,0.353553,0.353553,0.353553,0.353553,
0.490393,0.415735,0.277785,0.0975452,-0.0975452,-0.277785,-0.415735,-0.490393,
0.46194,0.191342,-0.191342,-0.46194,-0.46194,-0.191342,0.191342,0.46194,
0.415735,-0.0975452,-0.490393,-0.277785,0.277785,0.490393,0.0975452,-0.415735,
0.353553,-0.353553,-0.353553,0.353553,0.353553,-0.353553,-0.353553,0.353553,
0.277785,-0.490393,0.0975452,0.415735,-0.415735,-0.0975452,0.490393,-0.277785,
0.191342,-0.46194,0.46194,-0.191342,-0.191342,0.46194,-0.46194,0.191342,
0.0975452,-0.277785,0.415735,-0.490393,0.490393,-0.415735,0.277785,-0.0975452
};

float random (vec2 uv) {
    return fract(sin(dot(uv.xy,
        vec2(12.9898,78.233))) * 43758.5453123);
}

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	// Horizontal DCT.

	int block_x = int(FRAGCOORD.x) % 8;
	ivec2 x_block_start = ivec2(FRAGCOORD.xy) - ivec2(block_x, 0);

	highp vec3 row[8];

	for (int i = 0; i < 8; ++i){
		row[i] = texelFetch(SCREEN_TEXTURE, x_block_start + ivec2(i, 0), 0).rgb;
	}

	for (int i = 0; i < 8; ++i){
		row[i] = rgb_to_ycbcr * row[i] + rgb_to_ycbcr_offset;
	}

	// Average Cb and Cr of every pair of pixels
	for (int i = 0; i < 4; ++i){
		vec3 mix_col = mix(row[2 * i], row[2 * i + 1], .5);
		row[2 * i].gb = mix_col.gb;
		row[2 * i + 1].gb = mix_col.gb;
	}

	highp vec3 dct_out_x = vec3(0.0);
	for (int i = 0; i < 8; ++i){
		dct_out_x += dct[8 * block_x + i] * row[i];
	}

	// Experimentally established that:
	// dct_out_x.r ranges from -1.0 to 2.8;
	// dct_out_x.g ranges from -0.2 to 1.5;
	// dct_out_x.b ranges from -0.2 to 2.0;
	// Before passing shader to the buffer, we should normalize these values.
	// I add 1.2 and divide by 4.0; in the next shader, we will decode these values back when reading.

	//dct_out_x = (dct_out_x + vec3(8.0)) / 16.0;

	COLOR = vec4((dct_out_x + 1.2) / 4.0, 1.0);
	//if (COLOR.r > 2.8) COLOR.rgb = vec3(1.0, 0.0, 0.0);
	//if (COLOR.r == 1.0)
		//COLOR.b = 0.0;
	//if (COLOR.g < 0.0) COLOR.rgb = vec3(1.0);
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
