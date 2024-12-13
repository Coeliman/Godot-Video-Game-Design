shader_type canvas_item;

uniform float range = 0.125;
uniform vec4 origin: source_color;
uniform vec4 new: source_color;

void fragment() {
	vec4 current_pixel = texture(TEXTURE, UV);
	
	if (current_pixel.r >= origin.r - range && current_pixel.g >= origin.g - range && current_pixel.b >= origin.b - range)
		COLOR = new;
	else
		COLOR = current_pixel;
}
/*
shader_type canvas_item;

uniform sampler2D mask; 

void fragment() {
	vec4 color = texture(TEXTURE,UV);
	vec4 color_mask = texture(mask, UV);
	if (color_mask == vec4(1, 1, 1, 1)) {
		color = vec4(0, 1, 1, 1);
	} else {
		color = vec4(1, 0, 0, 1);
	}
	COLOR = color;
}
*/