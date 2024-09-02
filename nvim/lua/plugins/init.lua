local helpers = require("custom-helpers")

return {
  -- Linting
  { "mfussenegger/nvim-lint" },
  -- Formatting
  { "stevearc/conform.nvim", opts = {} },

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
    "kylechui/nvim-surround",
    version = "*",
    event = "VeryLazy",
    opts = {},
  },

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
      require("which-key").setup({
        icons = {
          mappings = false,
          keys = {
            Up = "<Up> ",
            Down = "<Down> ",
            Left = "<Left> ",
            Right = "<Right> ",
            C = "<C-…> ",
            M = "<M-…> ",
            D = "<D-…> ",
            S = "<S-…> ",
            CR = "<CR> ",
            Esc = "<Esc> ",
            ScrollWheelDown = "<ScrollWheelDown> ",
            ScrollWheelUp = "<ScrollWheelUp> ",
            NL = "<NL> ",
            BS = "<BS> ",
            Space = "<Space> ",
            Tab = "<Tab> ",
            F1 = "<F1>",
            F2 = "<F2>",
            F3 = "<F3>",
            F4 = "<F4>",
            F5 = "<F5>",
            F6 = "<F6>",
            F7 = "<F7>",
            F8 = "<F8>",
            F9 = "<F9>",
            F10 = "<F10>",
            F11 = "<F11>",
            F12 = "<F12>",
          },
        },
      })
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
        before_words("(", alnum),
        after_words("(", alnum),
        before_words(")", alnum),
        after_words(")", alnum),
        before_words("`", alnum_with_graph),
        after_words("`", alnum_with_graph),
        before_words("%", alnum_with_graph),
        after_words("%", alnum_with_graph),
        before_words("\\[", alnum),
        after_words("\\[", alnum),
        before_words("\\]", alnum),
        after_words("\\]", alnum),
        before_words("{", alnum),
        after_words("{", alnum),
        before_words("}", alnum),
        after_words("}", alnum),
        before_words(";", alnum),
        after_words(";", alnum_with_graph),
        before_words("?", alnum_with_graph),
        after_words("?", alnum_with_graph),
        before_words("=", alnum),
        after_words("=", alnum),
        before_words("<", alnum),
        after_words("<", alnum),
        before_words(">", alnum),
        after_words(">", alnum),
        before_words("/", alnum_with_graph),
        after_words("/", alnum_with_graph),
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
          -- Disable brackets alias in favor of builtin block textobject
          ["b"] = false,

          -- Replicate the "entire" object from https://github.com/kana/vim-textobj-entire
          ["e"] = function()
            local from = { line = 1, col = 1 }
            local to = {
              line = vim.fn.line("$"),
              col = math.max(vim.fn.getline("$"):len(), 1),
            }
            return { from = from, to = to }
          end,

          -- Tags, but allow dashes like <custom-tag>
          -- ref: https://github.com/echasnovski/mini.ai/blob/main/lua/mini/ai.lua#L1114
          ["t"] = { "<([%w-]-)%f[^<%w][^<>]->.-</%1>", "^<.->().*()</[^/]->$" },
        },
      })
    end,
  },
  { "echasnovski/mini.splitjoin", version = "*", opts = {} },

  -- Testing
  "vim-test/vim-test",
  "preservim/vimux",

  -- Maximize current split
  "szw/vim-maximizer",

  -- Profiling
  -- "dstein64/vim-startuptime",
  --

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

  {
    "m4xshen/hardtime.nvim",
    dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
    opts = {},
  },
}
