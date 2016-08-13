excludes = -I Makefile -I README.md
symlinks = $(shell ls $(excludes) `pwd`)

.PHONY: $(symlinks)

all: install

install: plug-vim $(symlinks)

plug-vim:
	if test ! -d ~/.vim/autoload/plug.vim ; then \
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
