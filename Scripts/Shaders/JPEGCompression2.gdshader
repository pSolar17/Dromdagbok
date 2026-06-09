shader_type canvas_item;

uniform sampler2D screen_texture : hint_screen_texture, repeat_enable, filter_nearest;

uniform int frequencies = 8;

float DCT_Coef(vec2 k, vec2 x){
	return cos(PI * k.x * x.x) * cos(PI * k.y * x.y);
}

void fragment() {
	vec2 coord = SCREEN_UV / SCREEN_PIXEL_SIZE;
	
	vec2 k = mod(coord, 8.0) - 0.5;
	vec2 K = coord - k - 0.5;
	
	vec3 val = vec3(0.0);
	
	for (int x = 0; x < frequencies; ++x){
		for (int y = 0; y < frequencies; ++y){
			val += texture(screen_texture, (K + vec2(float(x), float(y)) + 0.5) * SCREEN_PIXEL_SIZE).rgb * DCT_Coef(vec2(float(x), float(y)), (k + 0.5) / 8.0) * (float(x) == 0.0 ? 1.0 / sqrt(2.0) : 1.0) * (float(y) == 0.0 ? 1.0 / sqrt(2.0) : 1.0);
		}
	}
	
	//for(int u=0; u<frequencies; ++u)
    	//for(int v=0; v<frequencies; ++v)
        //{
            //val += texture(screen_texture, (K+vec2(float(u),float(v))+0.5) * SCREEN_PIXEL_SIZE).rgb * DCT_Coef(vec2(float(u),float(v)), (k+.5)/8.) * (u==0?0.7071:1.) * (v==0?0.7071:1.);
        //}
	
	COLOR = vec4(val / 4.0, 1.0);
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
