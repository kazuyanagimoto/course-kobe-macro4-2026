#import "@preview/cetz:0.3.4"
#import "lib.typ": *
#set page(width: auto, height: auto, margin: .5cm)
#set text(size: 9pt)

#cetz.canvas(length: 1cm, {
  import cetz.draw: *

  let box(pos, name, body, w: 4.6, h: 1.1, fill: white, stroke: color-base) = {
    rect((pos.at(0) - w / 2, pos.at(1) - h / 2), (pos.at(0) + w / 2, pos.at(1) + h / 2),
      radius: 0.12, fill: fill, stroke: stroke, name: name)
    content(pos, align(center, body))
  }

  let arrow-style = (mark: (end: ">", scale: .8), stroke: 0.8pt)

  box((0, 6.0), "r", [Guess $r$: firm FOC gives \ $k(r), w(r)$], fill: rgb("#f2f7f8"))
  box((0, 4.0), "hjb", [*HJB* (backward) \ $rho v = max_c u(c) + dots$])
  box((0, 2.0), "pol", [policy $c(a, x)$, generator $A$], stroke: gray, h: 0.8)
  box((0, 0.0), "kf", [*KF* (forward) \ $A^top g = 0$])
  box((0, -2.0), "mkt", [*Market clearing* \ $S(r) = integral a thin g dif a dif x - k(r)$])
  box((0, -4.0), "eq", [$S(r) = 0$: equilibrium], stroke: color-accent, h: 0.9)

  line("r", "hjb", ..arrow-style)
  line("hjb", "pol", ..arrow-style)
  line("pol", "kf", ..arrow-style)
  line("kf", "mkt", ..arrow-style)
  line("mkt", "eq", ..arrow-style)

  // feedback loop: S(r) != 0 -> update r (bisection)
  line((2.3, -2.0), (4.2, -2.0), (4.2, 6.0), (2.3, 6.0), ..arrow-style)
  content((4.55, 2.0), angle: 90deg, anchor: "south",
    [$S(r) eq.not 0$: update $r$ (bisection)])
})
