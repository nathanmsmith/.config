"  Nathan's vim configuration

"  Overarching Philosophy:
" 1. Prefer the defaults
" 2. Extend functionality where needed
" 3. Change functionality only when it doesn't make sense

" Put plugin managment first, as it handles installing packer.nvim for later files
lua require('plugins')

function! SourceIfExists(file)
  if filereadable(expand(a:file))
    exe 'source' a:file
  endif
endfunction

" Mostly vanilla Vim style tweaks
source $HOME/.config/nvim/config/appearance.vim
source $HOME/.config/nvim/config/navigation.vim
source $HOME/.config/nvim/config/editing.vim
source $HOME/.config/nvim/config/statusline.vim

" Custom commands
source $HOME/.config/nvim/config/custom-commands.vim

" Various feature extensions
set shell=/usr/bin/env\ bash
source $HOME/.config/nvim/config/linting.vim
source $HOME/.config/nvim/config/testing.vim
source $HOME/.config/nvim/config/searching.vim
source $HOME/.config/nvim/config/completion.vim

lua require('fuzzy_find')
source $HOME/.config/nvim/config/lsp.vim
call SourceIfExists('~/.config/nvim/config/stripe.vim')

" Beta features
lua require('treesitter')
