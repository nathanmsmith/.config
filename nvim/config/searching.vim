" Search and Fuzzy Finding

" grep with ripgrep
" https://github.com/BurntSushi/ripgrep
if executable('rg')
  set grepprg=rg\ --vimgrep\ --no-heading\ --smart-case
  set grepformat=%f:%l:%c:%m
endif

" I've found vim-picker to be faster that the default fzf plugin.
" Their defaults of git ls-files, fd, then find seem to be the optimal find
" speed ordering
" TODO: use git ls-files in git repositories
let g:picker_custom_find_executable = 'fd'
let g:picker_custom_find_flags = '--hidden --color never --exclude .git --type f'

" fzf is much better than selecta, fzy, etc. though
" Note the custom options for proximity sorting
" From https://balatero.com/writings/vim/fzf-ripgrep-proximity-sort/
let g:picker_selector_executable = 'fzf'
let g:picker_selector_flags = '--layout=reverse --tiebreak=index'
let g:picker_height = 14

function! g:FzfFilesSource()
  let l:base = fnamemodify(expand('%'), ':h:.:S')
  let l:proximity_sort_path = $HOME . '/.cargo/bin/proximity-sort'

   if base ==# '.'
    return printf('%s %s', g:picker_custom_find_executable, g:picker_custom_find_flags)
  else
    return printf('%s %s | %s %s', g:picker_custom_find_executable, g:picker_custom_find_flags, l:proximity_sort_path, expand('%'))
  endif
endfunction

" `p` for picker
nnoremap <silent> <leader>p :call picker#File(g:FzfFilesSource(), 'edit')<CR>
" `b` for buffer
nmap <silent> <leader>] <Plug>(PickerBuffer)
" `]` for tag
nmap <silent> <leader>] <Plug>(PickerTag)
" `o` for buffer tag
nmap <silent> <leader>o <Plug>(PickerBufferTag)
" `h` for help
nmap <silent> <leader>h <Plug>(PickerHelp)
