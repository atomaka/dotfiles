# dotfiles

Personal dotfiles managed via GNU stow.

## Installation

```bash
cd $HOME
git clone https://git.atomaka.com/atomaka/dotfiles.git
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

* Minor Ruby conflicts with brew/OpenSSL version/Ruby. This has worked, but also
  caused problems

```
export PATH="/home/linuxbrew/.linuxbrew/opt/openssl@3/bin:$PATH"
export LDFLAGS="-L/home/linuxbrew/.linuxbrew/opt/openssl@3/lib"
export CPPFLAGS="-I/home/linuxbrew/.linuxbrew/opt/openssl@3/include"
export PKG_CONFIG_PATH="/home/linuxbrew/.linuxbrew/opt/openssl@3/lib/pkgconfig"
```
