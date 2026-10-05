#import "@preview/cetz:0.3.4"
#import "lib.typ": *
#set page(width: auto, height: auto, margin: .5cm)
#set text(size: 8pt)

// Explicit parameterisation of a bargaining frontier by the wedge w = u - v.
// Each w picks out the single frontier point on the slope-1 line through
// (w, 0); raising w slides that point along the frontier towards the man.

#let bigB = 6.0
#let front(u) = {
  let inner = bigB - calc.exp(u)
  if inner <= 0.0001 { -9.0 } else { calc.ln(inner) }
}

#let xmin = -1.7
#let xmax = 2.2
#let ymin = -1.0
#let ymax = 2.2

// U(w) solves front(u) = u - w; V(w) is the matching ordinate.
#let uOf(w) = bisect(u => front(u) - (u - w), -3.0, calc.ln(bigB) - 0.0001)

#let wA = -1.2
#let wB = 1.0
#let uA = uOf(wA)
#let vA = front(uA)
#let uB = uOf(wB)
#let vB = front(uB)

#let uBottom = bisect(u => front(u) - ymin, xmin, calc.ln(bigB) - 0.0001)

#cetz.canvas(length: 3cm, {
  import cetz.draw: *

  let ctx = plot-ctx(x-range: (xmin, xmax), y-range: (ymin, ymax), size: (1.95, 1.6))

  fill-between(ctx, u => clamp(front(u), ymin, ymax), (xmin, xmax),
    base: ymin, color: color-base.transparentize(80%))
  draw-axes(ctx, style: "school-book")

  // the two slope-1 lines v = u - w, each crossing the u axis at its own wedge
  for (w, u0, v0) in ((wA, uA, vA), (wB, uB, vB)) {
    line((ctx.pt)(w - 0.35, -0.35), (ctx.pt)(u0 + 0.30, v0 + 0.30),
      stroke: (paint: color-accent, thickness: 0.7pt))
    marker(ctx, u0, v0, radius: 0.03, color: color-accent)
  }

  draw-curve(ctx, front, (xmin, uBottom), stroke: (paint: black, thickness: 1.1pt))

  label(ctx, 2.12, -0.16, [$u$])
  label(ctx, -0.16, 2.12, [$v$])

  // name each line by its wedge, next to where it crosses the u axis
  label(ctx, wA - 0.22, 0.16, text(fill: color-accent)[$w$])
  label(ctx, wB - 0.24, 0.16, text(fill: color-accent)[$w'$])
})
