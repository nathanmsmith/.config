" navigation.vim
" Settings to make navigating files, windows, tabs, etc. easier

" Faster file switching with alternates
" Also integrates with vim-test
lua require("projectionist")

" Fuzzy Finding
" I've found it to be faster that the default fzf plugin.
" fzf is much better than selecta, fzy, etc. though
" ripgrep has the fastest search
nnoremap <silent> <leader>p :PickerEdit<CR>
let g:picker_custom_find_executable = 'rg'
let g:picker_custom_find_flags = '-g !.git/ --files --hidden --color never'
let g:picker_selector_executable = 'fzf'
let g:picker_selector_flags = '--layout=reverse'
let g:picker_height = 14

" Tree
packadd nvim-web-devicons
packadd nvim-tree.lua
map <leader>s :LuaTreeToggle<CR>
let g:lua_tree_follow = 1
let g:lua_tree_auto_close = 1
let g:lua_tree_ignore = ['.DS_Store', '.git', '.cache']
let g:lua_tree_git_hl = 1
let g:lua_tree_show_icons = {
    \ 'git': 1,
    \ 'folders': 1,
    \ 'files': 1,
    \}

" More sensible window splits
set splitbelow
set splitright

" Split help windows vertically, on the right
autocmd FileType help wincmd L

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
