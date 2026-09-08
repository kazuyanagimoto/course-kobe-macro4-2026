#import "@preview/cetz:0.3.4"
#import "lib.typ": *
#set page(width: auto, height: auto, margin: .5cm)

#show math.equation: block.with(fill: white, inset: 1pt)

#let f(x) = x * (x - 1) * (x - 2) + 1
#let f_line(x, x0, x1) = f(x0) + (f(x1) - f(x0)) / (x1 - x0) * (x - x0)

#let a = 0.2
#let b = 2.5
#let n = 4
#let xs = ()
#for i in range(0, n + 1) {
  xs.push(a + i * (b - a) / n)
}

#cetz.canvas(length: 3cm, {
  import cetz.draw: *

  let ctx = plot-ctx(x-range: (0, 2.8), y-range: (-0.7, 3.7), size: (2, 1))

  draw-axes(ctx, style: "school-book")
  draw-curve(ctx, f, (0., 2.6), stroke: color-base)

  label(ctx, a + 0.1, -0.5, [$ a = x_0 $])
  label(ctx, b + 0.05, -0.5, [$ b = x_(#n) $])

  for i in range(0, n) {
    let x0 = xs.at(i)
    let x1 = xs.at(i + 1)
    if i > 0 {
      label(ctx, x0, -0.5, [$ x_(#i) $])
    }
    draw-vline(ctx, x0, calc.min(0., f(x0)), calc.max(0., f(x0)), stroke: stroke-dashed)
    draw-curve(ctx, x => f_line(x, x0, x1), (x0, x1), samples: 2, stroke: black)
  }

  draw-vline(ctx, b, calc.min(0., f(b)), calc.max(0., f(b)), stroke: stroke-dashed)
})
