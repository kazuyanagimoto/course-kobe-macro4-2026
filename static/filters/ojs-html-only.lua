-- Typst only: drop Observable JS cells. They run in the browser, and in the
-- PDF Quarto would print their source (//| options included) as code.
-- Outside HTML an {ojs} chunk reaches the filters as a CodeBlock whose class
-- is "{ojs}".
function CodeBlock(el)
  if not quarto.doc.is_format("typst") then
    return nil
  end
  if el.classes:includes("{ojs}") or el.classes:includes("ojs") then
    return {}
  end
  return nil
end
