PATH="$HOME/bin:$PATH"

if [[ "$OSTYPE" == darwin* ]]; then
  PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
  MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"
  NVM_DIR="/usr/local/opt/nvm"
else
  NVM_DIR="/home/atomaka/.nvm"
fi

# add path to newer bins on cse servers (github/rmblair)
if test -d /soft/linux/pkg/bin ; then
  export PATH=/soft/linux/pkg/bin:${PATH};
  export PATH=/soft/lus/linux/vim/7.4-$(uname -m)/bin:$PATH;
fi

# clean up duplicate paths
typeset -U PATH

# List directory when changing (github/r00k)
chpwd() {
  ls -lvh --color=auto
}

# Larger history
HISTSIZE=20000
HISTFILE=~/.zsh_history
SAVEHIST=20000

# Make sure C-s works in vim
stty start undef
stty stop undef

# load zprezto
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Aliases/Functions files
source $HOME/.aliases
source $HOME/.functions

if [[ "$OSTYPE" == darwin* ]]; then
  source $HOME/.aliases-mac
fi

# Bind insert_sudo function
zle -N insert-sudo
bindkey "^z" insert-sudo

# make 256colors work maybe
if [ $TERM="xterm" ]; then
  export TERM=xterm-256color
fi

# default editor is vim
export EDITOR='vim'

# init rbenv
if test -d "$HOME/.rbenv/bin"; then
  eval "$(rbenv init -)"
fi

# load nvm
if test -d "$NVM_DIR"; then
  source "$NVM_DIR/nvm.sh"
fi
