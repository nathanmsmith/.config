-- Hook: run `make install_jsregexp` on install and update
vim.api.nvim_create_autocmd("PackChanged", {
  callback = function(ev)
    local name, kind = ev.data.spec.name, ev.data.kind
    if name == "LuaSnip" and (kind == "install" or kind == "update") then
      if not ev.data.active then
        vim.cmd.packadd("LuaSnip")
      end
      vim.fn.system({ "make", "install_jsregexp", "-C", vim.fn.stdpath("data") .. "/site/pack/core/opt/LuaSnip" })
    end
  end,
})

vim.pack.add({
  {
    src = "https://github.com/L3MON4D3/LuaSnip",
    version = vim.version.range("2.x"),
  },
  "https://github.com/hrsh7th/nvim-cmp",
  "https://github.com/saadparwaiz1/cmp_luasnip",
  "https://github.com/hrsh7th/cmp-nvim-lsp",
  "https://github.com/hrsh7th/cmp-buffer",
  "https://github.com/hrsh7th/cmp-path",
  "https://github.com/hrsh7th/cmp-cmdline",
  "https://github.com/chrisgrieser/nvim-scissors",
})

require("snippets")
require("completion")
