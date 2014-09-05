# home bin directory
ZSH=$HOME/.oh-my-zsh
# custom directory to load .oh-my-zsh files from
ZSH_CUSTOM="$HOME/.zsh"
ZSH_THEME="atomaka" # gnzh, candy, crunch, geoffgarside, macovsky

PATH="$HOME/bin:$PATH"

if [[ "$OSTYPE" == darwin* ]]; then
  PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
  MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"
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

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git rbenv)

source $ZSH/oh-my-zsh.sh

# Aliases/Functions files
source $HOME/.aliases
source $HOME/.functions

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
if test -d "$HOME/.rbenv/bin" ; then
  eval "$(rbenv init -)"
fi

export NVM_DIR="/Users/atomaka/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
