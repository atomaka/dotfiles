export GPG_TTY=$(tty)

typeset -U PATH

source $ZDOTDIR/aliases
source $ZDOTDIR/functions

for source in $(ls $ZDOTDIR/sources); do
  source $ZDOTDIR/sources/$source
done

source $ZDOTDIR/prompt

# Larger history
HISTSIZE=20000
HISTFILE=~/.zsh_history
SAVEHIST=20000

# be like vim
bindkey -v

setopt complete_in_word
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

setopt auto_cd

if which mise > /dev/null; then
  eval "$(mise activate zsh)"
fi

autoload compinit -Uz
setopt EXTENDEDGLOB
if [[ -n ${ZDOTDIR}/.zcompdump(#qN.m+1) ]]; then
  compinit
else
  compinit -C
fi
unsetopt EXTENDEDGLOB

[ -f $XDG_CONFIG_HOME/fzf/fzf.zsh ] && source $XDG_CONFIG_HOME/fzf/fzf.zsh
