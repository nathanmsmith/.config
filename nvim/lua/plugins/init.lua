local helpers = require("custom-helpers")

return {
  -- Color theme
  "nathanmsmith/night-owl.vim",

  -- Linting
  { "mfussenegger/nvim-lint" },
  -- Formatting
  -- { "mhartington/formatter.nvim" },
  {
    "stevearc/conform.nvim",
    opts = {},
  },

  -- Treesitter

  -- Editing nicities
  "tpope/vim-commentary",
  "tpope/vim-surround",
  "tpope/vim-repeat",
  {
    "tpope/vim-unimpaired",
    config = function()
      -- Let's call it PascalCase, not MixedCase
      vim.keymap.set("n", "crp", "crm", { remap = true })
      -- Also kebabcase
      vim.keymap.set("n", "cr-", "crk", { remap = true })
    end,
  },
  "tpope/vim-characterize",
  "tpope/vim-speeddating",
  "tpope/vim-rsi",
  "tpope/vim-abolish",
  "tpope/vim-sleuth",
  "tpope/vim-projectionist",

  {
    "ThePrimeagen/harpoon",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    config = function()
      vim.keymap.set({ "n" }, "ma", function()
        require("harpoon.mark").add_file()
        print("Mark added")
      end, { desc = "Add mark (Harpoon)" })
      vim.keymap.set({ "n" }, "ml", require("telescope").extensions.harpoon.marks, { desc = "List marks (Harpoon)" })
      for i = 1, 9 do
        vim.keymap.set({ "n" }, "m" .. i, function()
          require("harpoon.ui").nav_file(i)
        end, { desc = "Navigate to mark " .. i })
      end
    end,
  },

  {
    "ckolkey/ts-node-action",
    dependencies = { "nvim-treesitter" },
    config = function()
      require("ts-node-action").setup({})
      vim.keymap.set({ "n" }, "gs", require("ts-node-action").node_action, { desc = "Trigger Node Action" })
    end,
  },

  -- Suggestions
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    config = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 200
      require("which-key").setup({})
    end,
  },

  -- Autopair
  {
    "windwp/nvim-autopairs",
    config = function()
      require("nvim-autopairs").setup({})
    end,
  },

  -- Tim Pope Extensions
  "tpope/vim-eunuch",

  -- File navigation
  {
    "stevearc/oil.nvim",
    commit = "956d7fc89b0bd1f9ea6515ca10c1e2a293e4d8fd",
    config = function()
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
            return helpers.contains({ ".DS_Store" }, name)
          end,
        },
      })
      vim.keymap.set("n", "-", require("oil").open, { desc = "Open parent directory" })
    end,
  },
  "stsewd/gx-extended.vim",

  -- Autohide search highlighting on move
  "romainl/vim-cool",

  -- Show Marks
  -- "kshenoy/vim-signature",

  -- Text object modifications and extensions
  {
    "chaoren/vim-wordmotion",
    config = function()
      vim.g.wordmotion_spaces = { "w@<=-w@=", "w@<=_w@=", ".", ":" }
    end,
  },

  {
    "echasnovski/mini.ai",
    version = "*",
    config = function()
      require("mini.ai").setup({
        custom_textobjects = {
          -- Replicate the "entire" object from https://github.com/kana/vim-textobj-entire
          e = function()
            local from = { line = 1, col = 1 }
            local to = {
              line = vim.fn.line("$"),
              col = math.max(vim.fn.getline("$"):len(), 1),
            }
            return { from = from, to = to }
          end,
        },
      })
    end,
  },
  { "echasnovski/mini.splitjoin", version = "*", config = true },

  -- Testing
  "vim-test/vim-test",
  "preservim/vimux",

  -- File picking
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { { "nvim-lua/plenary.nvim" } },
  },
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    build = "make",
    cond = function()
      return vim.fn.executable("make") == 1
    end,
  },
  { "nvim-telescope/telescope-ui-select.nvim" },

  -- Diagnostics
  {
    "folke/trouble.nvim",
    cmd = { "TroubleToggle", "Trouble" },
    opts = {
      icons = false,
      fold_open = "v", -- icon used for open folds
      fold_closed = ">", -- icon used for closed folds
      indent_lines = false, -- add an indent guide below the fold icons
      signs = {
        -- icons / text used for a diagnostic
        error = "error",
        warning = "warn",
        hint = "hint",
        information = "info",
      },
      use_diagnostic_signs = false, -- enabling this will use the signs defined in your lsp client
    },
    keys = {
      { "<leader>xx", "<cmd>TroubleToggle workspace_diagnostics<cr>", desc = "Workspace Diagnostics (Trouble)" },
      { "<leader>xl", "<cmd>TroubleToggle loclist<cr>", desc = "Location List (Trouble)" },
      { "<leader>xq", "<cmd>TroubleToggle quickfix<cr>", desc = "Quickfix List (Trouble)" },
      {
        "[q",
        function()
          if require("trouble").is_open() then
            require("trouble").previous({ skip_groups = true, jump = true })
          else
            local ok, err = pcall(vim.cmd.cprev)
            if not ok then
              vim.notify(err, vim.log.levels.ERROR)
            end
          end
        end,
        desc = "Previous trouble/quickfix item",
      },
      {
        "]q",
        function()
          if require("trouble").is_open() then
            require("trouble").next({ skip_groups = true, jump = true })
          else
            local ok, err = pcall(vim.cmd.cnext)
            if not ok then
              vim.notify(err, vim.log.levels.ERROR)
            end
          end
        end,
        desc = "Next trouble/quickfix item",
      },
    },
  },

  -- Maximize current split
  "szw/vim-maximizer",

  -- Profiling
  "dstein64/vim-startuptime",
}
