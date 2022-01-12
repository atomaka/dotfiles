STOWED = alacritty bin git ruby tmux vim zsh

all: install

install:
	stow $(STOWED)

alacritty:
	curl -fLo /tmp/alacritty.info https://raw.githubusercontent.com/alacritty/alacritty/master/extra/alacritty.info
	sudo tic -xe alacritty,alacritty-direct /tmp/alacritty.info
	toggle-color-bin

javascript: nodenv-base nodenv-build

linux:
	sudo apt-get install direnv fzf silversearcher-ag stow tmux vim zsh

mac:
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	sudo mv /etc/{zprofile,zprofile.old}
	brew install coreutils direnv fzf git stow the_silver_searcher tmux vim zsh

ruby: rbenv-base rbenv-build

vim:
	curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

rbenv-base:
	if test ! -d ~/.rbenv ; then \
		git clone https://github.com/rbenv/rbenv.git ~/.rbenv ; \
	fi

rbenv-build:
	if test ! -d ~/.rbenv/plugins/ruby-build ; then \
		git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build ; \
	fi

nodenv-base:
	if test ! -d ~/.nodenv ; then \
		git clone https://github.com/nodenv/nodenv.git ~/.nodenv ; \
	fi

nodenv-build:
	if test ! -d ~/.nodenv/plugins/node-build ; then \
		git clone https://github.com/nodenv/node-build.git ~/.nodenv/plugins/node-build ; \
	fi
