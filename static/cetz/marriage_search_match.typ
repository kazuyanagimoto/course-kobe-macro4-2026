#import "@preview/cetz:0.3.4"
#import "lib.typ": *
#set page(width: auto, height: auto, margin: .5cm)
#show: fig-style

#cetz.canvas(length: 1cm, {
  import cetz.draw: *

  let box(pos, name, body, w: 3.6, h: 1.4, stroke: color-base, dash: none) = {
    rect((pos.at(0) - w / 2, pos.at(1) - h / 2), (pos.at(0) + w / 2, pos.at(1) + h / 2),
      radius: 0.15, fill: white, stroke: (paint: stroke, dash: dash), name: name)
    content(pos, align(center, body))
  }

  let arr = (mark: (end: ">", scale: .8), stroke: 0.8pt)

  // the two search pools and the stock of couples
  box((0, 1.5), "sm", [*Single men* \ $n_m (i)$])
  box((0, -1.5), "sf", [*Single women* \ $n_f (j)$])
  box((5.0, 0), "meet", [meet at rate $lambda$ \ draw $z tilde.op G$],
    w: 3.2, h: 1.3, stroke: gray, dash: "dashed")
  box((10.0, 0), "m", [*Married* \ $m(i, j)$], w: 3.6, h: 1.4)

  // search: both pools feed the meeting
  line((1.85, 1.35), (3.35, 0.35), ..arr)
  line((1.85, -1.35), (3.35, -0.35), ..arr)

  // marriage requires mutual consent
  line((6.65, 0), (8.15, 0), ..arr)
  content((7.4, 0.8), align(center, [both agree \ w.p. $alpha_(i j)$]))

  // renegotiation: the bliss shock is redrawn at rate delta
  line((9.3, 0.7), (9.3, 1.6), (10.7, 1.6), (10.7, 0.75), ..arr)
  content((10.0, 2.45), align(center, [rate $delta$: redraw $z' tilde.op G$, \ stay if both still agree]))

  // divorce: both spouses return to the search pools
  line((10.0, -0.7), (10.0, -2.7), (-2.6, -2.7), (-2.6, -1.5), (-1.85, -1.5), ..arr)
  line((-2.6, 1.5), (-1.85, 1.5), ..arr)
  line((-2.6, -1.5), (-2.6, 1.5))
  content((4.6, -3.1), align(center, [otherwise divorce, at rate $delta (1 - alpha_(i j))$]))

  // the steady-state restriction the diagram encodes
  content((4.6, -3.85), text(fill: gray,
    [steady state: $delta (1 - alpha_(i j)) m(i, j) = lambda n_m (i) n_f (j) alpha_(i j)$]))
})
