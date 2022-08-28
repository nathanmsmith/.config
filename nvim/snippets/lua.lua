local ls = require("luasnip")
local s = ls.s
local i = ls.i
local t = ls.t
local d = ls.dynamic_node
local c = ls.choice_node
local f = ls.function_node
local sn = ls.snippet_node
local fmt = require("luasnip.extras.fmt").fmt
local rep = require("luasnip.extras").rep

local snippets, autosnippets = {}, {}

local function snip(context, nodes, opts)
  local snippet = s(context, nodes, opts)
  table.insert(snippets, snippet)
end

-- Basic lua features

-- Neovim Specific
snip(
  { trig = "snip", dscr = "Add a new LuaSnip snippet" },
  fmt("snip({}, {})", {
    i(1, "trigger"),
    i(2, "nodes"),
  })
)

snip(
  { trig = "use", dscr = "Add a new packer plugin entry" },
  fmt("use({})", {
    c(1, {
       {t("\""), i(1, "github/link"), t("\"")},
       fmt("{{ \"{}\", {} }}", {
         i(1, "github/link"),
         i(2, "config = function() ... end"),
       })
    }),
  })
)

return snippets, autosnippets
