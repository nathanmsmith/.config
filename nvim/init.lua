-- Put plugin managment first, as it handles installing packer.nvim for later files
local is_bootstrap = require("plugins")
if is_bootstrap then
  return
end

require("impatient")

require("vanilla")
require("statusline")
require("projectionist")
require("fuzzy_find")
require("lsp")
require("completion")
require("snippets")
require("diagnostic")
require("formatting")
require("treesitter")
require("git")

vim.cmd([[
  source ~/.config/nvim/config/testing.vim
  source ~/.config/nvim/config/custom-commands.vim
  :command! -nargs=1 Browse silent execute '!open' shellescape(<q-args>,1)
]])
