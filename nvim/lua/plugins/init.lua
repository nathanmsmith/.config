return {
  -- Color theme
  "nathanmsmith/night-owl.vim",

  -- LSP Configuration & Plugins
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      -- Automatically install LSPs to stdpath for neovim
      {
        "williamboman/mason.nvim",
        opts = {
          ui = {
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
      "j-hui/fidget.nvim",
      -- Treat formatters as LSPs
      "jose-elias-alvarez/null-ls.nvim",
      -- Auto-format LSP changes on save
      "lukas-reineke/lsp-format.nvim",
      -- Nice LSP settings for Neovim
      "folke/neodev.nvim",
    },
  },

  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
    },
    build = ":TSUpdate",
  },
  "JoosepAlviste/nvim-ts-context-commentstring",
  "windwp/nvim-ts-autotag",
  "RRethy/nvim-treesitter-endwise",
  "nvim-treesitter/playground",

  -- Git
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
  },

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
    config = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 200
      require("which-key").setup({
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      })
    end,
  },

  -- Completion
  "hrsh7th/cmp-nvim-lsp",
  "hrsh7th/cmp-buffer",
  "hrsh7th/cmp-path",
  "hrsh7th/cmp-cmdline",
  "hrsh7th/nvim-cmp",
  "onsails/lspkind-nvim",
  "saadparwaiz1/cmp_luasnip",

  -- Snippets
  "L3MON4D3/LuaSnip",

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
    "tamago324/lir.nvim",
    config = function()
      local actions = require("lir.actions")
      vim.api.nvim_set_keymap("n", "-", [[<Cmd>execute 'e ' .. expand('%:p:h')<CR>]], { noremap = true })
      require("lir").setup({
        show_hidden_files = true,
        ignore = { ".DS_Store", "node_modules" },
        devicons_enable = false,
        hide_cursor = true,
        mappings = {
          ["<CR>"] = actions.edit,
          ["-"] = actions.up,

          ["<C-s>"] = actions.split,
          ["<C-v>"] = actions.vsplit,
          ["<C-t>"] = actions.tabedit,

          ["q"] = actions.quit,

          ["d"] = actions.mkdir,
          ["%"] = actions.newfile,
          ["R"] = actions.rename,
          ["Y"] = actions.yank_path,
          ["."] = actions.toggle_show_hidden,
          ["D"] = actions.delete,
        },
      })
    end,
  },
  "stsewd/gx-extended.vim",

  -- Autohide search highlighting on move
  "romainl/vim-cool",

  -- Show Marks
  "kshenoy/vim-signature",

  -- Highlight colors
  "norcalli/nvim-colorizer.lua",

  -- Text object modifications and extensions
  {
    "chaoren/vim-wordmotion",
    config = function()
      vim.g.wordmotion_spaces = { "w@<=-w@=", "w@<=_w@=", ".", ":" }
    end,
  },

  "wellle/targets.vim",
  {
    "whatyouhide/vim-textobj-xmlattr",
    dependencies = {
      "kana/vim-textobj-user",
    },
  },
  {
    "kana/vim-textobj-entire",
    dependencies = {
      "kana/vim-textobj-user",
    },
  },

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

  -- Formatting
  "mhartington/formatter.nvim",

  -- Linting/Diagnostics
  "mfussenegger/nvim-lint",
  {
    "folke/trouble.nvim",
    cmd = { "TroubleToggle", "Trouble" },
    opts = { use_diagnostic_signs = true, icons = false },
    keys = {
      { "<leader>xx", "<cmd>TroubleToggle workspace_diagnostics<cr>", desc = "Workspace Diagnostics (Trouble)" },
      { "<leader>xl", "<cmd>TroubleToggle loclist<cr>", desc = "Location List (Trouble)" },
      { "<leader>xq", "<cmd>TroubleToggle quickfix<cr>", desc = "Quickfix List (Trouble)" },
    },
  },

  -- Maximize current split
  "szw/vim-maximizer",

  -- Better use of %
  {
    "andymass/vim-matchup",
    config = function()
      vim.g.matchup_surround_enabled = true
      vim.g.matchup_matchparen_offscreen = {}
    end,
  },

  -- Languages
  "vim-ruby/vim-ruby",
  "hashivim/vim-terraform",
  "blankname/vim-fish",
  "mustache/vim-mustache-handlebars",
  "cespare/vim-toml",
  {
    "fatih/vim-go",
    config = function()
      vim.g.go_gopls_enabled = false
    end,
  },

  "dstein64/vim-startuptime",

  -- if helpers.isModuleAvailable("stripe") then
  --   require("stripe").loadPlugins(use)
  -- else
  --   "tpope/vim-rails"
  --   "tpope/vim-rake"
  --   "tpope/vim-bundler"
  -- end
}
