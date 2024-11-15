shader_type canvas_item;

uniform float pixel_range : hint_range(1.0, 16.0, 1.0) = 4.0;

uniform sampler2D screen_texture : hint_screen_texture, repeat_disable, filter_nearest;

void fragment() {
	float Xshift = FRAGCOORD.x - mod(FRAGCOORD.x, pixel_range);
	float Yshift = FRAGCOORD.y - mod(FRAGCOORD.y, pixel_range);
	float Cshift = floor(pixel_range / 2.0);
	COLOR = texture(screen_texture, vec2(Xshift + Cshift, Yshift + Cshift) * SCREEN_PIXEL_SIZE);
}