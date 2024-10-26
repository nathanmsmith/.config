-- Plugin configuration related to snippets and autocompletion
return {
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      -- Snippet Engine & its associated nvim-cmp source
      {
        "L3MON4D3/LuaSnip",
        build = "make install_jsregexp",
      },
      "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
    },
    config = function()
      require("snippets")
      require("completion")
    end,
  },
  {
    "chrisgrieser/nvim-scissors",
    dependencies = "nvim-telescope/telescope.nvim",
    opts = {
      snippetDir = vim.fn.stdpath("config") .. "/snippets",
      telescope = {
        alsoSearchSnippetBody = true,
      },
      jsonFormatter = "none",
    },
    config = function()
      vim.api.nvim_create_user_command("SnippetEdit", function()
        require("scissors").editSnippet()
      end, { desc = "Edit snippets" })
      vim.api.nvim_create_user_command("SnippetAdd", function()
        require("scissors").addNewSnippet()
      end, { desc = "Add a snippet" })
    end,
  },
}
