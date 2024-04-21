local helpers = require("custom-helpers")

if helpers.isModuleAvailable("stripe") then
  return {}
else
  return {
    -- I use typescript-tools.nvim for Stripe too but it has separate config
    {
      "pmizio/typescript-tools.nvim",
      dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
      opts = {},
    },
  }
end
