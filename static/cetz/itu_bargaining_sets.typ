#import "@preview/cetz:0.3.4"
#import "lib.typ": *
#set page(width: auto, height: auto, margin: .5cm)
#set text(size: 7pt)

// Six bargaining sets, one per model of transferability.  Each frontier is the
// exact curve implied by its distance-to-frontier function, so editing the
// parameters below moves the drawing with them.

#let xmin = -0.7
#let xmax = 2.1
#let ymin = -0.7
#let ymax = 2.5

// (A) TU: u + v <= Phi
#let phiTU = 1.55
#let fTU(u) = phiTU - u

// (B) NTU: u <= alpha, v <= gamma
#let alphaN = 1.15
#let gammaN = 1.30

// (C) LTU: lambda u + zeta v <= Phi, slope -lambda/zeta different from -1
#let lam = 0.8235
#let zet = 1.1765
#let phiL = 1.5883
#let fLTU(u) = (phiL - lam * u) / zet

// (D) ETU: exp((u - a)/tau) + exp((v - g)/tau) <= B
#let etu(u, a, g, bb) = {
  let inner = bb - calc.exp(u - a)
  if inner <= 0.0001 { -9.0 } else { g + calc.ln(inner) }
}
#let fETU(u) = etu(u, 0.0, 0.0, 6.0)

// (E) intersection of two LTU sets: a convex (progressive) tax schedule
#let kinkU = 0.80
#let kinkV = 0.95
#let fSteep(u) = kinkV - 1.60 * (u - kinkU)
#let fShallow(u) = kinkV - 0.35 * (u - kinkU)
#let fINT(u) = calc.min(fShallow(u), fSteep(u))

// (F) union of two ETU sets: a menu of two public-good levels
#let fBuy(u) = etu(u, 0.6823, 1.7328, 2.0)
#let fUNI(u) = calc.max(fETU(u), fBuy(u))

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
    draw-curve(ctx, f, visible(f), stroke: (paint: black, thickness: 1pt))
  }
  label(ctx, 0.42, 0.42, text(fill: rgb("#33556a"))[$cal(F)_(x y)$])
  label(ctx, 2.0, 0.19, text(size: 6pt)[$u$])
  label(ctx, -0.16, 2.4, text(size: 6pt)[$v$])
  label(ctx, 0.7, -1.16, tag)
}

#cetz.canvas(length: 3cm, {
  import cetz.draw: *

  let mk() = plot-ctx(x-range: (xmin, xmax), y-range: (ymin, ymax), size: (1.05, 1.05))
  let dx = 1.5
  let dy = 1.42

  // ---- (A) TU ---------------------------------------------------------------
  group({
    let ctx = mk()
    panel(ctx, [(A) TU], f: fTU)
  })

  // ---- (B) NTU --------------------------------------------------------------
  group({
    translate((dx, 0))
    let ctx = mk()
    panel(ctx, [(B) NTU], f: u => if u <= alphaN { gammaN } else { -9.0 },
      draw-frontier: {
        draw-hline(ctx, gammaN, xmin, alphaN, stroke: (paint: black, thickness: 1pt))
        draw-vline(ctx, alphaN, ymin, gammaN, stroke: (paint: black, thickness: 1pt))
      })
  })

  // ---- (C) LTU --------------------------------------------------------------
  group({
    translate((0, -dy))
    let ctx = mk()
    panel(ctx, [(C) LTU], f: fLTU)
  })

  // ---- (D) ETU --------------------------------------------------------------
  group({
    translate((dx, -dy))
    let ctx = mk()
    panel(ctx, [(D) ETU], f: fETU)
  })

  // ---- (E) intersection of LTU sets -----------------------------------------
  group({
    translate((0, -2 * dy))
    let ctx = mk()
    panel(ctx, [(E) LTU intersection], f: fINT)
  })

  // ---- (F) union of ETU sets ------------------------------------------------
  group({
    translate((dx, -2 * dy))
    let ctx = mk()
    panel(ctx, [(F) ETU union], f: fUNI)
  })
})
