" https://vi.stackexchange.com/questions/4488/how-do-i-define-an-autocommand-to-work-on-all-files-excepted-a-certain-filetype
let ftToIgnore = ['markdown', 'text']

augroup completion
  autocmd!
  " Enable completion for most buffers
  autocmd BufWritePre * if index(ftToIgnore, &ft) < 0 | lua require'completion'.on_attach()
augroup END

augroup windows
  " Resize windows on move
  autocmd VimResized * :wincmd =
  " Split help windows vertically, on the right
  autocmd FileType help wincmd L
augroup END

augroup external
  " Open images in an image viewer (probably Preview)
  autocmd BufEnter *.png,*.jpg,*.gif exec "silent !open ".expand("%") | :bw
augroup END

augroup editing
  " Highlight yanks
  au TextYankPost * silent! lua vim.highlight.on_yank {timeout=1000}
augroup END

" Reset the cursor on exit
" See https://github.com/neovim/neovim/issues/4867#issuecomment-291249173
" and https://github.com/neovim/neovim/wiki/FAQ#cursor-style-isnt-restored-after-exiting-nvim
" set guicursor=a:blinkon100
augroup cursor
  autocmd!
  au VimLeave,VimSuspend * set guicursor=a:ver25-blinkon1
augroup END
