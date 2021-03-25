excludes = -I Makefile -I README.md
symlinks = $(shell find . \( ! -iname "Makefile" ! -iname "README.md" ! -iname ".*" ! -path "./.git/*" ! -path "./zsh/*" ! -path "./nvim/*" ! -path "./bin/*" ! -iname "nvim" \) | sed 's|./||')

.PHONY: $(symlinks) nvim

all: install

install: install-bin plug-vim $(symlinks)

install-bin:
	cp bin/* $$HOME/bin

nvim:
	mkdir -p ~/.config/nvim
	cp nvim/init.vim ~/.config/nvim/

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

$(symlinks):
	test -e `pwd`/$@ \
		&& ln -sfn `pwd`/$@ ~/.$@

update: update-repo $(symlinks)

update-repo:
	git pull --rebase
	git submodule update

clean:
	for file in $(symlinks); do rm ~/.$$file; done
