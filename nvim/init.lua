-- require("impatient")
-- Put plugin managment first, as it handles installing packer.nvim for later files
require("plugins")
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
]])
