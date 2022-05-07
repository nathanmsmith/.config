" navigation.vim
" Settings to make navigating files, windows, tabs, etc. easier

" More sensible window splits
set splitbelow
set splitright

" Easier split navigation
" https://thoughtbot.com/blog/vim-splits-move-faster-and-more-naturally
" ref: http://vimcasts.org/episodes/working-with-windows/
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>


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
