return require('packer').startup(function()

  -- Colors

  -- Git
  -- call packager#add('tpope/vim-fugitive')
  -- call packager#add('tpope/vim-rhubarb')
  -- call packager#add('airblade/vim-gitgutter')
  -- call packager#add('rhysd/conflict-marker.vim')

  -- Editing nicities
  use { 'tpope/vim-commentary' }
  use { 'tpope/vim-surround' }
  use { 'tpope/vim-repeat' }
  use { 'tpope/vim-unimpaired' }
  -- call packager#add('tpope/vim-characterize')
  -- call packager#add('tpope/vim-speeddating')
  -- call packager#add('tpope/vim-rsi')
  -- call packager#add('tpope/vim-abolish')

  -- Marks
  -- call packager#add('kshenoy/vim-signature')

  -- Linting
  use {
    'w0rp/ale',
    -- ft = {'sh', 'zsh', 'bash', 'c', 'cpp', 'cmake', 'html', 'markdown', 'racket', 'vim', 'tex'},
    -- cmd = 'ALEEnable',
    -- config = 'vim.cmd[[ALEEnable]]'
  }

  -- LSP Support

  -- Treesitter
  -- use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }

  -- Syntax files

end)
