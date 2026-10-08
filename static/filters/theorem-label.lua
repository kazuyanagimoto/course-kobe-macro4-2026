-- HTML only. Quarto writes a theorem's label into the first paragraph of the
-- environment. When the environment opens with a list, that paragraph holds
-- nothing but the label and a non-breaking space, and with the label set on a
-- line of its own (styles.css) the space would leave an empty line. Drop it.
local function is_blank(inline)
  if inline.t == "Space" or inline.t == "SoftBreak" then
    return true
  end
  return inline.t == "Str" and inline.text:gsub("\u{a0}", ""):match("^%s*$") ~= nil
end

function Div(el)
  if not quarto.doc.is_format("html") or not el.classes:includes("theorem") then
    return nil
  end
  local first = el.content[1]
  if first == nil or first.t ~= "Para" then
    return nil
  end
  local inlines = first.content
  local label = inlines[1]
  if label == nil or label.t ~= "Span" or not label.classes:includes("theorem-title") then
    return nil
  end
  for i = 2, #inlines do
    if not is_blank(inlines[i]) then
      return nil
    end
  end
  el.content[1] = pandoc.Para({ label })
  return el
end
