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
-- local autosnip = create_snip(autosnippets)

snip({
  trig = "frozen",
  dscr = "Frozen string literal",
}, t("# frozen_string_literal: true"))

snip({
  trig = "req",
  dscr = "require",
}, fmt("require '{}'", { i(1) }))
snip({
  trig = "reqr",
  dscr = "require relative",
}, fmt("require_relative '{}'", { i(1) }))

-- Logic Control
local case = fmt(
  [[
case {}
when {}
  {}
end
]],
  { i(1), i(2), i(0) }
)
snip({
  trig = "case",
  dscr = "case/switch statement",
}, case)
-- snip({
--   trig = "switch",
--   dscr = "case/switch statement",
-- }, case:copy()

-- Sorbet
snip({ trig = "let", dscr = "Sorbet: define a variable" }, fmt("{} = T.let({}, {})", { i(1), i(2), i(3) }))
snip({ trig = "tsig", dscr = "Sorbet: extend T::Sig" }, t("extend T::Sig"))
snip(
  { trig = "sig", dscr = "Sorbet: add function signature" },
  fmt([[sig {{ params({}).returns({}) }}]], { i(1, "param: Type"), i(2, "Type") })
)
snip({ trig = "prop", dscr = "Sorbet: structure prop" }, fmt([[prop :{}, {}]], { i(1, "Field"), i(2, "Type") }))
snip({ trig = "const", dscr = "Sorbet: structure const prop" }, fmt([[const :{}, {}]], { i(1, "Field"), i(2, "Type") }))
snip(
  { trig = "struct", dscr = "Sorbet: structure" },
  fmt(
    [[
class {} < T::Struct
  {}
end
]],
    { i(1, "MyStruct"), i(0) }
  )
)
snip(
  { trig = "enum", dscr = "Sorbet: enum" },
  fmt(
    [[
class {} < T::Struct
  enums do
    {} = new
    {}
  end
end
]],
    { i(1, "MyEnum"), i(2, "Value"), i(0) }
  )
)
snip({ trig = "tnil", dscr = "T.nilable()" }, fmt([[T.nilable({})]], { i(0) }))

-- Debugging
snip({ trig = "pry", dscr = "Insert pry breakpoint" }, t("binding.pry"))

-- Testing
snip(
  { trig = "desc", dscr = "Testing: describe statement" },
  fmt(
    [[
describe "{}" do
  {}
end
  ]],
    { i(1, "my thing"), i(0, "it 'does something'") }
  )
)
snip(
  { trig = "it", dscr = "Testing: it statement" },
  fmt(
    [[
it "{}" do
  {}
end
  ]],
    { i(1, "does something"), i(0, "# TODO: implement") }
  )
)
snip(
  { trig = "before", dscr = "Testing: before statement" },
  fmt(
    [[
before do
  {}
end
  ]],
    { i(0, "# TODO: implement") }
  )
)

return snippets, autosnippets
