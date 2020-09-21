require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
    custom_captures = {
      ["css.prop"] = "cssProp",
      ["css.tag"] = "cssTagName",
      ["css.constant"] = "Constant",
      ["css.class"] = "cssClassName"
    },
  },
  playground = {
    enable = true,
    disable = {},
    updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
    persist_queries = false -- Whether the query persists across vim sessions
  },
  ensure_installed = {
    "query",
    "html",
    "css",
    -- "javascript",
    "typescript", "tsx",
    "lua",
    -- "python",
    -- "go",
    -- "c", "cpp"
  },
}
