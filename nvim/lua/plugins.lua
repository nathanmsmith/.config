-- Bootstrap Packer
local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path})
  execute 'packadd packer.nvim'
end

-- Run PackerCompile on save
-- vim.api.nvim_exec([[
--   augroup Packer
--     autocmd!
--     autocmd BufWritePost plugins.lua PackerCompile
--   augroup end
-- ]], false)

return require('packer').startup(function()
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- Color theme
  use 'nathunsmitty/night-owl.vim'

  -- Git
  use 'tpope/vim-fugitive'
  use 'tpope/vim-rhubarb'
  use 'airblade/vim-gitgutter'

  -- Editing nicities
  use 'tpope/vim-commentary'
  use 'tpope/vim-surround'
  use 'tpope/vim-repeat'
  use 'tpope/vim-unimpaired'
  use 'tpope/vim-characterize'
  use 'tpope/vim-speeddating'
  use 'tpope/vim-rsi'
  use 'tpope/vim-abolish'
  use 'tpope/vim-sleuth'
  use 'AndrewRadev/splitjoin.vim'

  -- Completion
  -- TODO: nvim-compe is cool and hip, but doesn't seem to work great with Ultisnips.
  -- I could be missing something...
  -- use 'hrsh7th/nvim-compe'
  use 'ervandew/supertab'

  -- Snippets
  use 'SirVer/ultisnips'

  -- Tim Pope Extensions
  use 'tpope/vim-eunuch'
  use 'tpope/vim-vinegar'

  -- Show Marks
  use 'kshenoy/vim-signature'

  -- Show Buffers
  use 'junegunn/vim-peekaboo'

  -- Search selection with *
  use 'nelstrom/vim-visual-star-search'

  -- Highlight colors
  use 'norcalli/nvim-colorizer.lua'

  -- Text object modifications and extensions
  use 'chaoren/vim-wordmotion'
  use 'wellle/targets.vim'
  use 'kana/vim-textobj-user'
  use 'kana/vim-textobj-entire'
  use 'whatyouhide/vim-textobj-xmlattr'

  -- Testing
  use 'vim-test/vim-test'

  -- File picking
  use {
    'nvim-telescope/telescope.nvim',
    requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}}
  }

  -- Linting
  use {
    'w0rp/ale',
    -- ft = {'sh', 'zsh', 'bash', 'c', 'cpp', 'cmake', 'html', 'markdown', 'racket', 'vim', 'tex'},
    -- cmd = 'ALEEnable',
    -- config = 'vim.cmd[[ALEEnable]]'
  }

  -- LSP Support
  lsp_filetypes = {'html', 'css', 'typescript', 'go', 'ruby'}
  use {
    'neovim/nvim-lspconfig',
    -- ft = lsp_filetypes,
    -- config = function() require("lsp") end,
  }
  use {
    'nathunsmitty/nvim-ale-diagnostic',
    -- ft = lsp_filetypes,
  }

  -- Treesitter
  -- ts_filetypes = {'html', 'css', 'typescript', 'ruby'}
  -- use {
  --   'nvim-treesitter/nvim-treesitter',
  --   run = ':TSUpdate',
  --   -- ft = ts_filetypes,
  --   -- config = function() require("treesitter") end,
  -- }
  -- use {
  --   'nvim-treesitter/nvim-treesitter-textobjects',
  --   -- ft = ts_filetypes,
  -- }
  -- use {
  --   'nvim-treesitter/playground',
  --   -- ft = ts_filetypes,
  -- }

  -- Ruby
  use 'tpope/vim-rails'
  use 'tpope/vim-endwise'
  use 'tpope/vim-rake'
  use 'tpope/vim-bundler'

  -- Go
  use { 'fatih/vim-go', run = ':GoUpdateBinaries' }

  -- Terraform
  use 'hashivim/vim-terraform'

  -- Fish
  use 'blankname/vim-fish'

end)
