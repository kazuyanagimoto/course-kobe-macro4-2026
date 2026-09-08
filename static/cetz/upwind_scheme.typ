#import "@preview/cetz:0.3.4"
#import "lib.typ": *
#set page(width: auto, height: auto, margin: .5cm)
#set text(size: 9pt)

#cetz.canvas(length: 1cm, {
  import cetz.draw: *

  // one panel: grid points a_{i-1}, a_i, a_{i+1} on a line at height y
  let panel(y, drift-right) = {
    let xs = (0, 2.5, 5)
    line((-0.9, y), (5.9, y), stroke: gray)
    for (k, xx) in xs.enumerate() {
      circle((xx, y), radius: 0.07, fill: if k == 1 { color-base } else { gray }, stroke: none)
    }
    content((0, y - 0.45), [$a_(i - 1)$])
    content((2.5, y - 0.45), [$a_i$])
    content((5, y - 0.45), [$a_(i + 1)$])

    // drift arrow above the center point
    let (x0, x1) = if drift-right { (2.9, 4.4) } else { (2.1, 0.6) }
    line((x0, y + 0.75), (x1, y + 0.75), mark: (end: ">", scale: .9),
      stroke: (paint: color-accent, thickness: 1.2pt))
    content(((x0 + x1) / 2, y + 1.15),
      text(fill: color-accent, if drift-right { [drift $s_i > 0$] } else { [drift $s_i < 0$] }))

    // highlighted difference segment
    let (d0, d1) = if drift-right { (2.5, 5) } else { (0, 2.5) }
    line((d0, y), (d1, y), stroke: (paint: color-base, thickness: 2.2pt))
    content((7.9, y), align(left,
      if drift-right [forward difference \ $(v_(i+1) - v_i) \/ Delta a$]
      else [backward difference \ $(v_i - v_(i-1)) \/ Delta a$]))
  }

  panel(2.4, true)
  panel(0, false)
})
