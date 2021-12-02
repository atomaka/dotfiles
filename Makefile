STOWED = alacritty tmux zsh

all: install

install: 
	stow $(STOWED)

linux:
	sudo apt-get install fzf tmux vim

alacritty:
	curl -fLo /tmp/alacritty.info https://raw.githubusercontent.com/alacritty/alacritty/master/extra/alacritty.info
	sudo tic -xe alacritty,alacritty-direct /tmp/alacritty.info

zsh:
	ln -s $(HOME)/.config/zsh/.zshenv $(HOME)/.zshenv
