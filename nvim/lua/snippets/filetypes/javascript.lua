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

-- Basic javascript features

-- console.log
snip({ trig = "cl", dscr = "console.log()" }, fmt("console.log({})", { i(0) }))
snip({ trig = "cll", dscr = "console.log() with label" }, fmt('console.log("{}: ", {})', { rep(1), i(1) }))

-- testing
snip(
  { trig = "desc", dscr = "describe" },
  fmt(
    [[
describe('{}', () => {{
  {}
}})
]],
    { i(1, "MyThing"), i(0) }
  )
)
snip(
  { trig = "it", dscr = "it" },
  fmt(
    [[
it('{}', () => {{
  {}
}})
]],
    { i(1, "does something"), i(0) }
  )
)
snip({ trig = "tb", dscr = "to be" }, fmt("expect({}).toBe({})", { i(1, "thing"), i(0, "other thing") }))
snip({ trig = "te", dscr = "to equal" }, fmt("expect({}).toEqual({})", { i(1, "thing"), i(0, "other thing") }))

return snippets, autosnippets
