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

-- Navigate around tabs easier.
-- This overrides vim's default ctags navigation which is okay because who uses ctags anymore?
vim.keymap.set("n", "[t", ":tabprevious<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "]t", ":tabnext<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "[T", ":tabfirst<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "]T", ":tablast<CR>", { noremap = true, silent = true })
