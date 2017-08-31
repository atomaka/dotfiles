LOCAL_SBIN_PATH="/usr/local/sbin"
PERSONAL_BIN_PATH="$HOME/bin"
RBENV_PATH="$HOME/.rbenv/bin"
GNU_TOOLS_PATH="/usr/local/opt/coreutils/libexec/gnubin"
GNU_TOOLS_MAN_PATH="/usr/local/opt/coreutils/libexec/gnuman"
APACHE_MAVEN_PATH="$HOME/bin/apache-maven-3.3.9/bin"

if [[ "$OSTYPE" == darwin* ]]; then
  GO_DIR="/usr/local/opt/go/libexec"
else
  GO_DIR="/usr/local/go/bin"
fi

if [[ "$OSTYPE" == darwin* ]]; then
  NVM_DIR="/usr/local/opt/nvm"
else
  NVM_DIR="/home/atomaka/.nvm"
fi

# BIN
[[ -d "$PERSONAL_BIN_PATH" ]] && PATH="$PERSONAL_BIN_PATH:$PATH"
[[ -d "$RBENV_PATH" ]] && PATH="$RBENV_PATH:$PATH"
[[ -d "$GNU_TOOLS_PATH" ]] && PATH="$GNU_TOOLS_PATH:$PATH"
[[ -d "$APACHE_MAVEN_PATH" ]] && PATH="$APACHE_MAVEN_PATH:$PATH"
[[ -d "$GO_DIR" ]] && PATH="$GO_DIR:$PATH"
[[ -d "$LOCAL_SBIN_PATH" ]] && PATH="$LOCAL_SBIN_PATH:$PATH"

# MAN
[[ -d "$GNU_TOOLS_MAN_PATH" ]] && MANPATH="$GNU_TOOLS_MAN_PATH:$MANPATH"

# EDITOR
if [[ -x "$(command -v nvim)" ]]; then
  export {EDITOR,GIT_EDITOR}=nvim
else
  export {EDITOR,GIT_EDITOR}=vim
fi


export GOPATH="$HOME/go-workspace/"
