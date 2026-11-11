shader_type canvas_item;

void vertex() {
	// Called for every vertex the material is visible on.
}
uniform float pixel_size : hint_range(1.0,16.0) = 4.0;

void fragment() {
	LIGHT_VERTEX.xy = floor(LIGHT_VERTEX.xy / pixel_size) * pixel_size;

	SHADOW_VERTEX.xy = floor(SHADOW_VERTEX.xy / pixel_size) * pixel_size;
}


