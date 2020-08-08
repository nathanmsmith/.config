# .config

Nathan's dotfiles.

## Setup

Currently, these dotfiles are only tested on macOS.

Clone this directory in your home folder, `~`. Run `install.sh`

```
git clone https://github.com/nathunsmitty/.config
cd .config
./install.sh
```

## fish

### Changing shell to fish

```
brew install fish
echo /usr/local/bin/fish >> /etc/shells
chsh -s /usr/local/bin/fish
```
