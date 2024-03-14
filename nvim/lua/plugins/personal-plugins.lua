local helpers = require("custom-helpers")

if helpers.isModuleAvailable("stripe") then
  return {}
else
  return {
    "tpope/vim-rails",
    "tpope/vim-rake",
    "tpope/vim-bundler",

    -- I use typescript-tools.nvim for Stripe too but it has separate config
    {
      "pmizio/typescript-tools.nvim",
      dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
      opts = {
        settings = {
          separate_diagnostic_server = false,
          tsserver_max_memory = 8192,
        },
      },
    },
  }
end
