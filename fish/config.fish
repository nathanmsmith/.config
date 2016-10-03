set fish_greeting ""

# Paths to your tackle
set tacklebox_path ~/.config/fish

# Theme
set tacklebox_theme stochasticity

# Which modules would you like to load? (modules can be found in ~/.tackle/modules/*)
# Custom modules may be added to ~/.tacklebox/modules/
# Example format: set tacklebox_modules virtualfish virtualhooks

set tacklebox_modules virtualfish virtualhooks

# Which plugins would you like to enable? (plugins can be found in ~/.tackle/plugins/*)
# Custom plugins may be added to ~/.tacklebox/plugins/
# Example format: set tacklebox_plugins python extract

set tacklebox_plugins python extract pip up sdl

# Load Tacklebox configuration
. ~/.config/fish/tacklebox.fish

# Load Aliases
. ~/.config/fish/aliases.fish
