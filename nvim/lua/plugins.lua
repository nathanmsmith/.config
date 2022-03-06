local helpers = require("custom-helpers")

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
  use("rhysd/conflict-marker.vim")

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
  use("tpope/vim-projectionist")
  use("AndrewRadev/splitjoin.vim")

  -- Suggestions
  use({
    "folke/which-key.nvim",
    config = function()
      require("which-key").setup({
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      })
    end,
  })

  -- Completion
  use("hrsh7th/cmp-nvim-lsp")
  use("hrsh7th/cmp-buffer")
  use("hrsh7th/cmp-path")
  use("hrsh7th/cmp-nvim-lua")
  use("hrsh7th/cmp-cmdline")
  use("saadparwaiz1/cmp_luasnip")
  use("hrsh7th/nvim-cmp")
  use("onsails/lspkind-nvim")

  -- Snippets
  use("L3MON4D3/LuaSnip")

  -- Tim Pope Extensions
  use("tpope/vim-eunuch")
  use("tpope/vim-vinegar")

  -- Autohide search highlighting on move
  use("romainl/vim-cool")

  -- Show Marks
  use("kshenoy/vim-signature")

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
  use({
    "nvim-telescope/telescope-frecency.nvim",
    requires = { "tami5/sqlite.lua" },
  })

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
    config = function()
      require("treesitter")
    end,
  })
  use({
    "nvim-treesitter/nvim-treesitter-textobjects",
  })
  use("JoosepAlviste/nvim-ts-context-commentstring")
  use("windwp/nvim-ts-autotag")
  use("windwp/nvim-autopairs")
  use("RRethy/nvim-treesitter-endwise")

  use({
    "nvim-treesitter/playground",
  })

  -- Maximize current split
  use("szw/vim-maximizer")

  -- Better use of %
  use("andymass/vim-matchup")

  -- Ruby
  use("vim-ruby/vim-ruby")

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
  else
    use("tpope/vim-rails")
    use("tpope/vim-rake")
    use("tpope/vim-bundler")
  end

  -- Automatically set up your configuration after cloning packer.nvim
  if packer_bootstrap then
    require("packer").sync()
  end
end)
