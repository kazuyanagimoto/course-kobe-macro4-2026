-- A link from a statement to its proof in the appendix.
--
-- A theorem-like div names the heading of its proof with a `proof` attribute:
--
--   ::: {#prp-reservation proof="prf-reservation"}
--
-- and gets a link to that heading as its last element, in place of a
-- sentence like "証明は付録にあります" after every statement:
--
--   HTML    a small "証明 →" button at the bottom right of the box
--   Typst   a right-aligned line "証明 → A.4.1節 (p. 245)"
--
-- The heading is looked up in the files listed in _quarto.yml, so the
-- attribute holds only the id. The filter runs before Quarto, which turns
-- the .qmd link into the right .html path.

local headings -- id -> { path = <project-relative .qmd>, title = <string> }

local function read(path)
  local f = io.open(path, "r")
  if f == nil then
    return nil
  end
  local s = f:read("a")
  f:close()
  return s
end

local function load_headings()
  headings = {}
  local dir = quarto.project.directory or "."
  local yml = read(pandoc.path.join({ dir, "_quarto.yml" }))
  if yml == nil then
    return
  end
  for line in yml:gmatch("[^\n]+") do
    local path = line:match("^%s*%-%s+part:%s+(%S+%.qmd)%s*$")
      or line:match("^%s*%-%s+(%S+%.qmd)%s*$")
    local src = path and read(pandoc.path.join({ dir, path }))
    if src then
      for title, id in ("\n" .. src):gmatch("\n#+%s+([^\n]-)%s*{#([%w%-]+)[^\n]*}") do
        headings[id] = { path = path, title = title }
      end
    end
  end
end

local function html_link(id, heading)
  local dir = quarto.project.directory or "."
  local here = pandoc.path.directory(quarto.doc.input_file)
  local target = pandoc.path.make_relative(pandoc.path.join({ dir, heading.path }), here, true)
  local link = pandoc.Link(
    { pandoc.Str("証明"), pandoc.Span({ pandoc.Str("→") }, { class = "arrow", ["aria-hidden"] = "true" }) },
    target .. "#" .. id,
    "付録: " .. heading.title
  )
  return pandoc.Div({ pandoc.Plain({ link }) }, { class = "proof-link" })
end

local function typst_link(id)
  local label = "<" .. id .. ">"
  return pandoc.RawBlock("typst", table.concat({
    -- Quarto sets a statement in emphasis, and emphasis toggles italics, so
    -- an inner `emph` keeps the numbers upright (an upright `text` would not).
    "#block(width: 100%, above: 0.6em, align(right, text(size: 0.9em, emph(",
    "  link(" .. label .. ")[#strong[証明] #sym.arrow.r #context {",
    "    let loc = locate(" .. label .. ")",
    "    let h = query(" .. label .. ").first()",
    "    if h.numbering != none [#numbering(h.numbering, ..counter(heading).at(loc))節 ]",
    "    [(p. #counter(page).at(loc).first())]",
    "  }]))))",
  }, "\n"))
end

function Div(el)
  local id = el.attributes.proof
  if id == nil then
    return nil
  end
  el.attributes.proof = nil
  if headings == nil then
    load_headings()
  end
  local heading = headings[id]
  if heading == nil then
    quarto.log.warning("proof-link: no heading {#" .. id .. "} in the chapters of _quarto.yml")
    return el
  end
  if quarto.doc.is_format("html") then
    el.content:insert(html_link(id, heading))
  elseif quarto.doc.is_format("typst") then
    el.content:insert(typst_link(id))
  end
  return el
end
