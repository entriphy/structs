meta:
  id: vmdg
  file-extension: vmdg
  endian: le
  bit-endian: le
seq:
  - id: header
    type: header
  - id: bones
    type: bone
    repeat: expr
    repeat-expr: header.bone_count
  - id: meshes
    type: mesh
    repeat: expr
    repeat-expr: header.mesh_count
  - id: triangles
    type: triangle
    repeat: expr
    repeat-expr: header.triangle_count
  - id: vertices
    type: bone_vector
    repeat: expr
    repeat-expr: header.vertex_count
  - id: normals
    type: bone_vector
    repeat: expr
    repeat-expr: header.normal_count
  - id: texcoord_groups
    type: texcoord_group
    repeat: expr
    repeat-expr: header.texcoord_group_count
  - id: texcoords
    type: texcoord
    repeat: expr
    repeat-expr: header.texcoord_count
types:
  header:
    seq:
      - id: magic
        contents: "VMDG"
      - size: 4
      - id: id
        type: str
        size: 2
        encoding: ascii
      - size: 2
      - id: unk_0xc
        size: 4
      - id: bone_count
        type: u2
      - id: mesh_count
        type: u2
      - id: triangle_count
        type: u2
      - id: vertex_count
        type: u2
      - id: normal_count
        type: u2
      - id: texcoord_group_count
        type: u2
      - id: texcoord_count
        type: u2
      - size: 2
      - size: 32
  bone:
    seq:
      - size: 4
      - id: name
        type: str
        size: 12
        terminator: 0
        encoding: ascii
      - id: translation
        type: vector
      - id: parent
        type: s1
        doc: |
          The index of the parent bone. -1 if no parent.
      - id: unk_0x17
        type: s1
      - id: rotation
        type: vector
      - size: 2
  mesh:
    seq:
      - size: 4
      - id: name
        type: str
        size: 12
        terminator: 0
        encoding: ascii
      - id: triangles_offset
        type: u2
        doc: |
          The index of the triangle in the `triangles` buffer to start reading
          from.
      - id: triangles_end_offset
        type: u2
      - id: vertices_offset
        type: u2
        doc: |
          The index of the vertex in the `vertices` buffer to start reading from.
      - id: vertices_end_offset
        type: u2
      - id: normals_offset
        type: u2
        doc: |
          The index of the normal in the `normals` buffer to start reading from.
      - id: normals_end_offset
        type: u2
      - id: triangle_count
        type: u2
      - id: vertex_count
        type: u1
      - id: normal_count
        type: u1
    instances:
      start_triangle:
        value: _parent.triangles[triangles_offset]
      start_vertex:
        value: _parent.vertices[vertices_offset]
      start_normal:
        value: _parent.normals[normals_offset]
  triangle:
    seq:
      - id: vertex_indices
        type: u1
        repeat: expr
        repeat-expr: 3
      - id: normal_indices
        type: u1
        repeat: expr
        repeat-expr: 3
      - id: texcoord_index
        type: u1
        doc: |
          The index of the texcoord to use for this triangle within the texcoord
          group.
          
          i.e. To get the texcoord for this triangle:
          `texcoord_groups[texcoord_group_index].texcoords[channel][texcoord_index]`
          `channel` is usually specified by an animation (see VMDM file docs)
      - id: texcoord_group_index
        type: u1
        doc: |
          The index of the texcoord group from the `texcoord_groups` buffer to
          use for this triangle.
    instances:
      texcoord_group:
        value: _parent.texcoord_groups[texcoord_group_index]
  texcoord_group:
    seq:
      - size: 2
      - id: texcoords_offset
        type: u2
        doc: |
          The index of the texcoord in the `texcoords` buffer to start reading
          from.
      - id: texcoord_count
        type: u2
      - id: channel_count
        type: u2
    instances:
      start_texcoord:
        value: _parent.texcoords[texcoords_offset]
    doc: |
      Starting at `texcoords_offset`, there is a 2D array of texcoords for this
      group: texcoords[channel_count][texcoord_count]
      Channels are used to switch between different texcoords, i.e. for
      different facial expressions.
      If the specified channel is greater than `channel_count`, use channel 0.
  texcoord:
    seq:
      - id: uv0
        type: uv
      - id: clut
        type: clut
      - id: uv1
        type: uv
      - id: uv2
        type: uv
    doc: |
      Specifies UVs for each vertex and the CLUT to use for the triangle
      referencing this texcoord.
  vector:
    seq:
      - id: x
        type: s2
      - id: y
        type: s2
      - id: z
        type: s2
    instances:
      x_pos:
        value: x / 0x10
      y_pos:
        value: y / 0x10
      z_pos:
        value: z / 0x10
      x_norm:
        value: x / 0xFFF
      y_norm:
        value: y / 0xFFF
      z_norm:
        value: z / 0xFFF
      x_rad:
        value: x / 0x7FF
      y_rad:
        value: y / 0x7FF
      z_rad:
        value: z / 0x7FF
    doc: |
      Right-handed, Y-up vector.
      Signed 12-bit integers (4-bit fraction for position?).
  bone_vector:
    seq:
      - id: vec
        type: vector
      - id: bone
        type: s2
  uv:
    seq:
      - id: u
        type: u1
      - id: v
        type: u1
  clut:
    seq:
      - id: x
        type: b6
      - id: y
        type: b9
      - id: pad
        type: b1
    doc: |
      PS1 color lookup table struct.
      Note that the palette is in the TIM image data itself.
    doc-ref: https://problemkaputt.de/psx-spx.htm, Clut Attribute