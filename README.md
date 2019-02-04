# .config

These are my dotfiles. There are many like them, but these are mine.

## Setup

Clone this directory in your home folder, `~`. Run `install.sh`

```
git clone https://github.com/nathunsmitty/.config
cd .config
./install.sh
```

## fish

Plugin manager: fisher

### Changing shell to fish

```
brew install fish
echo /usr/local/bin/fish >> /etc/shells
chsh -s /usr/local/bin/fish
```

Also enable secure text entry, a line cursor, and blinking.

## Bootstrapping a new mac

### Applications I use

#### All Computers

- 1Password
- Alfred
- Backblaze
- Bartender 3
- Amphetamine
- Canary Mail
- [cd to](https://github.com/jbtule/cdto)
- Day One
- Firefox
- Chrome
- iStat Menus
- Kaleidoscope
- Scroll Reverser
- Slack
- The Unarchiver
- Things
- Tower
- Trello
- Visual Studio Code
- Xcode

#### Personal Computer

- Pixelmator
- Reeder
- Soulver
- Transmit
- XLD
- VLC
- Tweetbot
- Transmission
- Sketch

- Figma
- DaisyDisk

## Adobe DNG Converter

```
ln -s "/Applications/Adobe DNG Converter.app/Contents/MacOS/Adobe DNG Converter" dng-converter
```
