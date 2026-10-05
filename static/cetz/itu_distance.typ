#import "@preview/cetz:0.3.4"
#import "lib.typ": *
#set page(width: auto, height: auto, margin: .5cm)
#set text(size: 8pt)

// Distance-to-frontier function of a proper bargaining set.
// The set is the ETU one, exp(u) + exp(v) <= B, so the frontier is
// v = ln(B - exp(u)).  Out-of-domain values are pushed far below the
// window so that the bisection below stays well defined everywhere.
#let bigB = 6.0
#let front(u) = {
  let inner = bigB - calc.exp(u)
  if inner <= 0.0001 { -9.0 } else { calc.ln(inner) }
}

#let xmin = -0.7
#let xmax = 2.3
#let ymin = -0.7
#let ymax = 2.1

// D(u, v) = min { z : (u - z, v - z) in F }: walk along the diagonal until the
// frontier is met.  Positive outside the set, negative inside it.
#let dist(u0, v0) = bisect(z => v0 - z - front(u0 - z), -2.5, 1.6)

// Where the frontier leaves the window through the bottom edge.
#let uBottom = bisect(u => front(u) - ymin, xmin, calc.ln(bigB) - 0.0001)

#let uOut = 0.60
#let vOut = 1.62
#let uIn = 1.10
#let vIn = 0.25
#let zOut = dist(uOut, vOut)
#let zIn = dist(uIn, vIn)

#cetz.canvas(length: 3cm, {
  import cetz.draw: *

  let ctx = plot-ctx(x-range: (xmin, xmax), y-range: (ymin, ymax), size: (2.0, 1.85))

  fill-between(ctx, u => clamp(front(u), ymin, ymax), (xmin, xmax),
    base: ymin, color: gray.transparentize(88%))
  draw-axes(ctx, style: "school-book")
  draw-curve(ctx, front, (xmin, uBottom), stroke: color-base)

  label(ctx, 1.72, 1.30, text(fill: color-base)[$D_(x y) = 0$])
  label(ctx, 2.22, -0.13, [$u$])
  label(ctx, -0.13, 2.02, [$v$])

  // outside the set: the diagonal walk moves down-left, so D > 0
  line((ctx.pt)(uOut, vOut), (ctx.pt)(uOut - zOut, vOut - zOut),
    stroke: (paint: color-accent, thickness: 1pt), mark: (end: ">", scale: 0.5))
  marker(ctx, uOut, vOut, radius: 0.028, color: color-accent)
  label(ctx, uOut + 0.40, vOut + 0.06, text(fill: color-accent)[$D_(x y) > 0$])

  // inside the set: the walk moves up-right, so D < 0
  line((ctx.pt)(uIn, vIn), (ctx.pt)(uIn - zIn, vIn - zIn),
    stroke: (paint: color-accent, thickness: 1pt), mark: (end: ">", scale: 0.5))
  marker(ctx, uIn, vIn, radius: 0.028, color: color-accent)
  label(ctx, uIn - 0.38, vIn + 0.02, text(fill: color-accent)[$D_(x y) < 0$])
})
