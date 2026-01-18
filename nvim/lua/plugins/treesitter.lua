return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,
    dependencies = {
      { "nvim-treesitter/nvim-treesitter-textobjects", branch = "main" },
      { "windwp/nvim-ts-autotag", branch = "main" },
      "RRethy/nvim-treesitter-endwise", -- No main branch yet, uses master
    },
    build = ":TSUpdate",
    config = function()
      require("treesitter")
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter-context",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    opts = {
      enable = true,
      max_lines = 10, -- How many lines the window should span
      min_window_height = 0, -- Minimum editor window height to enable context
      line_numbers = true,
      multiline_threshold = 1, -- Maximum number of lines to show for a single context
      trim_scope = "outer", -- Which context lines to discard if max_lines is exceeded
      mode = "cursor", -- Line used to calculate context. 'cursor' or 'topline'
    },
  },

  {
    "folke/ts-comments.nvim",
    opts = {},
    event = "VeryLazy",
  },

  -- Better use of %
  {
    "andymass/vim-matchup",
    config = function()
      vim.g.matchup_surround_enabled = true
      vim.g.matchup_delim_noskips = 1
      vim.g.matchup_matchparen_offscreen = {}
    end,
  },

  -- gs
  {
    "ckolkey/ts-node-action",
    dependencies = { "nvim-treesitter" },
    config = function()
      require("ts-node-action").setup({})
      vim.keymap.set({ "n" }, "gs", require("ts-node-action").node_action, { desc = "Trigger Node Action" })
    end,
  },
}
