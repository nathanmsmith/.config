-- Remap space as leader key
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins", {
  performance = {
    rtp = {
      -- disable some rtp plugins
      disabled_plugins = {
        "gzip",
        "matchit",
        "matchparen",
        "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})

require("vanilla")
require("statusline")
require("projectionist")
require("fuzzy_find")
require("lsp")
require("completion")
require("snippets")

-- (12/17/22) Right now, the formatting experience provided by null-ls and lsp-format beats that of formatter.nvim.
-- I'm keeping around my old formatting config in case that changes in the future.
-- I've had no problems with nvim-lint; I'm only using null-ls for formatting.
-- require("formatting")
require("diagnostic")

require("treesitter")
require("git")
require("testing")

vim.cmd([[
  source ~/.config/nvim/config/custom-commands.vim
  :command! -nargs=1 Browse silent execute '!open' shellescape(<q-args>,1)
]])
