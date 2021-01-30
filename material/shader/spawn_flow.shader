shader_type canvas_item;
uniform vec2 flow;

void fragment()
{
	vec2 offset = TIME  * (flow * vec2(1, 1));
	vec4 tex = texture(TEXTURE, UV + offset);
	COLOR = tex;
}