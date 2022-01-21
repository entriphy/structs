#pragma endian little
#pragma pattern_limit 0x40000 // Increase this as needed
#pragma array_limit 0x4000

// Credit: https://github.com/ticky/ps2iconsys

struct VertexCoords { // Divide by 4096 and flip Y/Z axis to get proper float value
	s16 x;
	s16 y;
	s16 z;
	s16 w;
};

struct ColorRGBA {
	u8 r;
	u8 g;
	u8 g;
	u8 a;
};

struct TextureData {
	s16 u;
	s16 v;
	ColorRGBA color;
};

struct AnimationHeader {
	u32 id_tag;
	u32 frame_length;
	float speed;
	u32 play_offset;
	u32 n_frames;
};

struct FrameKey {
	float time;
	float value;
};

struct FrameData {
	u32 shape_id;
	u32 n_keys;
	FrameKey anim_keys[n_keys];
};

bitfield TextureColor {
	r: 8;
	b: 8;
	g: 8;
	a: 8;
};

struct Header {
	u32 file_id;
	u32 frame_count;
	u32 texture_type;
	float reserved;
	u32 vertices_count;
};

struct Vertex {
	VertexCoords vertices[parent.header.frame_count];
	VertexCoords normals;
	TextureData texture_data;
};

struct Animation {
	AnimationHeader header;
	FrameData frame_data[header.n_frames];
};

struct Texture {
	TextureColor pixel[16384]; // 128x128 image
};

struct Icon {
	Header header;
	Vertex vertex[header.vertices_count];
	Animation animation;
	if (header.texture_type <= 7) {
		Texture texture; // Only uncompressed textures supported for now
	}
};

Icon icon @ 0x00;
