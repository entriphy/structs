#pragma endian little

struct sceVu0IVector {
	u32 x;
	u32 y;
	u32 z;
	u32 w;
};

struct sceVu0FVECTOR {
	float x;
	float y;
	float z;
	float w;
};

struct BackgroundColors {
	sceVu0IVector upper_left;
	sceVu0IVector upper_right;
	sceVu0IVector lower_left;
	sceVu0IVector lower_right;
};

struct IconSys {
	char header[4]; // PS2D
	padding[2]; // Reserved
	u16 line_break_pos; // Position in name to create a line break
	padding[4]; // Reserved
	u32 bg_transparency; // 0x00 - 0x80
	BackgroundColors bg_colors; // RGB
	sceVu0FVECTOR light_directions[3];
	sceVu0FVECTOR light_colors[3]; // RGB
	sceVu0FVECTOR ambient_color; // RGB
	char16 name[]; // SJIS-encoded
	padding[68 - sizeof(name)];
	char list_name[];
	padding[64 - sizeof(list_name)];
	char copy_name[];
	padding[64 - sizeof(copy_name)];
	char delete_name[];
	padding[64 - sizeof(delete_name)];
	padding[512]; // Reserved
};

IconSys iconSys @ 0x00;
