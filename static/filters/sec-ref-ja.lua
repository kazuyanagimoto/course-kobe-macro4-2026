-- Japanese cross-references to chapters and sections.
--
-- Quarto renders `@sec-x` as "Chapter 7" or "Section 7.1" (チャプター and
-- セクション in the PDF) and has no option for a suffix, so "第7章" cannot be
-- configured. This filter rewrites a plain `@sec-x` before Quarto resolves it:
--
--   chapter            第 -@sec-x 章   ->  第7章
--   appendix chapter   付録 -@sec-x    ->  付録B
--   anything else      -@sec-x 節      ->  7.1節
--
-- Pandoc reads `@sec-x` as a reference only after a space, so the source has
-- spaces around it ("これは @sec-x で"). The spaces between the reference and
-- Japanese text are dropped here; the PDF adds its own CJK-latin spacing.
-- `-@sec-x` (the number alone) and references with a prefix or a suffix are
-- left as they are.
--
-- A chapter is the first level-1 heading of a file listed under `chapters:`
-- or `appendices:` in _quarto.yml.

local kinds -- id -> "chapter" | "appendix", read on first use

local function read(path)
  local f = io.open(path, "r")
  if f == nil then
    return nil
  end
  local s = f:read("a")
  f:close()
  return s
end

local function load_kinds()
  kinds = {}
  local dir = quarto.project.directory or "."
  local yml = read(pandoc.path.join({ dir, "_quarto.yml" }))
  if yml == nil then
    return
  end
  local appendices = false
  for line in yml:gmatch("[^\n]+") do
    if line:match("^%s*appendices:") then
      appendices = true
    elseif line:match("^%s*chapters:") or line:match("^%S") then
      appendices = false
    end
    local path = line:match("^%s*%-%s+part:%s+(%S+%.qmd)%s*$")
      or line:match("^%s*%-%s+(%S+%.qmd)%s*$")
    local src = path and read(pandoc.path.join({ dir, path }))
    local id = src and ("\n" .. src):match("\n#%s[^\n]-{#(sec%-[%w%-]+)")
    if id then
      kinds[id] = appendices and "appendix" or "chapter"
    end
  end
end

-- The rewritten reference, or nil when the Cite is not a plain @sec-x.
local function rewrite(cite)
  if #cite.citations ~= 1 then
    return nil
  end
  local c = cite.citations[1]
  if not c.id:match("^sec%-") or c.mode == "SuppressAuthor"
    or #c.prefix > 0 or #c.suffix > 0 then
    return nil
  end
  if kinds == nil then
    load_kinds()
  end
  local number = pandoc.Cite(
    { pandoc.Str("-@" .. c.id) },
    { pandoc.Citation(c.id, "SuppressAuthor") }
  )
  local kind = kinds[c.id]
  if kind == "chapter" then
    return { pandoc.Str("第"), number, pandoc.Str("章") }
  elseif kind == "appendix" then
    return { pandoc.Str("付録"), number }
  end
  return { number, pandoc.Str("節") }
end

-- Whether a Str ends (last = true) or starts with a CJK character.
local function cjk_edge(inline, last)
  if inline == nil or inline.t ~= "Str" or inline.text == "" then
    return false
  end
  local s = inline.text
  local pos = last and utf8.offset(s, -1) or 1
  local ok, cp = pcall(utf8.codepoint, s, pos)
  return ok and cp >= 0x2E80
end

local function is_space(inline)
  return inline ~= nil and (inline.t == "Space" or inline.t == "SoftBreak")
end

function Inlines(inlines)
  local out = pandoc.Inlines({})
  local changed = false
  local i = 1
  while i <= #inlines do
    local el = inlines[i]
    local new = el.t == "Cite" and rewrite(el) or nil
    if new == nil then
      out:insert(el)
      i = i + 1
    else
      changed = true
      -- drop the space before the reference after Japanese text
      if is_space(out[#out]) and cjk_edge(out[#out - 1], true) then
        out:remove()
      end
      out:extend(new)
      i = i + 1
      -- and the space after it before Japanese text
      if is_space(inlines[i]) and cjk_edge(inlines[i + 1], false) then
        i = i + 1
      end
    end
  end
  if changed then
    return out
  end
  return nil
end
