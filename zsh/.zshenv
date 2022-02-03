ZDOTDIR=$HOME/.config/zsh

PERSONAL_BIN_PATH="$HOME/bin"
PERSONAL_FPATH="$ZDOTDIR/completions"

NODENV_PATH="$HOME/.nodenv/bin"
RBENV_PATH="$HOME/.rbenv/bin"

if [[ "$OSTYPE" == darwin* ]]; then
  HOMEBREW_PREFIX="/opt/homebrew"
  HOMEBREW_CELLAR="/opt/homebrew/Cellar"
  HOMEBREW_REPOSITORY="/opt/homebrew"

  GNU_SED_PATH="/opt/homebrew/opt/gnu-sed/libexec/gnubin"
  GNU_TOOLS_PATH="/opt/homebrew/opt/coreutils/libexec/gnubin"
  GNU_TOOLS_MAN_PATH="/opt/homebrew/opt/coreutils/libexec/gnuman"

  PATH="/usr/local/bin:/Library/Apple/usr/bin:$PATH"

  PATH="/opt/homebrew/bin:/opt/homebrew/sbin${PATH+:$PATH}";
  MANPATH="/opt/homebrew/share/man${MANPATH+:$MANPATH}:";
  INFOPATH="/opt/homebrew/share/info:${INFOPATH:-}";

  [[ -d "$GNU_SED_PATH" ]] && PATH="$GNU_SED_PATH:$PATH"
  [[ -d "$GNU_TOOLS_PATH" ]] && PATH="$GNU_TOOLS_PATH:$PATH"
  [[ -d "$GNU_TOOLS_MAN_PATH" ]] && MANPATH="$GNU_TOOLS_MAN_PATH:$MANPATH"
fi

[[ -d "$RBENV_PATH" ]] && PATH="$RBENV_PATH:$PATH"
[[ -d "$NODENV_PATH" ]] && PATH="$NODENV_PATH:$PATH"
[[ -d "$PERSONAL_BIN_PATH" ]] && PATH="$PERSONAL_BIN_PATH:$PATH"
[[ -d "$PERSONAL_FPATH" ]] && FPATH="$PERSONAL_FPATH:$FPATH"

# EDITOR
EDITOR=vim
GIT_EDITOR=vim

# Don't let Debian distributions run compinit
skip_global_compinit=1
