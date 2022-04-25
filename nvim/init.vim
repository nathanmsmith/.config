"  Nathan's vim configuration

"  Overarching Philosophy:
" 1. Prefer the defaults
" 2. Extend functionality where needed
" 3. Change functionality only when it doesn't make sense

lua require('impatient')

let g:loaded_matchit = 1

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

let g:netrw_localrmdir='rm -r'

" Custom commands
source $HOME/.config/nvim/config/custom-commands.vim

" Various feature extensions
set shell=/usr/bin/env\ bash
source $HOME/.config/nvim/config/testing.vim
source $HOME/.config/nvim/config/searching.vim
source $HOME/.config/nvim/config/completion.vim

lua require('globals')

if !exists('*SaveAndExec')
  function! SaveAndExec() abort
    if &filetype == 'vim'
      :silent! write
      :source %
    elseif &filetype == 'lua'
      :silent! write
      :luafile %
    endif
    return
  endfunction
end
" Execute this file
nnoremap <leader>x :call SaveAndExec()<CR>

lua require('fuzzy_find')
source $HOME/.config/nvim/config/lsp.vim
call SourceIfExists('~/.config/nvim/config/stripe.vim')

lua require('diagnostic')
lua require('formatting')
lua require('treesitter')
lua require('git')

augroup TrimTrailingWhiteSpace
  au!
  au BufWritePre * %s/\s\+$//e
  au BufWritePre * %s/\n\+\%$//e
augroup END
