-- CeTZ figures at their natural size.
--
-- static/cetz/lib.typ sets the text of every figure at the size the reader
-- should see, so the notes must not scale the SVGs. This filter gives each
-- image from static/cetz/ the width that shows it at scale 1 in the PDF: its
-- natural width over the text width of the jsbook page. The HTML uses the same
-- percentage, so all CeTZ figures share one scale there too. A figure is made
-- larger in its canvas `length`, not here, and a `width` in the source is
-- overridden.

local TEXT_WIDTH_PT = 450 -- js package, A4 at 10pt

local function natural_width(src)
  local dir = quarto.project.directory or "."
  local f = io.open(pandoc.path.join({ dir, (src:gsub("^/", "")) }), "r")
  if f == nil then
    return nil
  end
  local head = f:read(1000)
  f:close()
  return tonumber(head:match('<svg[^>]-%swidth="([%d.]+)pt"'))
end

function Image(el)
  if not el.src:match("^/?static/cetz/[^/]+%.svg$") then
    return nil
  end
  local width = natural_width(el.src)
  if width == nil then
    quarto.log.warning("cetz-width: no width in pt in " .. el.src)
    return nil
  end
  el.attributes.width = string.format("%.1f%%", 100 * width / TEXT_WIDTH_PT)
  return el
end
