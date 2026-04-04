local helpers = require("custom-helpers")

vim.loader.enable()

-- Disable unused built-in plugins
vim.g.loaded_gzip = 1
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_tarPlugin = 1
vim.g.loaded_2html_plugin = 1
vim.g.loaded_tutor_mode_plugin = 1
vim.g.loaded_zipPlugin = 1

-- Post-install/update hooks (must be before vim.pack.add)
vim.api.nvim_create_autocmd("PackChanged", {
  callback = function(ev)
    local name, kind = ev.data.spec.name, ev.data.kind
    if name == "nvim-treesitter" and (kind == "install" or kind == "update") then
      if not ev.data.active then
        vim.cmd.packadd("nvim-treesitter")
      end
      vim.cmd("TSUpdate")
    end
  end,
})

local plugins = {
  -- Editing
  "https://github.com/tpope/vim-repeat",
  "https://github.com/tpope/vim-unimpaired",
  "https://github.com/tpope/vim-characterize",
  "https://github.com/tpope/vim-speeddating",
  "https://github.com/tpope/vim-rsi",
  "https://github.com/tpope/vim-projectionist",
  "https://github.com/tpope/vim-eunuch",
  "https://github.com/kylechui/nvim-surround",
  "https://github.com/chaoren/vim-wordmotion",
  "https://github.com/echasnovski/mini.ai",
  "https://github.com/echasnovski/mini.splitjoin",
  "https://github.com/szw/vim-maximizer",
  "https://github.com/brenoprata10/nvim-highlight-colors",
  "https://github.com/pteroctopus/faster.nvim",
  "https://github.com/godlygeek/tabular",
  -- Testing
  "https://github.com/vim-test/vim-test",
  "https://github.com/preservim/vimux",
  -- LSP
  "https://github.com/neovim/nvim-lspconfig",
  "https://github.com/mason-org/mason.nvim",
  "https://github.com/williamboman/mason-lspconfig.nvim",
  "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim",
  "https://github.com/j-hui/fidget.nvim",
  "https://github.com/folke/lazydev.nvim",
  "https://github.com/nvim-lua/plenary.nvim",
  "https://github.com/pmizio/typescript-tools.nvim",
  "https://github.com/davidosomething/format-ts-errors.nvim",
  "https://github.com/b0o/schemastore.nvim",
  -- Treesitter
  "https://github.com/nvim-treesitter/nvim-treesitter",
  "https://github.com/nvim-treesitter/nvim-treesitter-textobjects",
  "https://github.com/windwp/nvim-ts-autotag",
  "https://github.com/RRethy/nvim-treesitter-endwise",
  "https://github.com/nvim-treesitter/nvim-treesitter-context",
  "https://github.com/folke/ts-comments.nvim",
  "https://github.com/andymass/vim-matchup",
  "https://github.com/ckolkey/ts-node-action",
  -- Completion & Snippets
  "https://github.com/hrsh7th/nvim-cmp",
  "https://github.com/L3MON4D3/LuaSnip",
  "https://github.com/saadparwaiz1/cmp_luasnip",
  "https://github.com/hrsh7th/cmp-nvim-lsp",
  "https://github.com/hrsh7th/cmp-buffer",
  "https://github.com/hrsh7th/cmp-path",
  "https://github.com/hrsh7th/cmp-cmdline",
  "https://github.com/chrisgrieser/nvim-scissors",
  -- Git
  "https://github.com/rhysd/conflict-marker.vim",
  "https://github.com/lewis6991/gitsigns.nvim",
  "https://github.com/sindrets/diffview.nvim",
  -- Fuzzy finding
  "https://github.com/ibhagwan/fzf-lua",
  "https://github.com/stevearc/conform.nvim",
  -- Quickfix
  "https://github.com/kevinhwang91/nvim-bqf",
  "https://github.com/stevearc/quicker.nvim",
}

if not helpers.isModuleAvailable("stripe") then
  vim.list_extend(plugins, {
    "https://github.com/tpope/vim-rails",
    "https://github.com/tpope/vim-rake",
    "https://github.com/tpope/vim-bundler",
  })
end

vim.pack.add(plugins)

vim.cmd.packadd("nvim.difftool")
