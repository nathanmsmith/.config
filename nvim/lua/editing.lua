local helpers = require("custom-helpers")

-- undotree (native nvim 0.12+)
vim.cmd("packadd nvim.undotree")
vim.keymap.set("n", "<leader>u", "<cmd>Undotree<cr>", { desc = "Undotree" })

-- vim-rails: eruby.yaml filetype fix
if not helpers.isModuleAvailable("stripe") then
  vim.api.nvim_create_autocmd("FileType", {
    pattern = "eruby.yaml",
    command = "set filetype=yaml",
  })
end
