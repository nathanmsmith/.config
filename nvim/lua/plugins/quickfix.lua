return {
  { "kevinhwang91/nvim-bqf", ft = "qf", opts = { preview = { winblend = 0 } } },
  {
    "stevearc/quicker.nvim",
    event = "FileType qf",
    ---@module "quicker"
    ---@type quicker.SetupOptions
    opts = {},
  },
}
