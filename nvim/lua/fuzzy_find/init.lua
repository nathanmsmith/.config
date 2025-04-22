local helpers = require("custom-helpers")

if helpers.isModuleAvailable("stripe") then
  require("stripe-fuzzy_find").initFuzzyFind()
end

vim.keymap.set("n", "<leader>p", require("fzf-lua").files, { desc = "Search Files" })
vim.keymap.set("n", "<leader>h", require("fzf-lua").help_tags, { desc = "Search [H]elp" })
vim.keymap.set("n", "<leader>k", require("fzf-lua").keymaps, { desc = "Search [K]eymaps" })
vim.keymap.set("n", "<leader>w", require("fzf-lua").grep_cword, { desc = "[S]earch current [W]ord" })
vim.keymap.set("n", "<leader>f", require("fzf-lua").live_grep, { desc = "[F]ind by Grep" })
-- vim.keymap.set("n", "<leader>d", require("fzf-lua").diagnostics, { desc = "[S]earch [D]iagnostics" })
vim.keymap.set("n", "<leader>?", require("fzf-lua").oldfiles, { desc = "[?] Find recently opened files" })
vim.keymap.set("n", "<leader>m", require("fzf-lua").marks, { desc = "[M]arks" })
vim.keymap.set("n", "<leader>b", require("fzf-lua").buffers, { desc = "Find existing [B]uffers" })
vim.keymap.set("n", "<leader>/", require("fzf-lua").blines, { desc = "[/] Fuzzily search in current buffer]" })

if helpers.isModuleAvailable("stripe") then
  require("stripe-fuzzy_find").initKeybinds()
end
