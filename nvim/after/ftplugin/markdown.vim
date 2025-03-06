setlocal textwidth=80
setlocal spell
setlocal wrap
setlocal linebreak
setlocal nolist

" Cargo-culted from jez
" https://github.com/jez/dotfiles/blob/41afe3b929f6d62e8844da81693c6b31a5a627ad/vim/ft-settings.vim#L62
setlocal formatlistpat=\\C^\\s*[\\[({]\\\?\\([0-9]\\+\\\|[iIvVxXlLcCdDmM]\\+\\\|[a-zA-Z]\\)[\\]:.)}]\\s\\+\\\|^\\s*[-+o*>]\\s\\+
setlocal breakindent
setlocal breakindentopt+=list:-1
