STOWED = zsh

all: install

install: 
	stow $(STOWED)

linux:
	sudo apt-get install fzf tmux vim

zsh:
	ln -s $(HOME)/.config/zsh/.zshenv $(HOME)/.zshenv
