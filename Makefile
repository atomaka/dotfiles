STOWED = alacritty bin git ruby tmux vim zsh
UNAME = `uname`

all:
	-@make $(UNAME) install vim alacritty rust

install:
	stow $(STOWED)


Linux: linux_applications

Darwin: mac_applications
	/bin/bash -c "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	sudo mv /etc/{zprofile,zprofile.old}
	source ./zsh/.zshenv


alacritty:
	curl -fLo /tmp/alacritty.info https://raw.githubusercontent.com/alacritty/alacritty/master/extra/alacritty.info
	sudo tic -xe alacritty,alacritty-direct /tmp/alacritty.info
	toggle-color-bin

rust:
	curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- --no-modify-path

vim:
	curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim


mac_applications:
	brew install coreutils gnu-sed direnv fzf git stow the_silver_searcher tmux \
		vim zsh rbenv ruby-build tfenv nodenv node-build tig libpq gnupg llvm \
		awscli cmake session-manager-plugin jq
	brew install --cask docker rectangle slack google-chrome alacritty telegram \
		discord

linux_applications:
	sudo apt-get install direnv fzf silversearcher-ag stow tmux vim zsh
	if test ! -d ~/.rbenv ; then \
		git clone https://github.com/rbenv/rbenv.git ~/.rbenv ; \
	fi
	if test ! -d ~/.rbenv/plugins/ruby-build ; then \
		git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build ; \
	fi
	if test ! -d ~/.nodenv ; then \
		git clone https://github.com/nodenv/nodenv.git ~/.nodenv ; \
	fi
	if test ! -d ~/.nodenv/plugins/node-build ; then \
		git clone https://github.com/nodenv/node-build.git ~/.nodenv/plugins/node-build ; \
	fi
	if test ! -d ~/.tfenv ; then \
		git clone https://github.com/tfutils/tfenv.git ~/.tfenv ; \
	fi
