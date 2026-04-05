vim.pack.add({
  "https://github.com/kevinhwang91/nvim-bqf",
  "https://github.com/stevearc/quicker.nvim",
})

-- nvim-bqf: setup when quickfix window opens
vim.api.nvim_create_autocmd("FileType", {
  pattern = "qf",
  callback = function()
    require("bqf").setup({ preview = { winblend = 0 } })
  end,
})

-- quicker.nvim
require("quicker").setup()
