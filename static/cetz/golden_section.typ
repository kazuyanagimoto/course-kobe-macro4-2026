#import "@preview/cetz:0.3.4"
#import "lib.typ": *
#set page(width: auto, height: auto, margin: .5cm)

#show math.equation: block.with(fill: white, inset: 1pt)

#let f(x) = 0.7 * calc.pow(x - 1.75, 2) + 0.4
#let xopt = 1.75
#let phi = (calc.sqrt(5) - 1) / 2
#let a0 = 0.2
#let b0 = 2.2
#let x1 = a0 + (1 - phi) * (b0 - a0)
#let x2 = a0 + phi * (b0 - a0)

#cetz.canvas(length: 3cm, {
  import cetz.draw: *

  let ctx = plot-ctx(x-range: (0, 2.6), y-range: (-0.4, 2.7), size: (2, 1))

  draw-axes(ctx, style: "school-book")
  draw-curve(ctx, f, (0., 2.4), stroke: color-base)

  // golden section search
  label(ctx, xopt, -0.28, [$ x^* $])
  label(ctx, a0, -0.28, [$ a $])
  label(ctx, b0, -0.28, [$ b $])
  label(ctx, x1, -0.28, [$ x_1 $])
  label(ctx, x2, -0.28, [$ x_2 $])
  label(ctx, x1, f(x1) + 0.72, [$ f(x_1) $])
  label(ctx, x2 + 0.04, f(x2) + 0.5, [$ f(x_2) $])

  for x in (a0, b0, x2) {
    draw-vline(ctx, x, 0., f(x), stroke: stroke-dashed)
  }
  // x1 becomes the new lower bound (f(x_1) > f(x_2)): highlight discarded part
  draw-vline(ctx, x1, 0., f(x1), stroke: (dash: "dashed", paint: color-accent))

  for x in (x1, x2) {
    marker(ctx, x, f(x), radius: 0.024)
  }
})
