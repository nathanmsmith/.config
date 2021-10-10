"  Nathan's vim configuration

"  Overarching Philosophy:
" 1. Prefer the defaults
" 2. Extend functionality where needed
" 3. Change functionality only when it doesn't make sense

" Put plugin managment first, as it handles installing packer.nvim for later files
lua require('plugins')

" Mostly vanilla Vim style tweaks
source $HOME/.config/nvim/config/appearance.vim
source $HOME/.config/nvim/config/navigation.vim
source $HOME/.config/nvim/config/editing.vim
source $HOME/.config/nvim/config/statusline.vim

" Custom commands
source $HOME/.config/nvim/config/custom-commands.vim

" Various feature extensions
source $HOME/.config/nvim/config/linting.vim
source $HOME/.config/nvim/config/testing.vim
source $HOME/.config/nvim/config/searching.vim
source $HOME/.config/nvim/config/completion.vim

lua require('fuzzy_find')
source $HOME/.config/nvim/config/lsp.vim

" Beta features
lua require('treesitter')
