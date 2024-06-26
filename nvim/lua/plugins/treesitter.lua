return {
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
      "windwp/nvim-ts-autotag",
      "RRethy/nvim-treesitter-endwise",
    },
    build = ":TSUpdate",
    config = function()
      require("treesitter")
    end,
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
