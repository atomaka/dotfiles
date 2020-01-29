source ~/.bash_environment

GPG_TTY=$(tty)
export GPG_TTY

# clean up duplicate paths

# Larger history
HISTSIZE=20000
HISTFILE=~/.bash_history
SAVEHIST=20000

# Aliases/Functions files
source $HOME/.aliases
source $HOME/.functions

if [[ "$OSTYPE" == darwin* ]]; then
  source $HOME/.aliases-mac
fi

# Promp
source $HOME/.bash/prompt

# Bind insert_sudo function

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

set -o vi

# clean up duplicate paths
#typeset -U PATH
