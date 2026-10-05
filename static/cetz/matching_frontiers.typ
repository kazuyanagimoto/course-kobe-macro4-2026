#import "@preview/cetz:0.3.4"
#import "lib.typ": *
#set page(width: auto, height: auto, margin: .5cm)
#set text(size: 7pt)

// Pareto frontiers of the four models of transferability, in a 2 x 2 grid.
// The functional forms follow itu_bargaining_sets.typ; the ITU panel uses a
// union of two ETU sets whose frontiers cross with a clear inward kink.

#let xmin = -0.7
#let xmax = 2.1
#let ymin = -0.7
#let ymax = 2.5

// TU: u + v <= Phi
#let fTU(u) = 1.55 - u

// NTU: u <= alpha, v <= gamma
#let alphaN = 1.15
#let gammaN = 1.30

// LTU: lambda u + zeta v <= Phi, slope -lambda/zeta different from -1
#let fLTU(u) = (1.5883 - 0.8235 * u) / 1.1765

// ITU: union of two ETU sets, exp((u - a)/tau) + exp((v - g)/tau) <= B.  Left of the
// crossing the steep frontier is on top, right of it the flat one, so the
// frontier bends inward (non-convex) at the crossing.
#let etu(u, a, g, bb, tau: 1.0) = {
  let inner = bb - calc.exp((u - a) / tau)
  if inner <= 0.0001 { -9.0 } else { g + tau * calc.ln(inner) }
}
#let fITU(u) = calc.max(etu(u, 0.0, 0.0, 6.0), etu(u, 1.5375, 0.9667, 2.0, tau: 0.4))

// Sub-interval of the window over which a decreasing frontier is visible.
#let visible(f) = {
  let lo = if f(xmin) <= ymax { xmin } else { bisect(x => ymax - f(x), xmin, xmax) }
  let hi = if f(xmax) >= ymin { xmax } else { bisect(x => f(x) - ymin, xmin, xmax) }
  (lo, hi)
}

#let panel(ctx, tag, f: none, draw-frontier: none) = {
  import cetz.draw: *
  let g = if f == none { u => ymin } else { u => clamp(f(u), ymin, ymax) }
  fill-between(ctx, g, (xmin, xmax), base: ymin, samples: 300,
    color: color-base.transparentize(72%))
  draw-axes(ctx, style: "school-book")
  if draw-frontier != none {
    draw-frontier
  } else {
    draw-curve(ctx, f, visible(f), samples: 400, stroke: (paint: black, thickness: 1pt))
  }
  label(ctx, 2.0, 0.19, text(size: 6pt)[$u$])
  label(ctx, -0.16, 2.4, text(size: 6pt)[$v$])
  label(ctx, 0.7, -1.16, tag)
}

#cetz.canvas(length: 3cm, {
  import cetz.draw: *

  let mk() = plot-ctx(x-range: (xmin, xmax), y-range: (ymin, ymax), size: (1.05, 1.05))
  let dx = 1.5
  let dy = 1.42

  group({
    let ctx = mk()
    panel(ctx, [(A) TU], f: fTU)
  })

  group({
    translate((dx, 0))
    let ctx = mk()
    panel(ctx, [(B) NTU], f: u => if u <= alphaN { gammaN } else { -9.0 },
      draw-frontier: {
        draw-hline(ctx, gammaN, xmin, alphaN, stroke: (paint: black, thickness: 1pt))
        draw-vline(ctx, alphaN, ymin, gammaN, stroke: (paint: black, thickness: 1pt))
        marker(ctx, alphaN, gammaN, radius: 0.025, color: black)
      })
  })

  group({
    translate((0, -dy))
    let ctx = mk()
    panel(ctx, [(C) LTU], f: fLTU)
  })

  group({
    translate((dx, -dy))
    let ctx = mk()
    panel(ctx, [(D) ITU], f: fITU)
  })
})
