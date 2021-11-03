NODENV_PATH="$HOME/.nodenv/bin"
RBENV_PATH="$HOME/.rbenv/bin"

LOCAL_HOME_BIN_PATH="$HOME/.local/bin"
PERSONAL_BIN_PATH="$HOME/bin"
PERSONAL_COMPLETIONS_PATH="$HOME/.zsh-completions"

GNU_TOOLS_PATH="/opt/homebrew/opt/coreutils/libexec/gnubin"
GNU_TOOLS_MAN_PATH="/opt/homebrew/opt/coreutils/libexec/gnuman"

if [[ "$OSTYPE" == darwin* ]]; then
  export HOMEBREW_PREFIX="/opt/homebrew";
  export HOMEBREW_CELLAR="/opt/homebrew/Cellar";
  export HOMEBREW_REPOSITORY="/opt/homebrew";

  export PATH="/opt/homebrew/bin:/opt/homebrew/sbin${PATH+:$PATH}";
  export MANPATH="/opt/homebrew/share/man${MANPATH+:$MANPATH}:";
  export INFOPATH="/opt/homebrew/share/info:${INFOPATH:-}";

  GO_DIR="/usr/local/opt/go/libexec"
else
  GO_DIR="/usr/local/go/bin"
fi

# BIN
[[ -d "$RBENV_PATH" ]] && PATH="$RBENV_PATH:$PATH"
[[ -d "$NODENV_PATH" ]] && PATH="$NODENV_PATH:$PATH"

[[ -d "$LOCAL_HOME_BIN_PATH" ]] && PATH="$LOCAL_HOME_BIN_PATH:$PATH"
[[ -d "$PERSONAL_BIN_PATH" ]] && PATH="$PERSONAL_BIN_PATH:$PATH"

[[ -d "$GNU_TOOLS_PATH" ]] && PATH="$GNU_TOOLS_PATH:$PATH"
[[ -d "$GNU_TOOLS_MAN_PATH" ]] && MANPATH="$GNU_TOOLS_MAN_PATH:$MANPATH"
[[ -d "$PERSONAL_COMPLETIONS_PATH" ]] && fpath=($PERSONAL_COMPLETIONS_PATH $fpath)

# EDITOR
export {EDITOR,GIT_EDITOR}=vim
