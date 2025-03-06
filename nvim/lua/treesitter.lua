require("nvim-treesitter.configs").setup({
  highlight = { enable = true },
  indent = {
    enable = true,
    disable = {
      -- Indentation at bullet points is worse, according to
      -- https://www.reddit.com/r/neovim/comments/1agynre/how_to_make_markdown_list_items_indent_behind_the/
      "markdown",
    },
  },
  -- Plugin config
  -- autotag = { enable = true },
  endwise = { enable = true },
  matchup = {
    enable = true,
    disable_virtual_text = true,
    include_match_words = false,
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
  ignore_install = {
    "git_config",
    "git_rebase",
    "gitattributes",
    "gitcommit",
    "gitignore",
  },
  ensure_installed = {
    "bash",
    "c",
    "html",
    "javascript",
    "json",
    "lua",
    "luadoc",
    "luap",
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
