PERSONAL_BIN_PATH="$HOME/bin"
RBENV_PATH="$HOME/.rbenv/bin"
GNU_TOOLS_PATH="/usr/local/opt/coreutils/libexec/gnubin"
GNU_TOOLS_MAN_PATH="/usr/local/opt/coreutils/libexec/gnuman"
GO_PATH="/usr/local/go/bin"

if [[ "$OSTYPE" == darwin* ]]; then
  NVM_DIR="/usr/local/opt/nvm"
else
  NVM_DIR="/home/atomaka/.nvm"
fi
APACHE_MAVEN_PATH="$HOME/bin/apache-maven-3.3.9/bin"

# BIN
[[ -d "$PERSONAL_BIN_PATH" ]] && PATH="$PERSONAL_BIN_PATH:$PATH"
[[ -d "$RBENV_PATH" ]] && PATH="$RBENV_PATH:$PATH"
[[ -d "$GNU_TOOLS_PATH" ]] && PATH="$GNU_TOOLS_PATH:$PATH"
[[ -d "$APACHE_MAVEN_PATH" ]] && PATH="$APACHE_MAVEN_PATH:$PATH"
[[ -d "$GO_PATH" ]] && PATH="$GO_PATH:$PATH"

# MAN
[[ -d "$GNU_TOOLS_MAN_PATH" ]] && MANPATH="$GNU_TOOLS_MAN_PATH:$MANPATH"

export JAVA_HOME=/usr/lib/jvm/java-7-openjdk-amd64
export GOPATH="$HOME/.go/"
