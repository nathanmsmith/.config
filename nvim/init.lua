-- Welcome! 👋
-- This is my config for Neovim.

vim.cmd("colorscheme nightowl")

local helpers = require("custom-helpers")

-- Remap space as leader key
-- See `:help mapleader`
-- This must happen before plugins are loaded, otherwise the wrong leader will be used
-- I also unmap <Space> first so that it doesn't do anything weird if I hit it intending to hit <Leader>.
-- I'm not sure if it's needed, but it seems good to have!
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Bootstrap lazy.nvim, the "modern plugin manager for Neovim".
-- More details: https://github.com/folke/lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
-- See: https://www.reddit.com/r/neovim/comments/1cvrilk/diagnosticwarning_after_upgrade_to_neovim_010/
--- @diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)
require("lazy").setup("plugins", {
  performance = {
    rtp = {
      -- Disable builtin vim plugins that I don't use.
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
  change_detection = {
    enabled = not helpers.isModuleAvailable("stripe"),
    notify = true,
  },
  ui = {
    border = "single",
  },
})

require("vanilla")
require("autocmds")
require("statusline")

-- I keep my work specific configuration in a private work repo and connect it via symlinks.
-- `helpers.isModuleAvailable("stripe")` is how I check to see if work files are present, i.e., I'm on a work machine.
if helpers.isModuleAvailable("stripe") then
  require("stripe").initClipboard()
else
  require("projectionist")
end
require("formatting")
require("diagnostic")
require("testing")

vim.cmd([[
  source ~/.config/nvim/config/custom-commands.vim
  :command! -nargs=1 Browse silent execute '!open' shellescape(<q-args>,1)
]])

require("scratchpad")
