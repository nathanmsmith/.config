" Search and Fuzzy Finding

" grep with ripgrep
" https://github.com/BurntSushi/ripgrep
if executable('rg')
  set grepprg=rg\ --vimgrep\ --no-heading\ --smart-case
  set grepformat=%f:%l:%c:%m
endif
