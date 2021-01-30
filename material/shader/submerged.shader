shader_type canvas_item;

void fragment()
{
	float cutoff = sin(TIME) * 0.2f;
	
	if (!(UV.y < cutoff))
	{
		COLOR = texture(TEXTURE, UV);
	}
}