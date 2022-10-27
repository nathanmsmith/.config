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
local create_snip = require("snippets.helpers").create_snip

local snippets, autosnippets = {}, {}
local snip = create_snip(snippets)
local autosnip = create_snip(autosnippets)

-- Basic lua features

snip(
  { trig = "local", dscr = "Declare local variable" },
  fmt("local {} = {}", {
    i(1, "variable"),
    i(0, "10"),
  })
)

snip({ trig = "for", dscr = "for loop" }, {
  t("for "),
  c(1, {
    sn(nil, { i(1, "k"), t(", "), i(2, "v"), t(" in "), c(3, { t("pairs"), t("ipairs") }), t("("), i(4), t(")") }),
    sn(nil, { i(1, "i"), t(" = "), i(2), t(", "), i(3) }),
  }),
  t({ " do", "\t" }),
  i(0),
  t({ "", "end" }),
})

-- TODO: function

-- Neovim Specific
snip(
  { trig = "snip", dscr = "Add a new LuaSnip snippet" },
  fmt([[snip({{ trig = "{}", dscr = "{}"}}, {})]], {
    i(1, "trigger"),
    i(2, "description"),
    i(0, "nodes"),
  })
)

snip(
  { trig = "use", dscr = "Add a new packer plugin entry" },
  fmt("use({})", {
    c(1, {
      { t('"'), i(1, "github/link"), t('"') },
      fmt('{{ "{}", {} }}', {
        i(1, "github/link"),
        i(2, "config = function() ... end"),
      }),
    }),
  })
)

return snippets, autosnippets
