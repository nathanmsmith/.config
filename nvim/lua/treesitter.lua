require("nvim-treesitter.configs").setup({
  highlight = {
    enable = true,
    custom_captures = {
      ["css.prop"] = "cssProp",
      ["css.tag"] = "cssTagName",
      ["css.constant"] = "Constant",
      ["css.class"] = "cssClassName",
    },
  },
  autotag = { enable = true },
  indent = {
    enable = true,
  },
  matchup = {
    enable = true, -- mandatory, false will disable the whole extension
  },
  context_commentstring = {
    enable = true,
  },
  playground = {
    enable = true,
    disable = {},
    updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
    persist_queries = false, -- Whether the query persists across vim sessions
  },
  textobjects = {
    move = {
      enable = true,
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
    select = {
      enable = true,
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
        ["ar"] = "@block.outer",
        ["ir"] = "@block.inner",
      },
    },
  },
  ensure_installed = {
    "query",
    "html",
    "css",
    -- "javascript",
    "typescript",
    "tsx",
    "go",
    "gomod",
    "c",
    "cpp",
    "java",
    "ruby",
    "python",
    "rust",
  },
})
