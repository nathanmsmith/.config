" Plugins
" Package manager: Minpac, https://github.com/k-takata/minpac
" ref: Modern Vim, tip 6
try
  packadd minpac
  " Easy to use commands
  command! PacInstall source $MYVIMRC | call minpac#update('', {'do': 'call minpac#status()'})
  command! PacClean source $MYVIMRC | call minpac#clean()
  command! PacStatus source $MYVIMRC | call minpac#status()
catch
  fun! InstallPlug() " Bootstrap plugin manager on new systems. Copied from https://github.com/justinmk/config/blob/master/.config/nvim/init.vim#L19
    exe '!git clone https://github.com/k-takata/minpac.git ' stdpath('config').'/pack/minpac/opt/minpac'
    " call minpac#update()
  endfun
endtry

if exists('*minpac#init')
  call minpac#init()
  call minpac#add('k-takata/minpac', {'type': 'opt'})
end
