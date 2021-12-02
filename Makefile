STOWED = alacritty tmux vim zsh

all: install

install: 
	stow $(STOWED)

linux:
	sudo apt-get install fzf tmux vim

alacritty:
	curl -fLo /tmp/alacritty.info https://raw.githubusercontent.com/alacritty/alacritty/master/extra/alacritty.info
	sudo tic -xe alacritty,alacritty-direct /tmp/alacritty.info

vim:
	curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
