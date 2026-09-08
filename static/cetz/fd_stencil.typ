#import "@preview/cetz:0.3.4"
#import "lib.typ": *
#set page(width: auto, height: auto, margin: .5cm)
#set text(size: 9pt)

#cetz.canvas(length: 1cm, {
  import cetz.draw: *

  let nx = 5
  let ny = 3
  let sp = 1.7

  // lattice of grid points
  for ix in range(0, nx) {
    for iy in range(0, ny) {
      circle((ix * sp, iy * sp), radius: 0.07, fill: gray.lighten(30%), stroke: none)
    }
  }

  // center point (i, j)
  let cx = 2 * sp
  let cy = 1 * sp
  circle((cx, cy), radius: 0.11, fill: color-base, stroke: none)
  content((cx - 0.32, cy - 0.38), anchor: "east", [$(a_i, x_j)$])

  // jump arrows to the four neighbours
  let jump(to, lbl, anchor, offset) = {
    line((cx, cy), to, mark: (end: ">", scale: .9),
      stroke: (paint: color-accent, thickness: 1.2pt))
    content((to.at(0) + offset.at(0), to.at(1) + offset.at(1)), anchor: anchor,
      text(fill: color-accent, lbl))
  }
  jump((cx + sp - 0.25, cy), [$s_i^+ \/ Delta a$], "west", (0.35, 0.42))
  jump((cx - sp + 0.25, cy), [$-s_i^- \/ Delta a$], "east", (-0.35, 0.42))
  jump((cx, cy + sp - 0.25), [$lambda_j^arrow.t$], "south", (0.42, 0.28))
  jump((cx, cy - sp + 0.25), [$lambda_j^arrow.b$], "north", (0.42, -0.28))

  // axes
  line((-0.8, -1.1), (nx * sp - 0.9, -1.1), mark: (end: ">", scale: .7))
  content((nx * sp - 0.5, -1.1), [$a$])
  line((-0.8, -1.1), (-0.8, ny * sp - 0.9), mark: (end: ">", scale: .7))
  content((-0.8, ny * sp - 0.55), [$x$])
})
