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

require("config.lazy")

require("vanilla")
require("windows")
require("marks")
require("user-commands")
require("autocmds")
require("statusline")
require("fuzzy_find")

require("abolish")

-- I keep my work specific configuration in a private work repo and connect it via symlinks.
-- `helpers.isModuleAvailable("stripe")` is how I check to see if work files are present, i.e., I'm on a work machine.
if helpers.isModuleAvailable("stripe") then
  require("stripe").initClipboard()
  require("stripe").initTests()
  require("stripe-sourcegraph")
else
  require("projectionist")
end
require("formatting")
require("diagnostic")
require("testing")
require("git")
require("meta")
require("scratchpad")
