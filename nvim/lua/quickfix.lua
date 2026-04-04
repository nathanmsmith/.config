-- nvim-bqf: setup when quickfix window opens
vim.api.nvim_create_autocmd("FileType", {
  pattern = "qf",
  callback = function()
    require("bqf").setup({ preview = { winblend = 0 } })
  end,
})

-- quicker.nvim
require("quicker").setup()
