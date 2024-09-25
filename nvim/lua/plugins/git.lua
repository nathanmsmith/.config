-- Plugin configuration related to Git
return {
  "tpope/vim-fugitive",
  "tpope/vim-rhubarb",
  {
    "rhysd/conflict-marker.vim",
    config = function()
      -- Unimpaired does this [n and ]n (and d[n, d]n)
      vim.g.conflict_marker_enable_mappings = false
      -- disable the default highlight group
      vim.g.conflict_marker_highlight_group = ""
      -- Include text after begin and end markers
      vim.g.conflict_marker_begin = "^<<<<<<< .*$"
      vim.g.conflict_marker_end = "^>>>>>>> .*$"
    end,
  },
  {
    "lewis6991/gitsigns.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      on_attach = function(bufnr)
        local gitsigns = require("gitsigns")

        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        map("n", "]c", function()
          if vim.wo.diff then
            vim.cmd.normal({ "]c", bang = true })
          else
            gitsigns.nav_hunk("next")
          end
        end)

        map("n", "[c", function()
          if vim.wo.diff then
            vim.cmd.normal({ "[c", bang = true })
          else
            gitsigns.nav_hunk("prev")
          end
        end)
      end,
    },
  },
}
