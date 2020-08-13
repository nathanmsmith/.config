" statusline.vim
"

" Get syntax highlighting item
function! SyntaxItem()
  return synIDattr(synID(line("."),col("."),1),"name")
endfunction

" Statusline
function! LspStatus() abort
  if luaeval('#vim.lsp.buf_get_clients() > 0')
    return luaeval("require('lsp-status').status()")
  endif
  return ''
endfunction

function TreeSitter() abort
  return luaeval("require('nvim-treesitter').statusline(20)")
endfunction

set laststatus=2
set statusline=
set statusline+=%f
set statusline+=%m
set statusline+=\ %{FugitiveStatusline()}
set statusline+=\ %{LspStatus()}
set statusline+=\ %{gutentags#statusline()}
set statusline+=\ %{TreeSitter()}
set statusline+=%=
set statusline+=%{SyntaxItem()}
set statusline+=\ %y
