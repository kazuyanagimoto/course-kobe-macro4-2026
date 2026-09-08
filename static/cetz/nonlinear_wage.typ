#import "@preview/cetz:0.3.4"
#import "lib.typ": *
#set page(width: auto, height: auto, margin: .5cm)

#let xbar = 0.5
#let theta1 = 2.0
#let theta2 = 0.5
#let e(x, theta, xbar: xbar) = {
  if x < xbar {
    return calc.pow(x, 1 + theta)
  } else {
    return calc.pow(xbar, theta) * x
  }
}

#let e_nl(x) = e(x, theta1)

#cetz.canvas(length: 5cm, {
  import cetz.draw: *

  let ctx = plot-ctx(x-range: (0, 0.85), y-range: (-0.03, 0.22), size: (2, 1))

  draw-axes(ctx, style: "school-book")
  draw-curve(ctx, e_nl, (0., 0.75), stroke: color-base)

  draw-vline(ctx, xbar, 0, e_nl(xbar), stroke: stroke-dashed)

  label(ctx, 0.82, -0.012, [$ h $])
  label(ctx, 0.05, 0.21, [$ e_1(h) $])
  label(ctx, xbar, -0.02, [$ overline(h) $])
})
