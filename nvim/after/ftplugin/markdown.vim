setlocal textwidth=80
setlocal spell
setlocal wrap
setlocal linebreak
setlocal nolist
setlocal textwidth=80
setlocal tabstop=2
setlocal shiftwidth=2

" Cargo-culted from jez
" https://github.com/jez/dotfiles/blob/41afe3b929f6d62e8844da81693c6b31a5a627ad/vim/ft-settings.vim#L62
setlocal formatlistpat=\\C^\\s*[\\[({]\\\?\\([0-9]\\+\\\|[iIvVxXlLcCdDmM]\\+\\\|[a-zA-Z]\\)[\\]:.)}]\\s\\+\\\|^\\s*[-+o*>]\\s\\+
setlocal formatoptions+=n
setlocal breakindent
setlocal breakindentopt+=list:-1
