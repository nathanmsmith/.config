local typescript_snippets = require("snippets.filetypes.typescript")[1]
local snippets, autosnippets = vim.deepcopy(typescript_snippets), {}

return snippets, autosnippets
