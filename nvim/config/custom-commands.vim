scriptencoding utf-8

command! DumbQuotes %s/“\|”/"/g | %s/‘\|’/'/g
command! ReloadConfig source $MYVIMRC
" Not needed snice I'm not working with Java
" command! Intellij execute ":!idea %:p --line " . line('.')
command! VSCode execute ":!code -g %:p\:" . line('.') . ":" . col('.')
command! FileName !echo % | pbcopy
command! Finder !open "%:p:h"

" Edit a file in the same directory
cabbr <expr> %% expand('%:p:h')


function! SourceIfExists(file)
  if filereadable(expand(a:file))
    exe 'source' a:file
  endif
endfunction

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
" nnoremap <leader>x :call SaveAndExec()<CR>
call SourceIfExists('~/.config/nvim/config/stripe.vim')
