local helpers = require("custom-helpers")

return {
  -- Editing nicities
  "tpope/vim-repeat",
  "tpope/vim-unimpaired",
  "tpope/vim-characterize",
  "tpope/vim-speeddating",
  "tpope/vim-rsi",
  -- "tpope/vim-abolish",
  -- See abolish.lua
  "tpope/vim-projectionist",
  "tpope/vim-eunuch",
  {
    "kylechui/nvim-surround",
    opts = {},
  },

  -- Suggestions
  -- {
  --   "folke/which-key.nvim",
  --   event = "VeryLazy",
  --   config = function()
  --     vim.o.timeout = true
  --     require("which-key").setup({
  --       win = {
  --         border = "rounded",
  --       },
  --       delay = 0,
  --       icons = {
  --         mappings = false,
  --         keys = {
  --           Up = "<Up> ",
  --           Down = "<Down> ",
  --           Left = "<Left> ",
  --           Right = "<Right> ",
  --           C = "<C-…> ",
  --           M = "<M-…> ",
  --           D = "<D-…> ",
  --           S = "<S-…> ",
  --           CR = "<CR> ",
  --           Esc = "<Esc> ",
  --           ScrollWheelDown = "<ScrollWheelDown> ",
  --           ScrollWheelUp = "<ScrollWheelUp> ",
  --           NL = "<NL> ",
  --           BS = "<BS> ",
  --           Space = "<Space> ",
  --           Tab = "<Tab> ",
  --           F1 = "<F1>",
  --           F2 = "<F2>",
  --           F3 = "<F3>",
  --           F4 = "<F4>",
  --           F5 = "<F5>",
  --           F6 = "<F6>",
  --           F7 = "<F7>",
  --           F8 = "<F8>",
  --           F9 = "<F9>",
  --           F10 = "<F10>",
  --           F11 = "<F11>",
  --           F12 = "<F12>",
  --         },
  --       },
  --     })
  --   end,
  -- },

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
    opts = function()
      local ai = require("mini.ai")
      return {
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

          ["r"] = ai.gen_spec.treesitter({ -- code block
            a = { "@block.outer", "@conditional.outer", "@loop.outer" },
            i = { "@block.inner", "@conditional.inner", "@loop.inner" },
          }),

          f = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }), -- function
          c = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }), -- class

          -- Tags, but allow dashes like <custom-tag>
          -- ref: https://github.com/echasnovski/mini.ai/blob/main/lua/mini/ai.lua#L1114
          -- ["t"] = false,
          ["t"] = ai.gen_spec.treesitter({ a = "@tag.outer", i = "@tag.inner" }),
        },
      }
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
  { "brenoprata10/nvim-highlight-colors", opts = { render = "virtual", enable_tailwind = true } },

  { "pteroctopus/faster.nvim", opts = {} },

  {
    "godlygeek/tabular",
    -- config = function()
    --   _G.align = function()
    --     print("align")
    --     local pattern = "^%s*|"
    --     local lineNumber = vim.fn.line(".")
    --     local currentColumn = vim.fn.col(".")
    --     local previousLine = vim.fn.getline(lineNumber - 1)
    --     local currentLine = vim.fn.getline(".")
    --     local nextLine = vim.fn.getline(lineNumber + 1)
    --
    --     print(previousLine)
    --     print(currentLine)
    --     print(nextLine)
    --     print(vim.fn.exists(":Tabularize"))
    --     print(currentLine:match("^%s*|"))
    --     print(previousLine:match(pattern))
    --     print(nextLine:match(pattern))
    --     print(
    --       vim.fn.exists(":Tabularize")
    --         and currentLine:match("^%s*|")
    --         and (previousLine:match(pattern) or nextLine:match(pattern))
    --     )
    --
    --     if
    --       vim.fn.exists(":Tabularize")
    --       and currentLine:match("^%s*|")
    --       and (previousLine:match(pattern) or nextLine:match(pattern))
    --     then
    --       print("running tabular")
    --       local column = #currentLine:sub(1, currentColumn):gsub("[^|]", "")
    --       local position = #vim.fn.matchstr(currentLine:sub(1, currentColumn), ".*|\\s*\\zs.*")
    --       vim.cmd("Tabularize/|/l1") -- `l` means left aligned and `1` means one space of cell padding
    --       vim.cmd("normal! 0")
    --       vim.fn.search(("[^|]*|"):rep(column) .. ("\\s\\{-\\}"):rep(position), "ce", lineNumber)
    --     end
    --   end
    --
    --   vim.keymap.set("i", "|", "|<Esc>:lua _G.align()<CR>a", { silent = true })
    -- end,
  },
}
