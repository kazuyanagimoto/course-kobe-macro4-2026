#import "@preview/cetz:0.3.4"
#import "lib.typ": *
#set page(width: auto, height: auto, margin: .5cm)
#set text(size: 8pt)

// Pareto efficiency versus Pareto weights on a non-convex bargaining set.
// The set is the union of two ETU sets, one per level of a discrete public good
// (rent / buy).  Its Pareto frontier is the upper envelope; the frontier of its
// convex hull bridges the inward notch with the common tangent of the two
// curves.  Points on the black arc strictly between the tangency points are
// Pareto efficient but are never selected by maximising a weighted sum.

#let etu(u, a, g, bb) = {
  let inner = bb - calc.exp(u - a)
  if inner <= 0.0001 { -9.0 } else { g + calc.ln(inner) }
}

// curve 1 ("rent"): reaches further in u; curve 2 ("buy"): further in v
#let a1 = 0.0
#let g1 = 0.0
#let b1 = 6.0
#let a2 = 0.6823
#let g2 = 1.7328
#let b2 = 2.0
#let f1(u) = etu(u, a1, g1, b1)
#let f2(u) = etu(u, a2, g2, b2)
#let fmax(u) = calc.max(f1(u), f2(u))

#let xmin = -0.7
#let xmax = 2.3
#let ymin = -0.7
#let ymax = 2.5

// Tangency point of slope s on an ETU curve: exp(u - a) = b s / (s - 1).
#let utan(s, a, bb) = a + calc.ln(bb * s / (s - 1))
// Common tangent: the slope at which the two tangency points lie on one line.
#let gap(s) = {
  let ur = utan(s, a1, b1)
  let ul = utan(s, a2, b2)
  f1(ur) - f2(ul) - s * (ur - ul)
}
#let sTan = bisect(gap, -0.3, -8.0)
#let uL = utan(sTan, a2, b2)
#let vL = f2(uL)
#let uR = utan(sTan, a1, b1)
#let vR = f1(uR)

#let uBottom = bisect(u => fmax(u) - ymin, 0.0, a1 + calc.ln(b1) - 0.0001)

#let tag(body, fill: black) = box(fill: white, inset: 1.5pt, text(fill: fill, body))

#cetz.canvas(length: 3cm, {
  import cetz.draw: *

  let ctx = plot-ctx(x-range: (xmin, xmax), y-range: (ymin, ymax), size: (1.9, 2.03))

  fill-between(ctx, u => clamp(fmax(u), ymin, ymax), (xmin, xmax), samples: 400,
    base: ymin, color: color-base.transparentize(78%))
  draw-axes(ctx, style: "school-book")

  // frontier of the convex hull: the common tangent replaces the notch
  draw-curve(ctx, f2, (xmin, uL), stroke: (paint: color-accent, thickness: 1.1pt))
  line((ctx.pt)(uL, vL), (ctx.pt)(uR, vR), stroke: (paint: color-accent, thickness: 1.1pt))
  draw-curve(ctx, f1, (uR, uBottom), stroke: (paint: color-accent, thickness: 1.1pt))

  // the allocations the Pareto weights approach cannot reach: between the
  // common tangent and the Pareto frontier itself
  let lens = range(0, 61).map(i => {
    let u = uL + (uR - uL) * i / 60
    (ctx.pt)(u, vL + sTan * (u - uL))
  }) + range(0, 61).map(i => {
    let u = uR - (uR - uL) * i / 60
    (ctx.pt)(u, fmax(u))
  })
  line(..lens, close: true, fill: color-accent.transparentize(80%), stroke: none)

  // Pareto frontier of the union, drawn on top
  draw-curve(ctx, fmax, (xmin, uBottom), samples: 400,
    stroke: (paint: black, thickness: 1.2pt))

  marker(ctx, uL, vL, radius: 0.03, color: color-accent)
  marker(ctx, uR, vR, radius: 0.03, color: color-accent)

  // leaders first, so the boxed labels sit on top of them
  line((ctx.pt)(1.60, 1.72), (ctx.pt)(1.14, 1.10), stroke: stroke-guide)
  line((ctx.pt)(0.70, 0.92), (ctx.pt)(0.98, 1.18), stroke: stroke-guide)

  label(ctx, 1.72, 1.92, tag([convex hull frontier], fill: color-accent))
  label(ctx, 0.32, 0.82, tag([Pareto frontier]))

  label(ctx, 0.45, 0.15, text(fill: rgb("#33556a"))[$cal(F)_(x y)$])
  label(ctx, 2.22, -0.13, [$u$])
  label(ctx, -0.13, 2.41, [$v$])
})
