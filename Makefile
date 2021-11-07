STOWED = bin git ruby tmux vim zsh alacritty atomaka

all: install

install: vim-setup initialize-colors
	stow $(STOWED)

uninstall:
	stow -D $(STOWED)

vim-setup:
	mkdir -p $$HOME/.vim/undo
	if test ! -f ~/.vim/autoload/plug.vim ; then \
		curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
				https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim ; \
	fi

initialize-colors:
	cat alacritty/.config/alacritty/alacritty-base.yml alacritty/.config/alacritty/themes/dark.yml > alacritty/.config/alacritty/alacritty.yml
	cp atomaka/.config/atomaka/color.sample.yml atomaka/.config/atomaka/color.yml

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

clean:
	rm -f $$HOME/bin/,
	bash remove-symlinks

mac:
	sudo mv /etc/{zprofile,zprofile.old}
	infocmp -x tmux-256color > ~/tmux-256color.src
	sed -i "" -e "s/pairs#0x10000/pairs#0x1000/" ~/tmux-256color.src
	/usr/bin/tic -x ~/tmux-256color.src
