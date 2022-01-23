#pragma endian little
#pragma pattern_limit 0x80000 // Increase this as needed
#pragma array_limit 0x4000

#include <libstd/mem.pat>

struct VertexCoords {
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
	r: 5;
	g: 5;
	b: 5;
	a: 1;
};

bitfield Attrib {
	iip: 1; // Shading method; 0 = flat, 1 = gouraud
	anti: 1; // Anti-aliasing toggle
	tex: 1; // Texture toggle
	rle: 1; // Compressed texture toggle
	padding: 28;
};

struct Header {
	u32 file_id;
	u32 frame_count;
	be Attrib attrib;
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
	be TextureColor pixels[16384]; // 128x128 image
};

struct RLE {
	u16 reps;
	if (reps < 0xFF00) {
		u16 data;
	} else {
		u16 data[(0xFFFF ^ reps) + 1];
	}
};

struct CompressedTexture {
	u32 size;
	RLE texture[while(std::mem::size() - $ > 0)];
	std::assert(sizeof(texture) == size, std::format("Texture size does not equal size {}", size));
};

struct Icon {
	Header header;
	Vertex vertex_data[header.vertices_count];
	Animation animation;
	if (header.attrib.tex) {
		if (header.attrib.rle) {
			CompressedTexture texture;
		} else {
			Texture texture;
		}
	}
};

Icon icon @ 0x00;

std::print(std::format("Vertex count: {}", icon.header.vertices_count));
std::print(std::format("Frame count: {}", icon.header.frame_count));
std::print(std::format("Has texture: {}", icon.header.attrib.tex == 1));
std::print(std::format("Texture is compressed: {}", icon.header.attrib.rle == 1));
