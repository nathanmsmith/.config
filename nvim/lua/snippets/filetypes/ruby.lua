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

return snippets, autosnippets
