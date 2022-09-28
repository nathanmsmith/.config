local typescript_snippets, typescript_autosnippets = require("snippets.filetypes.typescript")
local snippets, autosnippets = vim.deepcopy(typescript_snippets), vim.deepcopy(typescript_autosnippets)

return snippets, autosnippets
