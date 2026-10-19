#import "@preview/cetz:0.3.4"
#import "lib.typ": *
#set page(width: auto, height: auto, margin: .5cm)

#show math.equation: block.with(fill: white, inset: 1pt)

// Conditional mean mu + rho x_i of x' given x_i, and the cell around x_j.
#let m = 0.
#let x_j = 1.2
#let d = 1.

// Density of x' | x_i ~ N(mu + rho x_i, 1).
#let phi(x) = calc.exp(-calc.pow(x - m, 2) / 2) / calc.sqrt(2 * calc.pi)

#cetz.canvas(length: 3cm, {
  import cetz.draw: *

  let ctx = plot-ctx(x-range: (-0.5, 3), y-range: (0, 0.45), size: (3, 1))

  draw-axes(ctx, style: "left")
  fill-between(ctx, phi, (x_j - d / 2, x_j + d / 2))
  draw-curve(ctx, phi, (-1, 3), stroke: color-base)

  let y_xlabel = -0.07
  label(ctx, m, y_xlabel, [$ mu + rho x_i $])
  label(ctx, x_j, y_xlabel, [$ x_j $])
  label(ctx, x_j + d / 2, y_xlabel, [$ x_j + d / 2 $])
  label(ctx, x_j - d / 2, y_xlabel, [$ x_j - d / 2 $])

  draw-vline(ctx, m, 0., phi(m), stroke: stroke-dashed)
  draw-vline(ctx, x_j, 0., phi(x_j), stroke: stroke-dashed)
  draw-vline(ctx, x_j + d / 2, 0., phi(x_j + d / 2), stroke: stroke-guide)
  draw-vline(ctx, x_j - d / 2, 0., phi(x_j - d / 2), stroke: stroke-guide)
})
