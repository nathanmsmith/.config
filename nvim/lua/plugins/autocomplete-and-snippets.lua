-- Plugin configuration related to snippets and autocompletion
return {
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      -- Snippet Engine & its associated nvim-cmp source
      {
        "L3MON4D3/LuaSnip",
        build = (function()
          -- Build Step is needed for regex support in snippets
          -- This step is not supported in many windows environments
          -- Remove the below condition to re-enable on windows
          if vim.fn.has("win32") == 1 or vim.fn.executable("make") == 0 then
            return
          end
          return "make install_jsregexp"
        end)(),
      },
      "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "onsails/lspkind-nvim",
    },
    config = function()
      require("completion")
      require("snippets")
    end,
  },
  {
    "ray-x/lsp_signature.nvim",
    event = "VeryLazy",
    opts = {
      floating_window = false,
      hint_prefix = "",
      hint_inline = function()
        return true
      end,
    },
  },
  -- Autopair
  {
    "windwp/nvim-autopairs",
    opts = {},
  },
  {
    "chrisgrieser/nvim-scissors",
    dependencies = "nvim-telescope/telescope.nvim",
    opts = {
      snippetDir = vim.fn.stdpath("config") .. "/snippets",
      telescope = {
        alsoSearchSnippetBody = true,
      },
      jsonFormatter = "jq",
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
