require("ts_context_commentstring").setup({
  commentary_integration = {
    Commentary = "gc",
    CommentaryLine = "gcc",
    ChangeCommentary = "cgc",
    CommentaryUndo = "gcu",
  },
})

require("nvim-treesitter.configs").setup({
  highlight = { enable = true },
  indent = { enable = true },
  -- Plugin config
  autotag = { enable = true },
  endwise = { enable = true },
  matchup = {
    enable = true,
    disable_virtual_text = true,
  },
  playground = {
    enable = true,
    disable = {},
    updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
    persist_queries = false, -- Whether the query persists across vim sessions
  },
  textobjects = {
    select = {
      enable = true,
      lookahead = true,
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ["aa"] = "@parameter.outer",
        ["ia"] = "@parameter.inner",
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
        ["ar"] = "@block.outer",
        ["ir"] = "@block.inner",
      },
    },
    move = {
      enable = true,
      set_jumps = true,
      goto_next_start = {
        ["]m"] = "@function.outer",
        ["]]"] = "@class.outer",
      },
      goto_next_end = {
        ["]M"] = "@function.outer",
        ["]["] = "@class.outer",
      },
      goto_previous_start = {
        ["[m"] = "@function.outer",
        ["[["] = "@class.outer",
      },
      goto_previous_end = {
        ["[M"] = "@function.outer",
        ["[]"] = "@class.outer",
      },
    },
    -- swap = {
    --   enable = true,
    --   swap_next = {
    --     ["<leader>a"] = "@parameter.inner",
    --   },
    --   swap_previous = {
    --     ["<leader>A"] = "@parameter.inner",
    --   },
    -- },
  },
  auto_install = true,
  sync_install = false,
  ignore_install = {},
  ensure_installed = {
    "bash",
    "c",
    "html",
    "javascript",
    "json",
    "lua",
    "luadoc",
    "luap",
    -- "markdown",
    -- "markdown_inline",
    "python",
    "query",
    "regex",
    "swift",
    "tsx",
    "typescript",
    "vim",
    "vimdoc",
    "yaml",
  },
})

-- Folding via Treesitter
vim.o.foldmethod = "expr"
vim.o.foldexpr = "nvim_treesitter#foldexpr()"
vim.o.foldlevel = 99
