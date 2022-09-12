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
local same = require("snippets.helpers").same

local javascript_snippets = require("snippets.filetypes.javascript")[1]
local snippets, autosnippets = vim.deepcopy(javascript_snippets), {}
local snip = create_snip(snippets)
local autosnip = create_snip(autosnippets)

-- Basic javascript features

-- Skeleton templates
-- autosnip(
-- 	{ trig = "__test", dscr = "Test skeleton template" },
-- 	fmt("describe('{}', () => {{ {} }})", {
-- 		i(1, "my module"),
-- 		i(2, "..."),
-- 	})
-- )

return snippets, autosnippets
