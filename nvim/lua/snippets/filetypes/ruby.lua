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

-- snippet prop "Structure prop" b
-- prop :${1:Field}, ${0:Type}
-- endsnippet

-- snippet const "Structure const prop" b
-- const :${1:Field}, ${0:Type}
-- endsnippet

-- snippet struct "structure" b
-- class ${1:MyStruct} < T::Struct
-- 	$0
-- end
-- endsnippet

-- snippet enum "enum" b
-- class ${1:MyEnum} < T::Enum
-- 	enums do
-- 		${2:Value} = new
-- 		$0
-- 	end
-- end
-- endsnippet

-- snippet tnil "T.nilable()"
-- T.nilable($0)
-- endsnippet

-- Debugging
snip({ trig = "pry", dscr = "Insert pry breakpoint" }, t("require 'pry'; binding.pry"))

-- Testing
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

return snippets, autosnippets
