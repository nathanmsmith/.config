-- LSP plugins and configuration
return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      -- Automatically install LSPs to stdpath for neovim
      {
        "mason-org/mason.nvim",
        opts = {
          ui = {
            -- TODO(2025-05-28): We should be able to remove this once other plugins (telescope, lazy) support 'winborder'
            border = "single",
            icons = {
              server_installed = "✓",
              server_pending = "➜",
              server_uninstalled = "✗",
            },
          },
        },
        config = true,
      },
      "williamboman/mason-lspconfig.nvim",
      "WhoIsSethDaniel/mason-tool-installer.nvim",
      -- Useful status updates for LSP
      { "j-hui/fidget.nvim", opts = {} },
      -- Nice LSP settings for Neovim
      {
        "folke/lazydev.nvim",
        ft = "lua",
        opts = {},
      },
    },
    config = function()
      require("lsp.attach")
      require("lsp")
    end,
  },

  -- TypeScript
  {
    "pmizio/typescript-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
  },
  { "davidosomething/format-ts-errors.nvim" },

  -- For JSON+YAML
  "b0o/schemastore.nvim",
}
