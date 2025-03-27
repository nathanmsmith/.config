-- True color always
vim.o.termguicolors = true

-- Show line numbers
vim.wo.number = true

vim.opt.scrolloff = 20

-- Show whitespace
vim.o.list = true
vim.opt.listchars = {
  tab = "→ ",
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

-- Set cursor, see :h guicursor
vim.o.guicursor =
  "n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor,sm:block-blinkwait175-blinkoff150-blinkon175"

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

-- Spell Checking
-- refs:
-- - http://vimcasts.org/episodes/spell-checking/
-- Spell file location
-- vim.opt.spellfile = "$HOME/.config/nvim/spell/dictionary.utf-8.add"
vim.opt.spelllang = "en_us"
vim.opt.spell = true
vim.opt.spelloptions = "camel"

-- TODO: convert to lua
-- set shell=/usr/bin/env\ bash

vim.o.grepprg = "rg --vimgrep --no-heading --smart-case"
vim.o.grepformat = "%f:%l:%c:%m"

-- Set hover borders
vim.o.winborder = "single"
