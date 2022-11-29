meta:
  id: motogp
  file-extension: motogp
  endian: le
seq:
  - id: header
    type: str
    size: 8
    encoding: ascii
  - id: random_garbo
    size: 120
  - id: sections
    type: section
    repeat: expr
    repeat-expr: 33
types:
  section:
    seq:
      - id: scale
        type: f4
      - id: initial_coord
        type: coordinate
      - id: textures
        type: u2
        repeat: expr
        repeat-expr: 8
      - id: idk
        size: 12
      - id: subsections
        type: subsection
        repeat: expr
        repeat-expr: 4
  subsection:
    seq:
      - id: stcycl
        type: vif_stcycl
      - id: vertex_count_unpack
        type: vif_unpack
      - id: vertex_count_stuff
        size: 16
      - id: stcycl2
        type: vif_stcycl
      - id: vertex_unpack
        type: vif_unpack
      - id: vertices
        type: vertex_descriptor
        repeat: expr
        repeat-expr: vertex_unpack.size / 2
      - id: stcycl3
        type: vif_stcycl
      - id: color_unpack
        type: vif_unpack
      - id: colors
        type: rgb888_color
        repeat: expr
        repeat-expr: color_unpack.size
      - id: pad
        size: color_unpack.size % 4
      - id: mscal
        type: vif_mscal
  coordinate:
    seq:
      - id: x
        type: f4
      - id: y
        type: f4
      - id: z
        type: f4
  vertex_descriptor:
    seq:
      - id: x
        type: f4
      - id: y
        type: f4
      - id: z
        type: f4
      - id: normal_x
        type: f4
      - id: normal_y
        type: f4
      - id: u
        type: f4
      - id: v
        type: f4
      - id: normal_z
        type: f4
  rgb888_color:
    seq:
      - id: r
        type: u1
      - id: g
        type: u1
      - id: b
        type: u1
  vif_stcycl:
    seq:
      - id: cl
        type: b8
      - id: wl
        type: b8
      - id: num
        type: b8
      - id: cmd
        type: b8
  vif_mscal:
    seq:
      - id: execaddr
        type: b16
      - id: num
        type: b8
      - id: cmd
        type: b8
  vif_unpack:
    seq:
      - id: addr
        type: b10
      - id: pad
        type: b4
      - id: usn
        type: b1
      - id: flg
        type: b1
      - id: size
        type: b8
      - id: cmd
        type: b8