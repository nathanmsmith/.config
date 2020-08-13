" statusline.vim
"

" Get syntax highlighting item
function! SyntaxItem()
  return synIDattr(synID(line("."),col("."),1),"name")
endfunction

" Statusline
function! LspStatus() abort
  if luaeval('#vim.lsp.buf_get_clients() > 0')
    return 'LSP'
  endif
  return ''
endfunction

function TreeSitter() abort
  return luaeval("require('nvim-treesitter').statusline(20) or ''")
endfunction

function! LinterStatus() abort
  let l:counts = ale#statusline#Count(bufnr(''))

  let l:all_errors = l:counts.error + l:counts.style_error
  let l:all_non_errors = l:counts.total - l:all_errors

  return l:counts.total == 0 ? 'OK' : printf(
        \   '%dW %dE',
        \   all_non_errors,
        \   all_errors
        \)
endfunction

set statusline=%{LinterStatus()}

set laststatus=2
set statusline=
set statusline+=%f
set statusline+=%m
set statusline+=\ %{FugitiveStatusline()}
set statusline+=\ %{LspStatus()}
set statusline+=\ %{gutentags#statusline()}
set statusline+=%=
set statusline+=%{TreeSitter()}
set statusline+=\ %{SyntaxItem()}
set statusline+=\ %y
