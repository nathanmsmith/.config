command! DumbQuotes %s/“\|”/"/g | %s/‘\|’/'/g
command! ReloadConfig source $MYVIMRC
command! Intellij execute ":!idea %:p --line " . line('.')
command! VSCode execute ":!code -g %:p\:" . line('.') . ":" . col('.')
command! FileName !echo % | pbcopy
