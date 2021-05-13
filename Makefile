all: install

install: plug-vim
	stow bin git nvim ruby tmux vim zsh

plug-vim:
	if test ! -f ~/.vim/autoload/plug.vim ; then \
		curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
				https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim ; \
	fi

rbenv: rbenv-base rbenv-build

rbenv-base:
	if test ! -d ~/.rbenv ; then \
		git clone https://github.com/rbenv/rbenv.git ~/.rbenv ; \
	fi

rbenv-build:
	if test ! -d ~/.rbenv/plugins/ruby-build ; then \
		git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build ; \
	fi

update: update-repo

update-repo:
	git pull --rebase
