local helpers = require('custom-helpers')

-- Bootstrap Packer
local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  packer_bootstrap = vim.fn.system({
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  })
end

-- Run PackerCompile on save
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])

return require("packer").startup(function(use)
  -- Packer can manage itself
  use("wbthomason/packer.nvim")

  -- Color theme
  use("nathanmsmith/night-owl.vim")

  -- Git
  use("tpope/vim-fugitive")
  use("tpope/vim-rhubarb")
  use("airblade/vim-gitgutter")

  -- Editing nicities
  use("tpope/vim-commentary")
  use("tpope/vim-surround")
  use("tpope/vim-repeat")
  use("tpope/vim-unimpaired")
  use("tpope/vim-characterize")
  use("tpope/vim-speeddating")
  use("tpope/vim-rsi")
  use("tpope/vim-abolish")
  use("tpope/vim-sleuth")
  use("AndrewRadev/splitjoin.vim")

  -- Completion
  -- TODO: nvim-compe is cool and hip, but doesn't seem to work great with Ultisnips.
  -- I could be missing something...
  -- use 'hrsh7th/nvim-compe'
  use("ervandew/supertab")

  -- Snippets
  use("SirVer/ultisnips")

  -- Tim Pope Extensions
  use("tpope/vim-eunuch")
  use("tpope/vim-vinegar")

  -- Show Marks
  use("kshenoy/vim-signature")

  -- Show Buffers
  use("junegunn/vim-peekaboo")

  -- Search selection with *
  use("nelstrom/vim-visual-star-search")

  -- Highlight colors
  use("norcalli/nvim-colorizer.lua")

  -- Text object modifications and extensions
  use("chaoren/vim-wordmotion")
  use("wellle/targets.vim")
  use("kana/vim-textobj-user")
  use("kana/vim-textobj-entire")
  use("whatyouhide/vim-textobj-xmlattr")

  -- Testing
  use("vim-test/vim-test")

  -- File picking
  use({
    "nvim-telescope/telescope.nvim",
    requires = { { "nvim-lua/popup.nvim" }, { "nvim-lua/plenary.nvim" } },
  })
  use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })

  -- LSP Support
  -- lsp_filetypes = {'html', 'css', 'typescript', 'go', 'ruby'}
  use({
    "neovim/nvim-lspconfig",
    -- ft = lsp_filetypes,
    -- config = function() require("lsp") end,
  })
  use({ "williamboman/nvim-lsp-installer" })
  -- Rust extras
  -- use({ "simrat39/rust-tools.nvim" })

  -- Linting/Diagnostics
  use({ "jose-elias-alvarez/null-ls.nvim", requires = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" } })
  use({ "folke/trouble.nvim" })
  -- use {
  --   'nathanmsmith/nvim-ale-diagnostic',
  --   -- ft = lsp_filetypes,
  -- }

  -- Treesitter
  use({
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
    -- ft = ts_filetypes,
    config = function()
      require("treesitter")
    end,
    branch = "0.5-compat",
  })
  use({
    "nvim-treesitter/nvim-treesitter-textobjects",
    branch = "0.5-compat",
    -- ft = ts_filetypes,
  })
  -- use {
  --   'nvim-treesitter/playground',
  --   -- ft = ts_filetypes,
  -- }

  -- Ruby
  use("vim-ruby/vim-ruby")
  use("tpope/vim-rails")
  use("tpope/vim-endwise")
  use("tpope/vim-rake")
  use("tpope/vim-bundler")

  -- Terraform
  use("hashivim/vim-terraform")

  -- Fish
  use("blankname/vim-fish")

  -- Handlebars
  use("mustache/vim-mustache-handlebars")
  -- TOML
  use("cespare/vim-toml")

  if helpers.isModuleAvailable("stripe") then
    require("stripe").loadPlugins(use)
  end

  -- Automatically set up your configuration after cloning packer.nvim
  if packer_bootstrap then
    require("packer").sync()
  end
end)
