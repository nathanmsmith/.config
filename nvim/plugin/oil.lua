vim.pack.add({ "https://github.com/stevearc/oil.nvim" })
local helpers = require("custom-helpers")

require("oil").setup({
  keymaps = {
    ["<C-h>"] = false,
    ["<C-l>"] = false,
    ["<C-s>"] = false,
    ["<C-t>"] = false,
    ["<C-p>"] = false,
    ["<C-c>"] = false,
    ["<C-r>"] = "actions.refresh",
  },
  view_options = {
    show_hidden = true,
    is_always_hidden = function(name, bufnr)
      return helpers.contains({ ".DS_Store", ".." }, name)
    end,
  },
  confirmation = {
    border = "single",
  },
})
vim.keymap.set("n", "-", require("oil").open, { desc = "Open parent directory" })
