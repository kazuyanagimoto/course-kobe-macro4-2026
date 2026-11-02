#import "@preview/cetz:0.3.4"
#import "lib.typ": *
#set page(width: auto, height: auto, margin: .5cm)
#show: fig-style

#show math.equation: block.with(fill: white, inset: 1pt)

// Marginal utility of CRRA utility: decreasing and convex (u_ccc > 0)
#let gam = 1.5
#let uc(c) = calc.pow(c, -gam)

// c' takes c_L or c_H with probability 1/2 each
#let cL = 0.6
#let cH = 1.6
#let cmean = (cL + cH) / 2
#let uc-of-mean = uc(cmean)
#let mean-uc = (uc(cL) + uc(cH)) / 2

#cetz.canvas(length: 4cm, {
  import cetz.draw: *

  let ctx = plot-ctx(x-range: (0, 2.2), y-range: (0, 2.6), size: (2.2, 1.35))

  draw-axes(ctx, style: "left")
  draw-curve(ctx, uc, (0.55, 2.05), stroke: color-base)
  label(ctx, 2.05, uc(2.05) + 0.3, text(fill: color-base)[$u_c (c)$])
  label(ctx, 2.2, -0.16, [$c$])

  // the two outcomes and the chord between them
  draw-vline(ctx, cL, 0, uc(cL), stroke: stroke-dashed)
  draw-vline(ctx, cH, 0, uc(cH), stroke: stroke-dashed)
  draw-vline(ctx, cmean, 0, mean-uc, stroke: stroke-dashed)
  line((ctx.pt)(cL, uc(cL)), (ctx.pt)(cH, uc(cH)), stroke: stroke-guide)
  marker(ctx, cL, uc(cL), radius: 0.025, color: black)
  marker(ctx, cH, uc(cH), radius: 0.025, color: black)
  label(ctx, cL, -0.18, [$c'_L$])
  label(ctx, cH, -0.18, [$c'_H$])
  label(ctx, cmean, -0.2, [$bb(E)[c']$])

  // expected marginal utility (chord midpoint) vs marginal utility at the mean
  draw-hline(ctx, mean-uc, 0, cmean, stroke: stroke-dashed)
  draw-hline(ctx, uc-of-mean, 0, cmean, stroke: stroke-dashed)
  marker(ctx, cmean, mean-uc, radius: 0.025, color: color-accent)
  marker(ctx, cmean, uc-of-mean, radius: 0.025, color: color-base)
  label(ctx, -0.04, mean-uc, text(fill: color-accent)[$bb(E)[u_c (c')]$], anchor: "east")
  label(ctx, -0.04, uc-of-mean, text(fill: color-base)[$u_c (bb(E)[c'])$], anchor: "east")
  line((ctx.pt)(cmean + 0.07, uc-of-mean + 0.04), (ctx.pt)(cmean + 0.07, mean-uc - 0.04),
    stroke: color-accent, mark: (end: ">", scale: 0.6))
  label(ctx, cmean + 0.12, (uc-of-mean + mean-uc) / 2, text(fill: color-accent)[risk], anchor: "west")
})
