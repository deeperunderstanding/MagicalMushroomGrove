shader_type spatial;
render_mode blend_mix,depth_draw_opaque,cull_back,diffuse_lambert,specular_blinn,world_vertex_coords;
uniform vec4 albedo : hint_color;
uniform sampler2D texture_albedo : hint_albedo;
uniform sampler2D texture_albedo_2 : hint_albedo;
uniform sampler2D texture_normal : hint_normal;
uniform sampler2D texture_normal_2 : hint_normal;
uniform float specular;
uniform float metallic;
uniform float roughness : hint_range(0,1);
uniform float point_size : hint_range(0,128);
uniform sampler2D texture_roughness : hint_white;
uniform vec4 roughness_texture_channel;
uniform float normal_scale : hint_range(-16,16);
varying vec3 uv1_triplanar_pos;
uniform float uv1_blend_sharpness;
varying vec3 uv1_power_normal;
uniform vec3 uv1_scale;
uniform vec3 uv1_offset;
uniform vec3 uv2_scale;
uniform vec3 uv2_offset;
uniform float interp_steepness = 2.0;

void vertex() {
	TANGENT = vec3(0.0,0.0,-1.0) * abs(NORMAL.x);
	TANGENT+= vec3(1.0,0.0,0.0) * abs(NORMAL.y);
	TANGENT+= vec3(1.0,0.0,0.0) * abs(NORMAL.z);
	TANGENT = normalize(TANGENT);
	BINORMAL = vec3(0.0,-1.0,0.0) * abs(NORMAL.x);
	BINORMAL+= vec3(0.0,0.0,1.0) * abs(NORMAL.y);
	BINORMAL+= vec3(0.0,-1.0,0.0) * abs(NORMAL.z);
	BINORMAL = normalize(BINORMAL);
	uv1_power_normal=pow(abs(NORMAL),vec3(uv1_blend_sharpness));
	uv1_power_normal/=dot(uv1_power_normal,vec3(1.0));
	uv1_triplanar_pos = VERTEX * uv1_scale + uv1_offset;
	uv1_triplanar_pos *= vec3(1.0,-1.0, 1.0);
}


vec4 triplanar_texture(sampler2D p_sampler,vec3 p_weights,vec3 p_triplanar_pos) {
	vec4 samp=vec4(0.0);
	samp+= texture(p_sampler,p_triplanar_pos.xy) * p_weights.z;
	samp+= texture(p_sampler,p_triplanar_pos.xz) * p_weights.y;
	samp+= texture(p_sampler,p_triplanar_pos.zy * vec2(-1.0,1.0)) * p_weights.x;
	return samp;
}


void fragment() {
	vec4 color_1 = triplanar_texture(texture_albedo,uv1_power_normal,uv1_triplanar_pos);
	vec4 color_2 = triplanar_texture(texture_albedo_2,uv1_power_normal,uv1_triplanar_pos);
	vec3 normal_1 = triplanar_texture(texture_normal,uv1_power_normal,uv1_triplanar_pos).rgb;
	vec3 normal_2 = triplanar_texture(texture_normal_2,uv1_power_normal,uv1_triplanar_pos).rgb;
	
	float mix_amnt = 1.0 - clamp(pow(uv1_power_normal.y * interp_steepness, 2), 0.0, 1.0);
	
	vec4 albedo_tex = mix(color_1, color_2, mix_amnt);
	vec3 normal_tex = mix(normal_1, normal_2, mix_amnt);
	
	ALBEDO = albedo.rgb * albedo_tex.rgb;
	METALLIC = metallic;
	float roughness_tex = dot(triplanar_texture(texture_roughness,uv1_power_normal,uv1_triplanar_pos),roughness_texture_channel);
	ROUGHNESS = 1.0; // roughness_tex * roughness;
	SPECULAR = specular;
	NORMALMAP = normal_tex;
	NORMALMAP_DEPTH = normal_scale;
}
