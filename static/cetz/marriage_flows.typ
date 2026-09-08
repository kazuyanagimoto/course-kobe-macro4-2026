#import "@preview/cetz:0.3.4"
#import "lib.typ": *
#set page(width: auto, height: auto, margin: .5cm)
#set text(size: 9pt)

#cetz.canvas(length: 1cm, {
  import cetz.draw: *

  let box(pos, name, body, w: 3.4, h: 1.5, stroke: color-base) = {
    rect((pos.at(0) - w / 2, pos.at(1) - h / 2), (pos.at(0) + w / 2, pos.at(1) + h / 2),
      radius: 0.15, fill: white, stroke: stroke, name: name)
    content(pos, align(center, body))
  }

  let arr = (mark: (end: ">", scale: .8), stroke: 0.8pt)

  box((0, 0), "s", [*Single* \ value $W$])
  box((7.5, 0), "m", [*Married* \ value $V(b)$])

  // marriage: top arc
  line((1.7, 0.45), (5.8, 0.45), ..arr)
  content((3.75, 1.05), align(center, [meet, draw $b tilde.op F$ \ marry if $V(b) gt.eq W$]))

  // divorce: bottom arc
  line((5.8, -0.45), (1.7, -0.45), ..arr)
  content((3.75, -1.15), align(center, [redraw $b' tilde.op G(dot | b)$ \ divorce if $V(b') < W$]))

  // stay-married self loop
  line((8.6, -0.35), (9.5, -0.35), (9.5, 0.35), (8.6, 0.35), ..arr)
  content((10.6, 0), [stay if \ $V(b') gt.eq W$])

  // death and rebirth
  line((0, -0.75), (0, -2.2), stroke: (dash: "dashed", paint: gray))
  line((7.5, -0.75), (7.5, -2.2), stroke: (dash: "dashed", paint: gray))
  line((7.5, -2.2), (-1.8, -2.2), stroke: (dash: "dashed", paint: gray))
  line((-1.8, -2.2), (-1.8, 0), (-1.75, 0), ..arr, stroke: (dash: "dashed", paint: gray))
  content((3.75, -2.6), text(fill: gray, [death w.p. $delta$; replaced by newborn singles]))
})
