GPG_TTY=$(tty)
export GPG_TTY

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

if [[ "$OSTYPE" == darwin* ]]; then
  source $HOME/.aliases-mac
fi

# vim mode
bindkey -v

# Bind insert_sudo function
zle -N insert-sudo
bindkey "^z" insert-sudo

# init rbenv
if which rbenv > /dev/null; then
  eval "$(rbenv init --no-rehash -)"
  (rbenv rehash &) 2> /dev/null
fi

# init nodenv
if which nodenv > /dev/null; then
  eval "$(nodenv init --no-rehash -)"
  (nodenv rehash &) 2> /dev/null
fi

#  init direnv
if which direnv > /dev/null; then
  eval "$(direnv hook zsh)"
fi

# completion
autoload -U compinit
autoload bashcompinit && bashcompinit

autoload compinit -Uz
setopt EXTENDEDGLOB
if [[ -n ${ZDOTDIR}/.zcompdump(#qN.mh+24) ]]; then
  compinit
else
  compinit -C
fi
unsetopt EXTENDEDGLOB

setopt completeinword
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

# directory
setopt auto_cd

# better word definition
autoload -U select-word-style
select-word-style bash

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
