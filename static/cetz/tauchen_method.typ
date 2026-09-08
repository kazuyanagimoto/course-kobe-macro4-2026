#import "@preview/cetz:0.3.4"
#import "lib.typ": *
#set page(width: auto, height: auto, margin: .5cm)

#show math.equation: block.with(fill: white, inset: 1pt)

#let Phi(x) = calc.exp(-calc.pow(x, 2) / 2) / calc.sqrt(2 * calc.pi)

#let rh = 0.8
#let x_i = 0.
#let x_j = 1.
#let d = 1.

#cetz.canvas(length: 3cm, {
  import cetz.draw: *

  let ctx = plot-ctx(x-range: (-0.5, 3), y-range: (0, 0.45), size: (3, 1))

  draw-axes(ctx, style: "left")
  fill-between(ctx, Phi, (x_j - d / 2, x_j + d / 2))
  draw-curve(ctx, Phi, (-1, 3), stroke: color-base)

  let y_xlabel = -0.07
  label(ctx, rh * x_i, y_xlabel, [$ rho x_i $])
  label(ctx, x_j, y_xlabel, [$ x_j $])
  label(ctx, x_j + d / 2, y_xlabel, [$ x_j + d / 2 $])
  label(ctx, x_j - d / 2, y_xlabel, [$ x_j - d / 2 $])

  draw-vline(ctx, rh * x_i, 0., Phi(rh * x_i), stroke: stroke-dashed)
  draw-vline(ctx, x_j, 0., Phi(x_j), stroke: stroke-dashed)
  draw-vline(ctx, x_j + d / 2, 0., Phi(x_j + d / 2), stroke: stroke-guide)
  draw-vline(ctx, x_j - d / 2, 0., Phi(x_j - d / 2), stroke: stroke-guide)
})
