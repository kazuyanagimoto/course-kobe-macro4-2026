#import "@preview/cetz:0.3.4"
#import "lib.typ": *
#set page(width: auto, height: auto, margin: .5cm)

#show math.equation: block.with(fill: white, inset: 1pt)

#let f(x) = calc.pow(x, 2) - 2
#let xopt = calc.sqrt(2)
#let a0 = 0.2
#let b0 = 1.8
#let a1 = (a0 + b0) / 2

#cetz.canvas(length: 3cm, {
  import cetz.draw: *

  let ctx = plot-ctx(x-range: (0, 2.4), y-range: (-2.6, 3.0), size: (2, 1))

  draw-axes(ctx, style: "school-book")
  draw-curve(ctx, f, (0., 2.2), stroke: color-base)

  // bisection method
  label(ctx, xopt - 0.05, 0.5, [$ x^* $])
  label(ctx, a0, 0.4, [$ a_0 $])
  label(ctx, a0, f(a0) - 0.5, [$ f(a_0) $])
  label(ctx, b0, -0.5, [$ b_0 $])
  label(ctx, b0, f(b0) + 1.2, [$ f(b_0) $])
  label(ctx, a1, 0.4, [$ a_1 $])
  label(ctx, a1, f(a1) - 0.8, [$ f(a_1) $])

  for x in (a0, b0, a1) {
    marker(ctx, x, f(x), radius: 0.024)
    draw-vline(ctx, x, calc.min(0., f(x)), calc.max(0., f(x)), stroke: stroke-dashed)
  }
})
