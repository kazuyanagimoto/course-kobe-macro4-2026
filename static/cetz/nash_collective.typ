#import "@preview/cetz:0.3.4"
#import "lib.typ": *
#set page(width: auto, height: auto, margin: .5cm)
#set text(size: 8pt)

#show math.equation: block.with(fill: white, inset: 1pt)

// Pareto frontier u_H = Psi(u_W): strictly concave and decreasing
#let front(x) = 1.8 - 0.25 * x - 0.45 * x * x
#let dfront(x) = -0.25 - 0.9 * x
#let xmax = 1.6

// (a) collective model: the point where the frontier has slope -mu/(1-mu)
#let xa = 0.9
#let ya = front(xa)
#let sa = dfront(xa)

// (b) Nash bargaining with threat point T and weight beta
#let TW = 0.25
#let TH = 0.35
#let bta = 0.4
#let xb = 0.8497
#let yb = front(xb)
#let sb = dfront(xb)
#let ray = (yb - TH) / (xb - TW)
#let K = calc.pow(xb - TW, bta) * calc.pow(yb - TH, 1 - bta)
#let nash(x) = TH + calc.pow(K / calc.pow(x - TW, bta), 1 / (1 - bta))

#let panel(ctx, title) = {
  import cetz.draw: *
  fill-between(ctx, front, (0, xmax), color: gray.transparentize(88%))
  draw-axes(ctx, style: "school-book")
  draw-curve(ctx, front, (0, xmax), stroke: color-base)
  label(ctx, 0.35, 1.05, text(fill: gray)[$cal(U)$])
  label(ctx, 1.8, 0.42, text(fill: color-base)[$u_H = Psi(u_W)$])
  label(ctx, 1.95, -0.14, [$u_W$])
  label(ctx, -0.12, 2.15, [$u_H$])
  label(ctx, 0.95, 2.32, title)
}

#cetz.canvas(length: 3cm, {
  import cetz.draw: *

  // ---- (a) collective model --------------------------------------------------
  let ctx = plot-ctx(x-range: (-0.15, 2.0), y-range: (-0.2, 2.4), size: (2.15, 1.75))
  panel(ctx, [*(a) Collective model*])
  // an iso-weight line below the frontier, and the tangent one
  line((ctx.pt)(0.3, 0.9 + sa * (0.3 - xa)), (ctx.pt)(1.5, 0.9 + sa * (1.5 - xa)),
    stroke: stroke-dashed)
  label(ctx, 1.68, 0.12, text(fill: gray)[$mu u_W + (1 - mu) u_H = "const"$])
  line((ctx.pt)(0.3, ya + sa * (0.3 - xa)), (ctx.pt)(1.5, ya + sa * (1.5 - xa)),
    stroke: (paint: color-accent, thickness: 1pt))
  marker(ctx, xa, ya, radius: 0.028, color: color-accent)
  label(ctx, xa + 0.36, ya + 0.12, [$(u_W^*, u_H^*)$])
  label(ctx, 0.42, 1.95, text(fill: color-accent)[$"slope " -mu \/ (1 - mu)$])

  // ---- (b) Nash bargaining ---------------------------------------------------
  group({
    translate((2.75, 0))
    let ctx = plot-ctx(x-range: (-0.15, 2.0), y-range: (-0.2, 2.4), size: (2.15, 1.75))
    panel(ctx, [*(b) Nash bargaining*])
    // threat point and the ray to the solution
    marker(ctx, TW, TH, radius: 0.028, color: black)
    label(ctx, TW - 0.1, TH - 0.1, [$T$])
    line((ctx.pt)(TW, TH), (ctx.pt)(1.02, TH + ray * (1.02 - TW)), stroke: stroke-dashed)
    label(ctx, 0.82, 0.6, text(fill: gray)[$"slope " (u_H^* - T_H) \/ (u_W^* - T_W)$])
    // level curve of the Nash product through the solution
    draw-curve(ctx, nash, (0.62, 1.55), stroke: (dash: "dashed", paint: color-base))
    label(ctx, 1.45, 1.55, text(fill: color-base)[$(u_W - T_W)^beta (u_H - T_H)^(1 - beta) = "const"$])
    // tangent at the solution
    line((ctx.pt)(0.35, yb + sb * (0.35 - xb)), (ctx.pt)(1.45, yb + sb * (1.45 - xb)),
      stroke: (paint: color-accent, thickness: 1pt))
    marker(ctx, xb, yb, radius: 0.028, color: color-accent)
    label(ctx, xb + 0.36, yb + 0.12, [$(u_W^*, u_H^*)$])
    label(ctx, 0.62, 1.98, text(fill: color-accent)[$"slope " -frac(beta, 1 - beta) dot frac(u_H^* - T_H, u_W^* - T_W)$])
  })
})
