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
  use({
    "lewis6991/gitsigns.nvim",
    -- requires = { "nvim-lua/plenary.nvim" }
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
  -- use({
  --   "kyazdani42/nvim-tree.lua",
  --   config = function()
  --     require("nvim-tree").setup({
  --       disable_netrw = true,
  --       view = {
  --         mappings = {
  --           list = {
  --             { key = "<CR>", action = "edit_in_place" },
  --           },
  --         },
  --       },
  --       actions = {
  --         expand_all = {
  --           max_folder_discovery = 5,
  --         },
  --         change_dir = {
  --           enable = false,
  --         },
  --         open_file = {
  --           resize_window = false,
  --           window_picker = { enable = false },
  --         },
  --       },
  --       renderer = {
  --         add_trailing = true,
  --         icons = { show = { file = false, folder = false, folder_arrow = false } },
  --       },
  --     })
  --     vim.keymap.set("n", "-", require("nvim-tree").open_replacing_current_buffer, {})
  --   end,
  -- })
  use("stsewd/gx-extended.vim")

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
    requires = { { "nvim-lua/plenary.nvim" } },
  })
  use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })
  use({ "nvim-telescope/telescope-ui-select.nvim" })

  -- LSP Support
  -- lsp_filetypes = {'html', 'css', 'typescript', 'go', 'ruby'}
  use({
    "neovim/nvim-lspconfig",
    -- ft = lsp_filetypes,
    -- config = function() require("lsp") end,
  })
  use("williamboman/mason.nvim")
  use("williamboman/mason-lspconfig.nvim")

  use({ "nvim-lua/lsp-status.nvim" })
  -- Rust extras
  -- use({ "simrat39/rust-tools.nvim" })

  -- Formatting
  use("mhartington/formatter.nvim")
  use("lukas-reineke/lsp-format.nvim")
  use("jose-elias-alvarez/null-ls.nvim")

  -- Linting/Diagnostics
  use("mfussenegger/nvim-lint")
  use("folke/trouble.nvim")
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
  if packer_bootstrap then
    require("packer").sync()
  end
end)
