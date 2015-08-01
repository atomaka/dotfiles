excludes = -I Makefile -I README.md
symlinks = $(shell ls $(excludes) `pwd`)

.PHONY: $(symlinks)

all: install

install: submodules $(symlinks)

submodules:
	git submodule update --init --recursive

$(symlinks):
	test -e `pwd`/$@ \
		&& ln -sfn `pwd`/$@ ~/.$@

update: update-repo $(symlinks)

update-repo:
	git pull --rebase
	git submodule update

clean:
	for file in $(symlinks); do rm ~/.$$file; done
