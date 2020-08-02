" statusline.vim

" Get syntax highlighting item
function! SyntaxItem()
  return synIDattr(synID(line("."),col("."),1),"name")
endfunction

set laststatus=2
set statusline=
set statusline+=%f
set statusline+=%m
set statusline+=\ %{FugitiveStatusline()}
set statusline+=%=
set statusline+=%{SyntaxItem()}
set statusline+=\ %y
