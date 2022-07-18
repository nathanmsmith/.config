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
local packer_group = vim.api.nvim_create_augroup("Packer", { clear = true })
vim.api.nvim_create_autocmd("BufWritePost", {
  command = "source <afile> | PackerCompile",
  group = packer_group,
  pattern = "plugins.lua",
})

return require("packer").startup(function(use)
  -- Packer can manage itself
  use("wbthomason/packer.nvim")

  -- Faster loading
  use("lewis6991/impatient.nvim")

  -- Color theme
  use("nathanmsmith/night-owl.vim")

  -- Git
  use("tpope/vim-fugitive")
  use("tpope/vim-rhubarb")
  use({
    "rhysd/conflict-marker.vim",
    config = function()
      -- Unimpaired does this [n and ]n (and d[n, d]n)
      vim.g.conflict_marker_enable_mappings = false
      -- disable the default highlight group
      vim.g.conflict_marker_highlight_group = ""
      -- Include text after begin and end markers
      vim.g.conflict_marker_begin = "^<<<<<<< .*$"
      vim.g.conflict_marker_end = "^>>>>>>> .*$"
    end,
  })
  use({ "lewis6991/gitsigns.nvim", requires = { "nvim-lua/plenary.nvim" } })

  -- Editing nicities
  use("tpope/vim-commentary")
  use("tpope/vim-surround")
  use("tpope/vim-repeat")
  use({
    "tpope/vim-unimpaired",
    config = function()
      -- Let's call it PascalCase, not MixedCase
      vim.keymap.set("n", "crp", "crm", { remap = true })
      -- Also kebabcase
      vim.keymap.set("n", "cr-", "crk", { remap = true })
    end,
  })
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
  use("hrsh7th/cmp-cmdline")
  use("quangnguyen30192/cmp-nvim-ultisnips")
  use("hrsh7th/nvim-cmp")
  use("onsails/lspkind-nvim")
  -- use("ervandew/supertab")

  -- Snippets
  use({
    "SirVer/ultisnips",
    config = function()
      vim.g.python3_host_prog = "python3"
      vim.g.UltiSnipsEditSplit = "vertical"
      vim.g.UltiSnipsUsePythonVersion = 3

      -- if helpers.isModuleAvailable("stripe") then
      vim.g.UltiSnipsSnippetDirectories = { "$HOME/.config/nvim/UltiSnips", "Ultisnips", "$HOME/stripe/stripe-config/nvim/UltiSnips" }
      -- else
      --   vim.g.UltiSnipsSnippetDirectories = { "$HOME/.config/nvim/UltiSnips", "Ultisnips"}
      -- end
    end,
  })

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
  use({
    "chaoren/vim-wordmotion",
    config = function()
      vim.g.wordmotion_spaces = { "w@<=-w@=", "w@<=_w@=", ".", ":" }
    end,
  })
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
  use({ "nvim-lua/lsp-status.nvim" })
  -- Rust extras
  -- use({ "simrat39/rust-tools.nvim" })

  -- Formatting
  use("mhartington/formatter.nvim")

  -- Linting/Diagnostics
  use("mfussenegger/nvim-lint")
  use({ "folke/trouble.nvim" })
  use({ "lukas-reineke/lsp-format.nvim" })
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
  use("RRethy/nvim-treesitter-endwise")

  use({
    "nvim-treesitter/playground",
  })

  -- Maximize current split
  use("szw/vim-maximizer")

  -- Better use of %
  use({
    "andymass/vim-matchup",
    config = function()
      vim.g.matchup_surround_enabled = true
      vim.g.matchup_matchparen_offscreen = {}
    end,
  })

  -- Languages
  use("vim-ruby/vim-ruby")
  use("hashivim/vim-terraform")
  use("blankname/vim-fish")
  use("mustache/vim-mustache-handlebars")
  use("cespare/vim-toml")

  use("dstein64/vim-startuptime")

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
