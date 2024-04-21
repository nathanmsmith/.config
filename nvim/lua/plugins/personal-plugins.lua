local helpers = require("custom-helpers")

if helpers.isModuleAvailable("stripe") then
  return {}
else
  return {
    {
      "tpope/vim-rails",
      config = function()
        vim.api.nvim_create_autocmd("FileType", {
          pattern = "eruby.yaml",
          command = "set filetype=yaml",
        })
      end,
    },
    "tpope/vim-rake",
    "tpope/vim-bundler",

    -- I use typescript-tools.nvim for Stripe too but it has separate config
    {
      "pmizio/typescript-tools.nvim",
      dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
      opts = {},
    },
  }
end
