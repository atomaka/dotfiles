excludes = -I Makefile -I README.md
symlinks = $(shell ls $(excludes) `pwd`)

.PHONY: $(symlinks)

all: install

install: repos $(symlinks)

repos:
	if test ! -d ~/.vim/bundle/vundle ; then \
		git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/vundle ; \
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
