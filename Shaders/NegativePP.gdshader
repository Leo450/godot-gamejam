shader_type canvas_item;

uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap;
uniform float OPACITY : hint_range(0.0, 1.0, 0.1);

void fragment() {
	vec4 color = texture(SCREEN_TEXTURE, SCREEN_UV);
	COLOR = vec4(1.0 - color.rgb, OPACITY);
}
