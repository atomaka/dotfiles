PERSONAL_BIN_PATH="$HOME/bin"
RBENV_PATH="$HOME/.rbenv/bin"
GNU_TOOLS_PATH="/usr/local/opt/coreutils/libexec/gnubin"
GNU_TOOLS_MAN_PATH="/usr/local/opt/coreutils/libexec/gnuman"

[[ -d "$PERSONAL_BIN_PATH" ]] && PATH="$PERSONAL_BIN_PATH:$PATH"
[[ -d "$RBENV_PATH" ]] && PATH="$RBENV_PATH:$PATH"
[[ -d "$GNU_TOOLS_PATH" ]] && PATH="$GNU_TOOLS_PATH:$PATH"
[[ -d "$GNU_TOOLS_MAN_PATH" ]] && MANPATH="$GNU_TOOLS_MAN_PATH:$MANPATH"
