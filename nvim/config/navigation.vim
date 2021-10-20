" navigation.vim
" Settings to make navigating files, windows, tabs, etc. easier

" Faster file switching with alternates
" Also integrates with vim-test
lua require("projectionist")

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

" Sneak remappings for single character
map f <Plug>Sneak_f
map F <Plug>Sneak_F
map t <Plug>Sneak_t
map T <Plug>Sneak_T
