local helpers = require("custom-helpers")

-- Disable builtin plugins
vim.g.loaded_gzip = 1
vim.g.loaded_zip = 1
vim.g.loaded_zipPlugin = 1
vim.g.loaded_tar = 1
vim.g.loaded_tarPlugin = 1

vim.g.loaded_getscript = 1
vim.g.loaded_getscriptPlugin = 1
vim.g.loaded_vimball = 1
vim.g.loaded_vimballPlugin = 1
vim.g.loaded_2html_plugin = 1

vim.g.loaded_matchit = 1
vim.g.loaded_matchparen = 1
vim.g.loaded_logiPat = 1
vim.g.loaded_rrhelper = 1

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_netrwSettings = 1

-- Bootstrap Packer
local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
local is_bootstrap = false
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  is_bootstrap = true
  vim.fn.execute("!git clone https://github.com/wbthomason/packer.nvim " .. install_path)
  vim.cmd([[packadd packer.nvim]])
end

-- Run PackerCompile on save
local packer_group = vim.api.nvim_create_augroup("Packer", { clear = true })
vim.api.nvim_create_autocmd("BufWritePost", {
  command = "source <afile> | PackerCompile",
  group = packer_group,
  pattern = "plugins.lua",
})

require("packer").startup(function(use)
  -- Packer can manage itself
  use("wbthomason/packer.nvim")

  -- Faster loading
  use("lewis6991/impatient.nvim")

  -- Color theme
  use("nathanmsmith/night-owl.vim")

  -- LSP Configuration & Plugins
  use({
    "neovim/nvim-lspconfig",
    requires = {
      -- Automatically install LSPs to stdpath for neovim
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      -- Useful status updates for LSP
      "j-hui/fidget.nvim",
      -- Treat formatters as LSPs
      "jose-elias-alvarez/null-ls.nvim",
      -- Auto-format LSP changes on save
      "lukas-reineke/lsp-format.nvim",
    },
  })

  -- Treesitter
  use({
    "nvim-treesitter/nvim-treesitter",
    run = function()
      pcall(require("nvim-treesitter.install").update({ with_sync = true }))
    end,
  })
  use({ -- Additional text objects via treesitter
    "nvim-treesitter/nvim-treesitter-textobjects",
    after = "nvim-treesitter",
  })
  use("JoosepAlviste/nvim-ts-context-commentstring")
  use("windwp/nvim-ts-autotag")
  use("RRethy/nvim-treesitter-endwise")
  use("nvim-treesitter/playground")

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
  use({
    "lewis6991/gitsigns.nvim",
    requires = { "nvim-lua/plenary.nvim" },
  })

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
  use("AndrewRadev/switch.vim")

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
  use("hrsh7th/nvim-cmp")
  use("onsails/lspkind-nvim")
  use("saadparwaiz1/cmp_luasnip")

  -- Snippets
  use("L3MON4D3/LuaSnip")

  -- Autopair
  use({
    "windwp/nvim-autopairs",
    config = function()
      require("nvim-autopairs").setup({})
    end,
  })

  -- Tim Pope Extensions
  use("tpope/vim-eunuch")

  -- File navigation
  use({
    "tamago324/lir.nvim",
    config = function()
      local actions = require("lir.actions")
      vim.api.nvim_set_keymap("n", "-", [[<Cmd>execute 'e ' .. expand('%:p:h')<CR>]], { noremap = true })
      require("lir").setup({
        show_hidden_files = true,
        ignore = { ".DS_Store", "node_modules" },
        devicons_enable = false,
        hide_cursor = true,
        mappings = {
          ["<CR>"] = actions.edit,
          ["-"] = actions.up,

          ["<C-s>"] = actions.split,
          ["<C-v>"] = actions.vsplit,
          ["<C-t>"] = actions.tabedit,

          ["q"] = actions.quit,

          ["d"] = actions.mkdir,
          ["%"] = actions.newfile,
          ["R"] = actions.rename,
          ["Y"] = actions.yank_path,
          ["."] = actions.toggle_show_hidden,
          ["D"] = actions.delete,
        },
      })
    end,
  })
  use("stsewd/gx-extended.vim")

  -- Autohide search highlighting on move
  use("romainl/vim-cool")

  -- Show Marks
  use("kshenoy/vim-signature")

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
    requires = { { "nvim-lua/plenary.nvim" } },
  })
  use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })
  use({ "nvim-telescope/telescope-ui-select.nvim" })

  -- Formatting
  use("mhartington/formatter.nvim")

  -- Linting/Diagnostics
  use("mfussenegger/nvim-lint")
  use("folke/trouble.nvim")
  -- use {
  --   'nathanmsmith/nvim-ale-diagnostic',
  --   -- ft = lsp_filetypes,
  -- }

  -- Treesitter

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
  use({
    "fatih/vim-go",
    config = function()
      vim.g.go_gopls_enabled = false
    end,
  })

  use("dstein64/vim-startuptime")

  if helpers.isModuleAvailable("stripe") then
    require("stripe").loadPlugins(use)
  else
    use("tpope/vim-rails")
    use("tpope/vim-rake")
    use("tpope/vim-bundler")
  end

  -- Automatically set up your configuration after cloning packer.nvim
  if is_bootstrap then
    require("packer").sync()
  end
end)

if is_bootstrap then
  print("==================================")
  print("    Plugins are being installed")
  print("    Wait until Packer completes,")
  print("       then restart nvim")
  print("==================================")
  return true
end

return false
