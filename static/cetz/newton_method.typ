#import "@preview/cetz:0.3.4"
#import "lib.typ": *
#set page(width: auto, height: auto, margin: .5cm)

#show math.equation: block.with(fill: white, inset: 1pt)

#let f(x) = calc.pow(x, 2) - 2
#let df(x) = 2 * x
#let f_line(x, x0) = df(x0) * (x - x0) + f(x0)
#let newton(x) = x - f(x) / df(x)
#let xopt = calc.sqrt(2)
#let x0 = 0.8
#let x1 = newton(x0)

#cetz.canvas(length: 3cm, {
  import cetz.draw: *

  let ctx = plot-ctx(x-range: (-0.5, 2.2), y-range: (-2.8, 2.5), size: (2, 1))

  draw-axes(ctx, style: "school-book")
  draw-curve(ctx, f, (0., 2.), stroke: color-base)

  // Newton's method
  label(ctx, xopt - 0.05, 0.5, [$ x^* $])
  label(ctx, x0, 0.4, [$ x_0 $])
  label(ctx, -0.3, f(x0), [$ f(x_0) $])
  label(ctx, x1, -0.5, [$ x_1 $])
  label(ctx, 2, 2.2, [$ f(x) $])

  draw-vline(ctx, x0, calc.min(0., f(x0)), calc.max(0., f(x0)), stroke: stroke-dashed)
  draw-hline(ctx, f(x0), 0., x0, stroke: stroke-dashed)
  draw-curve(ctx, x => f_line(x, x0), (0., 2.), stroke: color-accent)
  draw-vline(ctx, x1, calc.min(0., f(x1)), calc.max(0., f(x1)), stroke: stroke-dashed)
})
