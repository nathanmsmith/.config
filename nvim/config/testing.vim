" Testing with vim-test
let g:test#javascript#jest#file_pattern = '\v(__tests__/.*|(spec|test|unit))\.(js|jsx|coffee|ts|tsx|iced)$'
let g:test#javascript#jest#executable = 'yarn test'

let g:iterm_command = '/opt/homebrew/bin/python3 ~/.config/iTerm/Scripts/run-test.py'
let g:kitty_command = '~/.config/nvim/test/kitty_runner'

function! TermStrategy(cmd)
  let cmd = join([g:iterm_command, shellescape(a:cmd)])
  execute 'silent !'.cmd
endfunction

function! KittyStrategy(cmd) abort
  let cmd = join([g:kitty_command, shellescape(getcwd()), shellescape(a:cmd)])
  echo cmd
  execute 'silent !'.cmd
endfunction

let g:test#custom_strategies = {
      \  'iterm3': function('TermStrategy'),
      \ 'kitty_new_tab': function('KittyStrategy')
      \ }

" if executable('kitty')
"   let g:test#strategy = 'kitty_new_tab'
" else
let g:test#strategy = 'iterm3'
" endif

nnoremap <silent> <leader>t :TestNearest<CR>
nnoremap <silent> <leader>T :TestFile<CR>
nnoremap <silent> <leader>a :TestSuite<CR>
nnoremap <silent> <leader>l :TestLast<CR>
nnoremap <silent> <leader>g :TestVisit<CR>
