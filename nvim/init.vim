"  Nathan Smith's vim configuration

"  Overarching Philosophy:
" 1. Prefer the defaults
" 2. Extend functionality where needed
" 3. Change functionality only when it doesn't make sense

" Put plugin managment first, as it handles install minpac for later files
source $HOME/.config/nvim/config/plugin-management.vim
source $HOME/.config/nvim/config/appearance.vim
source $HOME/.config/nvim/config/custom-commands.vim
source $HOME/.config/nvim/config/editing.vim
source $HOME/.config/nvim/config/integrations.vim
source $HOME/.config/nvim/config/languages.vim
source $HOME/.config/nvim/config/navigation.vim
source $HOME/.config/nvim/config/completion.vim
source $HOME/.config/nvim/config/lsp.vim
" source $HOME/.config/nvim/config/treesitter.vim
source $HOME/.config/nvim/config/statusline.vim
source $HOME/.config/nvim/config/autocommands.vim
