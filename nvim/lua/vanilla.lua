vim.cmd([[colorscheme night-owl]])
vim.o.termguicolors = true

-- Show line numbers
vim.wo.number = true

-- Show whitespace
vim.o.list = true
vim.opt.listchars = {
  tab = "▸ ",
  extends = "❯",
  precedes = "❮",
  trail = "·",
  nbsp = "·",
  space = "·",
}

-- Highlight the column after 'textwidth'
vim.o.colorcolumn = "+1"

--Decrease update time
vim.o.updatetime = 250

-- Set program title to 'nvim'
vim.o.title = true
vim.go.titlestring = "nvim"

-- Always show sign column
vim.o.signcolumn = "yes"

-- Highlight the current line, don't highlight the current column
vim.o.cursorline = true
vim.o.cursorcolumn = false

-- Don't redraw for macros
vim.o.lazyredraw = true

-- Diff Mode
vim.opt.diffopt:append("internal")

-- Highlight colors
require("colorizer").setup(nil, { css = true })

-- Evenly resize windows on screen change
local resize_group = vim.api.nvim_create_augroup("WindowWatcher", { clear = true })
vim.api.nvim_create_autocmd("VimResized", { command = "wincmd =", group = resize_group, pattern = "*" })

-- Reset the cursor on exit
-- See https://github.com/neovim/neovim/issues/4867#issuecomment-291249173
-- and https://github.com/neovim/neovim/wiki/FAQ#cursor-style-isnt-restored-after-exiting-nvim
local cursor_group = vim.api.nvim_create_augroup("Cursor", { clear = true })
vim.api.nvim_create_autocmd({ "VimLeave", "VimSuspend" }, {
  callback = function()
    vim.o.guicursor = "a:ver25-blinkon1"
    -- Round identations: https://vimtricks.com/p/ensuring-aligned-indentation/
    vim.opt.shiftround = true
  end,
  group = cursor_group,
  pattern = "*",
})

-- More sensible window splits
vim.opt.splitbelow = true
vim.opt.splitright = true

-- Easier split navigation
-- https://thoughtbot.com/blog/vim-splits-move-faster-and-more-naturally
-- ref: http://vimcasts.org/episodes/working-with-windows/
vim.keymap.set("n", "<C-J>", "<C-W><C-J>")
vim.keymap.set("n", "<C-K>", "<C-W><C-K>")
vim.keymap.set("n", "<C-L>", "<C-W><C-L>")
vim.keymap.set("n", "<C-H>", "<C-W><C-H>")

vim.g.maximizer_set_default_mapping = false
vim.keymap.set("n", "<C-W>m", "<Cmd>MaximizerToggle<CR>", { silent = true })
-- TODO: enable this line after I figure out more about libtermkey stuff
-- https://neovim.io/news/2022/04#distinguishing-modifier-keys
-- https://sw.kovidgoyal.net/kitty/keyboard-protocol/
-- vim.keymap.set('n', '<C-M>', '<Cmd>MaximizerToggle<CR>', {silent = true})

-- Remap space as leader key
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Searching
-- Case insensitive by default, case sensitive with an uppercase char
vim.o.ignorecase = true
vim.o.smartcase = true

-- Don't lose track of edits
vim.g.hidden = false

-- Replacing
vim.opt.inccommand = "nosplit"

--Enable mouse mode
vim.o.mouse = "a"

-- Highlight on yank
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank({ timeout = 1000 })
  end,
  group = highlight_group,
  pattern = "*",
})

-- Disable swapfiles
vim.opt.swapfile = false

-- Use system clipboard
vim.opt.clipboard = "unnamedplus"

-- Whitespace characters settings
-- refs:
-- - http://vimcasts.org/episodes/tabs-and-spaces/
-- - http://vimcasts.org/episodes/show-invisibles/
-- View tabs as 2 spaces wide
vim.opt.tabstop = 2
-- Ident by 2
vim.opt.shiftwidth = 2
-- Use spaces instead of tabs
vim.opt.expandtab = true
-- Tab to the current indent level
vim.opt.smarttab = true
-- Autoindent new lines
vim.opt.autoindent = true
-- Round identations: https://vimtricks.com/p/ensuring-aligned-indentation/
vim.opt.shiftround = true

-- Global substitution by default
vim.opt.gdefault = true

-- Use persistent undo history.
-- Default home is $XDG_DATA_HOME/nvim/undo/
-- vim.opt.undofile = true

-- hide files in netrw
vim.g.netrw_list_hide = ".*.swp$,.DS_Store,*/tmp/*,*.so,*.swp,*.zip,*.git,^..=/=$"

-- Spell Checking
-- refs:
-- - http://vimcasts.org/episodes/spell-checking/
-- Spell file location
-- vim.opt.spellfile = "$HOME/.config/nvim/spell/dictionary.utf-8.add"
vim.opt.spelllang = "en_us"
vim.opt.spell = true
vim.opt.spelloptions = "camel"

-- make Y consistent with C and D.
vim.keymap.set("n", "Y", "y$")

-- Open images in an image viewer (probably Preview)
-- TODO: Not working
-- local external_files_group = vim.api.nvim_create_augroup("ExternalOpener", { clear = true })
-- vim.api.nvim_create_autocmd("BufEnter", {
--   command = 'exec "silent !open ".expand("%") | :bw',
--   group = external_files_group,
--   pattern = { "*.png", "*.jpg", "*.gif" },
-- })
--

vim.g.netrw_localrmdir = "rm -r"

-- TODO: convert to lua
-- set shell=/usr/bin/env\ bash

local trailing_whitespace_group = vim.api.nvim_create_augroup("TrimTrailingWhiteSpace", { clear = true })
vim.api.nvim_create_autocmd(
  "BufWritePre",
  { command = "%s/\\s\\+$//e", group = trailing_whitespace_group, pattern = "*" }
)
vim.api.nvim_create_autocmd(
  "BufWritePre",
  { command = "%s/\\n\\+%$//e", group = trailing_whitespace_group, pattern = "*" }
)

vim.o.grepprg = "rg --vimgrep --no-heading --smart-case"
vim.o.grepformat = "%f:%l:%c:%m"
