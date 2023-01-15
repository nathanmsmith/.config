local iterm_command = "python3 ~/.config/iTerm/Scripts/run-test.py"

vim.g["test#custom_strategies"] = {
  iterm = function(test_command)
    print(test_command)
    local full_command = vim.fn.join({ iterm_command, vim.fn.shellescape(test_command) })
    vim.fn.execute("silent !" .. full_command)
  end,
}
vim.g["test#strategy"] = "iterm"

vim.keymap.set("n", "<leader>t", ":TestNearest<CR>", { silent = true, desc = "Run nearest [t]est" })
vim.keymap.set("n", "<leader>T", ":TestFile<CR>", { silent = true, desc = "Run file [T]ests" })
vim.keymap.set("n", "<leader>a", ":TestSuite<CR>", { silent = true, desc = "Run [a]ll tests" })
vim.keymap.set("n", "<leader>l", ":TestSuite<CR>", { silent = true, desc = "Run [l]ast test" })
