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
  ensure_installed = {"css", "query"},
}
