shader_type canvas_item;

// Huge thanks to this dude: https://www.shadertoy.com/view/XtffDj
// I am far too stupid to make my own of similar effect.

uniform sampler2D screen_texture : hint_screen_texture, repeat_enable, filter_nearest;

uniform int levels = 10;

float DCT_Coef(vec2 k, vec2 x){
	return cos(PI * k.x * x.x) * cos(PI * k.y * x.y);
}

void fragment(){
	COLOR = texture(screen_texture, SCREEN_UV);
	//vec2 coord = SCREEN_UV / SCREEN_PIXEL_SIZE;
	//
	//vec2 k = mod(coord, 8.0) - 0.5;
	//vec2 K = coord - k - 0.5;
	//
	//vec3 val = vec3(0.0);
	//
	//for (int x = 0; x < 8; ++x){
		//for (int y = 0; y < 8; ++y){
			//val += texture(screen_texture, (K + vec2(float(x), float(y)) + 0.5) * SCREEN_PIXEL_SIZE).rgb * DCT_Coef(k, (vec2(float(x), float(y)) + 0.5) / 8.0) * (k.x < 0.5 ? 1.0 / sqrt(2.0) : 1.0) * (k.y < 0.5 ? 1.0 / sqrt(2.0) : 1.0);
		//}
	//}
	//
	//COLOR = vec4(val / 4.0, 1.0);

	COLOR = round(COLOR * float(levels) / 8.0) / float(levels) * 8.0;


}
