require("luasnip").setup({
  -- history = true,
  -- update_events = "TextChanged,TextChangedI",
  -- enable_autosnippets = true,
})
require("luasnip.loaders.from_lua").load({ paths = "~/.config/nvim/snippets/" })

vim.keymap.set(
  { "i", "s" },
  "<c-a>",
  "luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<c-a>'",
  { silent = true, expr = true }
)
