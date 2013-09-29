# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="gnzh"

PATH="$HOME/bin:$PATH"

if [[ "$OSTYPE" == darwin* ]]; then
  PATH="/opt/boxen/homebrew/opt/coreutils/libexec/gnubin:$PATH"
  MANPATH="/opt/boxen/homebrew/apt/coreutils/libexec/gnubin:$MANPATH"
else
  export PATH="$HOME/.rvenv/bin:$PATH"
fi

if test -d /soft/linux/pkg/bin ; then
  export PATH=/soft/linux/pkg/bin:${PATH};
  export PATH=/soft/lus/linux/vim/7.4-$(uname -m)/bin:$PATH;
fi

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

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable bi-weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment to change how often before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want to disable command autocorrection
# DISABLE_CORRECTION="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Uncomment following line if you want to disable marking untracked files under
# VCS as dirty. This makes repository status check for large repositories much,
# much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git rbenv)

source $ZSH/oh-my-zsh.sh

# Aliases/Functions files
source $HOME/.aliases
source $HOME/.functions

# Add personal bin folder
PATH=$PATH:$HOME/bin

# Customize to your needs...

# Bind insert_sudo function
zle -N insert-sudo
bindkey "^z" insert-sudo

# make 256colors work maybe
if [ $TERM="xterm" ]; then
  export TERM=xterm-256color
fi

export EDITOR='vim'

if [[ "$OSTYPE" == darwin* ]]; then
  source /opt/boxen/env.sh
else
  eval "$(rbenv init -)"
fi
