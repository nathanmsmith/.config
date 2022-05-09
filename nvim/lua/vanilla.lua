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
