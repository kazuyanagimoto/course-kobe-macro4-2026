// Pure-cetz plotting helpers (no cetz-plot dependency).
//
// All figures share this small library so that the look (axes, colours,
// dashed guides) stays consistent and is easy to tweak in one place.
//
// The idea: build a `ctx` that knows the data range and the canvas size,
// and exposes `pt(x, y)` mapping a data coordinate to a canvas coordinate.
// Every helper draws in data coordinates by going through `ctx.pt`.

#import "@preview/cetz:0.3.4"

// ---- shared style knobs -----------------------------------------------------
#let color-base = rgb("#107895")
#let color-accent = rgb("#9a2515")
#let color-axis = black
#let stroke-dashed = (dash: "dashed", paint: gray)
#let stroke-guide = (paint: gray)

// ---- coordinate context -----------------------------------------------------
// x-range / y-range: (min, max) of the visible data window.
// size: (width, height) in canvas units (scaled by canvas `length`).
#let plot-ctx(x-range: (0, 1), y-range: (0, 1), size: (2, 1)) = {
  let (xmin, xmax) = x-range
  let (ymin, ymax) = y-range
  let (w, h) = size
  (
    x-range: x-range,
    y-range: y-range,
    size: size,
    pt: (x, y) => (
      (x - xmin) / (xmax - xmin) * w,
      (y - ymin) / (ymax - ymin) * h,
    ),
  )
}

// ---- axes -------------------------------------------------------------------
// style: "school-book" (arrows crossing the origin) or "left" (L-shaped, on the
// bottom-left edges of the data window).
#let draw-axes(ctx, style: "school-book", paint: color-axis,
               arrow: (end: ">", scale: 0.7)) = {
  import cetz.draw: *
  let (xmin, xmax) = ctx.x-range
  let (ymin, ymax) = ctx.y-range
  if style == "school-book" {
    line((ctx.pt)(xmin, 0), (ctx.pt)(xmax, 0), stroke: paint, mark: arrow)
    line((ctx.pt)(0, ymin), (ctx.pt)(0, ymax), stroke: paint, mark: arrow)
  } else if style == "left" {
    line((ctx.pt)(xmin, ymin), (ctx.pt)(xmax, ymin), stroke: paint, mark: arrow)
    line((ctx.pt)(xmin, ymin), (ctx.pt)(xmin, ymax), stroke: paint, mark: arrow)
  }
}

// ---- curves and lines -------------------------------------------------------
// Sample f over `domain` and draw it as a polyline.
#let draw-curve(ctx, f, domain, samples: 200, ..style) = {
  import cetz.draw: *
  let (x0, x1) = domain
  let pts = range(0, samples + 1).map(i => {
    let x = x0 + (x1 - x0) * i / samples
    (ctx.pt)(x, f(x))
  })
  line(..pts, ..style.named())
}

#let draw-vline(ctx, x, y0, y1, ..style) = {
  import cetz.draw: *
  line((ctx.pt)(x, y0), (ctx.pt)(x, y1), ..style.named())
}

#let draw-hline(ctx, y, x0, x1, ..style) = {
  import cetz.draw: *
  line((ctx.pt)(x0, y), (ctx.pt)(x1, y), ..style.named())
}

// Filled region between f and the horizontal line y = base over `domain`.
#let fill-between(ctx, f, domain, base: 0, samples: 100,
                  color: color-base.transparentize(70%), edge: none) = {
  import cetz.draw: *
  let (x0, x1) = domain
  let top = range(0, samples + 1).map(i => {
    let x = x0 + (x1 - x0) * i / samples
    (ctx.pt)(x, f(x))
  })
  let pts = top + ((ctx.pt)(x1, base), (ctx.pt)(x0, base))
  line(..pts, close: true, fill: color, stroke: edge)
}

// ---- annotations ------------------------------------------------------------
#let label(ctx, x, y, body, ..style) = {
  import cetz.draw: *
  content((ctx.pt)(x, y), body, ..style.named())
}

#let marker(ctx, x, y, radius: 0.035, color: gray, edge: none) = {
  import cetz.draw: *
  circle((ctx.pt)(x, y), radius: radius, fill: color, stroke: edge)
}
