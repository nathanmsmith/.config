local helpers = require("custom-helpers")

return {
  -- Linting
  { "mfussenegger/nvim-lint" },
  -- Formatting
  { "stevearc/conform.nvim", opts = {} },

  -- Comment easily
  "tpope/vim-commentary",

  -- Editing nicities
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
  "tpope/vim-projectionist",
  "tpope/vim-eunuch",

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

  -- File navigation
  {
    "stevearc/oil.nvim",
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
            return helpers.contains({ ".DS_Store", ".." }, name)
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
      local before_words = function(s, w)
        local before = [[\%(]] .. w .. s .. [[*\)\@<=]]
        return before .. s
      end

      local after_words = function(s, w)
        local after = [[\%(]] .. s .. "*" .. w .. [[\)\@=]]
        return s .. after
      end

      -- Construct vim regex such that character `s` is matched only between words
      -- ref: https://github.com/chaoren/vim-wordmotion/blob/master/autoload/wordmotion.vim#L35
      local between_words = function(s, w)
        local before = [[\%(]] .. w .. s .. [[*\)\@<=]]
        local after = [[\%(]] .. s .. "*" .. w .. [[\)\@=]]
        return before .. s .. after
      end

      local alpha = "[[:lower:][:upper:]]"
      local alnum = "[[:lower:][:upper:][:digit:]]"
      local alnum_with_graph = "[[:lower:][:upper:][:digit:][:graph:]]"

      vim.g.wordmotion_spaces = {
        between_words("_", alnum),
        between_words("-", alpha),
        between_words([[\.]], alnum),
        before_words(",", alnum_with_graph),
        after_words(",", alnum_with_graph),
        before_words(":", alnum_with_graph),
        after_words(":", alnum_with_graph),
        before_words('"', alnum_with_graph),
        after_words('"', alnum_with_graph),
        before_words("'", alnum_with_graph),
        after_words("'", alnum_with_graph),
        before_words("(", alnum_with_graph),
        after_words("(", alnum_with_graph),
        before_words(")", alnum_with_graph),
        after_words(")", alnum_with_graph),
        before_words("`", alnum_with_graph),
        after_words("`", alnum_with_graph),
        before_words("%", alnum_with_graph),
        after_words("%", alnum_with_graph),
        before_words("\\[", alnum_with_graph),
        after_words("\\[", alnum_with_graph),
        before_words("\\]", alnum_with_graph),
        after_words("\\]", alnum_with_graph),
        before_words("{", alnum_with_graph),
        after_words("{", alnum_with_graph),
        before_words("}", alnum_with_graph),
        after_words("}", alnum_with_graph),
        before_words(";", alnum_with_graph),
        after_words(";", alnum_with_graph),
        before_words("?", alnum_with_graph),
        after_words("?", alnum_with_graph),
        before_words("=", alnum_with_graph),
        after_words("=", alnum_with_graph),
        before_words("<", alnum_with_graph),
        after_words("<", alnum_with_graph),
        before_words(">", alnum_with_graph),
        after_words(">", alnum_with_graph),
      }

      -- vim.g.wordmotion_spaces = { "_", "-", "[", "]", "(", ")", "{", "}", "'", '"', ",", ".", "/" }
    end,
  },

  {
    "echasnovski/mini.ai",
    version = "*",
    config = function()
      require("mini.ai").setup({
        n_lines = 1000,
        search_method = "cover",
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
  { "echasnovski/mini.splitjoin", version = "*", opts = {} },
  {
    "echasnovski/mini.surround",
    version = "*",
    config = function()
      require("mini.surround").setup({
        mappings = {
          add = "ys",
          delete = "ds",
          find = "",
          find_left = "",
          highlight = "",
          replace = "cs",
          update_n_lines = "",

          -- Add this only if you don't want to use extended mappings
          suffix_last = "",
          suffix_next = "",
        },
        search_method = "cover_or_next",
      })

      -- Remap adding surrounding to Visual mode selection
      vim.keymap.del("x", "ys")
      vim.keymap.set("x", "S", [[:<C-u>lua MiniSurround.add('visual')<CR>]], { silent = true })

      -- Make special mapping for "add surrounding for line"
      vim.keymap.set("n", "yss", "ys_", { remap = true })
    end,
  },

  -- Testing
  "vim-test/vim-test",
  "preservim/vimux",

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

  {
    "folke/todo-comments.nvim",
    event = "VimEnter",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      signs = false,
      highlight = {
        keyword = "fg",
      },
      -- TODO: Get keywords like "TODO" and "FIXME" to underline
    },
  },

  -- Maximize current split
  "szw/vim-maximizer",

  -- Profiling
  -- "dstein64/vim-startuptime",
  --

  { "kevinhwang91/nvim-bqf", ft = "qf" },

  {
    "NvChad/nvim-colorizer.lua",
    opts = {
      -- TODO: make these options filetype-specific
      user_default_options = {
        RGB = true, -- #RGB hex codes
        RRGGBB = true, -- #RRGGBB hex codes
        names = false, -- "Name" codes like Blue or blue
        RRGGBBAA = true, -- #RRGGBBAA hex codes
        AARRGGBB = true, -- 0xAARRGGBB hex codes
      },
    },
  },
}
