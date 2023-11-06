meta:
  id: vmdm
  file-extension: vmdm
  endian: le
  bit-endian: le
seq:
  - id: header
    type: header
  - id: animations
    type: animation
    repeat: expr
    repeat-expr: header.animation_count
  - id: strings
    type: string
    repeat: expr
    repeat-expr: header.string_count
  - id: keyframes
    type: keyframe
    repeat: expr
    repeat-expr: header.keyframe_count
  - id: vectors
    type: vector
    repeat: expr
    repeat-expr: header.vector_count
types:
  header:
    seq:
      - id: magic
        contents: "VMDM"
      - size: 4
      - id: id
        type: str
        size: 2
        encoding: ascii
      - size: 2
      - id: unk_0xc
        type: u2
      - id: unk_0xe
        type: u2
      - size: 24
      - id: animation_count
        type: u2
      - id: string_count
        type: u2
      - id: keyframe_count
        type: u2
      - id: vector_count
        type: u2
      - size: 16
  animation:
    seq:
      - id: texcoord_channel
        type: u1
        doc: |
          The texcoord channel (defined in the VMDG file) to use for this
          animation.
      - id: unk_0x1
        type: u1
      - id: unk_0x2
        type: u2
      - id: name_index
        type: u2
        doc: |
          The index of this animation's name in the string table.
      - id: bone_count
        type: u2
        doc: |
          The number of bones to animate for this animation.
          Usually equal to the number of bones in the VMDG file.
      - id: root_bone_name_index
        type: u2
        doc: |
          The index of the root bone's name in the string table.
          Usually always `hara_ROT`.
      - id: vectors_offset
        type: u2
        doc: |
          The index of the vector in the `vectors` buffer to start reading from.
          
          At this index, there exists a keyframe where `time` is equal to 0.
          All subsequent `vectors_offset` values are defined in each of this
          animation's keyframes.
      - id: keyframe_count
        type: u2
        doc: |
          The number of keyframes in this animation.
      - id: keyframes_offset
        type: u2
        doc: |
          The index of the keyframe in the `keyframes` buffer to start reading
          from.
    instances:
      name:
        value: _parent.strings[name_index]
      root_bone_name:
        value: _parent.strings[root_bone_name_index]
      start_vector:
        value: _parent.vectors[vectors_offset]
      start_keyframe:
        value: _parent.keyframes[keyframes_offset]
  string:
    seq:
      - size: 4
      - id: value
        type: str
        size: 12
        terminator: 0
        encoding: ascii
  keyframe:
    seq:
      - id: time
        type: u2
        doc: |
          Divide by 300 (?) to get keyframe time in seconds.
          Keyframes are linearly interpolated.
      - id: vectors_offset
        type: u2
        doc: |
          Index of the vector in the `vectors` buffer to start reading from.
          
          Each keyframe contains a vector for each bone starting from this index.
          The first vector will be a translation vector (for the root bone),
          while the subsequent vectors will be rotation vectors.
    instances:
      start_vector:
        value: _parent.vectors[vectors_offset]
  vector:
    seq:
      - id: x
        type: b10
      - id: y
        type: b11
      - id: z
        type: b11
    instances:
      x_value:
        value: x << 2
      y_value:
        value: y << 1
      z_value:
        value: z << 1
      x_pos:
        value: x_value / 0x10
      y_pos:
        value: y_value / 0x10
      z_pos:
        value: z_value / 0x10
      x_rad:
        value: x_value / 0x7FF
      y_rad:
        value: y_value / 0x7FF
      z_rad:
        value: z_value / 0x7FF
    doc: |
      Signed 12-bit integers. (Kaitai doesn't support signed bit integers D:)
      Shift `x` left by 2 bits and `y`/`z` by 1 bit to get real values.