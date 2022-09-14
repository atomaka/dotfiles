# dotfiles

Personal dotfiles managed via GNU stow.

## Installation

```bash
cd $HOME
git clone https://github.com/atomaka/dotfiles.git
cd dotfiles
./install.sh
```

## Notes

* Some homebrew packages (ie. vim) might be missing desired features

```
brew uninstall PACKAGE
brew edit PACKAGE # where there is no local directory named PACKAGE
# add compile options
brew install -s PACKAGE
```
