" navigation.vim
" Settings to make navigating files, windows, tabs, etc. easier


let g:maximizer_set_default_mapping = 0
" maximize current split or return to previous
nnoremap <C-W>m :MaximizerToggle<CR>

" Buffers
" ref: http://vimcasts.org/episodes/working-with-buffers/
" Enables to switch between unsaved buffers and keep undo history
set hidden

" Mouse support
" Useful for things like resizing windows
if has('mouse')
  set mouse=a
end

" Add current directory to path (for `gf`)
set path+=.,,

" hide files in netrw
let g:netrw_list_hide = '.*\.swp$,.DS_Store,*/tmp/*,*.so,*.swp,*.zip,*.git,^\.\.\=/\=$'
