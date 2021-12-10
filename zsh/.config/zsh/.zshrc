typeset -U PATH

source $ZDOTDIR/aliases
source $ZDOTDIR/functions

source $ZDOTDIR/prompt

# Larger history
HISTSIZE=20000
HISTFILE=~/.zsh_history
SAVEHIST=20000

# be like vim
bindkey -v

zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

setopt auto_cd

if which direnv > /dev/null; then
  eval "$(direnv hook zsh)"
fi

if which rbenv > /dev/null; then
  eval "$(rbenv init --no-rehash -)"
  (rbenv rehash &) 2> /dev/null
fi

if which nodenv > /dev/null; then
  eval "$(nodenv init --no-rehash -)"
  (nodenv rehash &) 2> /dev/null
fi
