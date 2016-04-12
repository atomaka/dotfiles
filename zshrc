[[ -d "$GNU_TOOLS_PATH" ]] && PATH="$GNU_TOOLS_PATH:$PATH"
[[ -d "$GNU_TOOLS_MAN_PATH" ]] && MANPATH="$GNU_TOOLS_MAN_PATH:$MANPATH"

# clean up duplicate paths
typeset -U PATH

# Larger history
HISTSIZE=20000
HISTFILE=~/.zsh_history
SAVEHIST=20000

# Make sure C-s works in vim
stty start undef
stty stop undef

# Aliases/Functions files
source $HOME/.aliases
source $HOME/.functions

source $HOME/.zsh/prompt
source $HOME/.zsh/completion

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
if test -d "$HOME/.rbenv"; then
  eval "$(rbenv init -)"
fi

# load nvm
if test -d "$NVM_DIR"; then
  source "$NVM_DIR/nvm.sh"
fi
